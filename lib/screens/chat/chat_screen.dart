import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pocketbase/pocketbase.dart';
import 'package:rentify/providers/auth_provider.dart';
import 'package:rentify/services/listing_service.dart';
import 'package:rentify/theme/app_theme.dart';

final conversationsProvider = FutureProvider<List<RecordModel>>((ref) async {
  final user = ref.watch(authStateProvider).user;
  if (user == null) return [];
  final pb = ListingService().pb;
  final result = await pb.collection('conversations').getList(
    filter: "(renter = '${user.id}' || seller = '${user.id}') && is_active = true",
    sort: '-last_message_at',
    expand: 'listing,renter,seller',
    perPage: 200,
  );
  return result.items;
});

class ChatScreen extends ConsumerWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final conversations = ref.watch(conversationsProvider);
    final me = ref.watch(authStateProvider).user;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Messages', style: TextStyle(fontWeight: FontWeight.w700, color: AppColors.ink)),
        backgroundColor: AppColors.surface,
        surfaceTintColor: Colors.transparent,
      ),
      body: me == null
          ? const Center(child: Text('Not authenticated'))
          : conversations.when(
              data: (items) {
                if (items.isEmpty) {
                  return const Center(
                    child: Text('No conversations yet. Start by renting an item!', style: TextStyle(color: AppColors.muted)),
                  );
                }

                return RefreshIndicator(
                  onRefresh: () async => ref.refresh(conversationsProvider.future),
                  child: ListView.builder(
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      final convo = items[index];
                      final isRenter = convo.getStringValue('renter') == me.id;
                      final other = isRenter
                          ? convo.expand['seller']?.firstOrNull
                          : convo.expand['renter']?.firstOrNull;
                      final listing = convo.expand['listing']?.firstOrNull;
                      final unread = isRenter
                          ? (convo.data['renter_unread_count'] ?? 0) as num
                          : (convo.data['seller_unread_count'] ?? 0) as num;
                      final otherName = (other?.data['name'] as String?) ?? 'User';
                      return ListTile(
                        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        leading: CircleAvatar(
                          backgroundColor: AppColors.surfaceTint,
                          child: Text(_initials(otherName), style: const TextStyle(color: AppColors.ink)),
                        ),
                        title: Text(
                          listing?.data['title']?.toString() ?? 'Conversation',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(fontWeight: FontWeight.w700, color: AppColors.ink),
                        ),
                        subtitle: Text(
                          (convo.data['last_message'] as String?) ?? 'Tap to chat',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        trailing: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(_relativeTime(convo.data['last_message_at']?.toString())),
                            const SizedBox(height: 6),
                            if (unread > 0)
                              Container(
                                width: 10,
                                height: 10,
                                decoration: const BoxDecoration(
                                  color: AppColors.primary,
                                  shape: BoxShape.circle,
                                ),
                              ),
                          ],
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => ChatConversationScreen(
                                conversationId: convo.id,
                                otherUserName: otherName,
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (_, __) => Center(
                child: ElevatedButton(
                  onPressed: () => ref.invalidate(conversationsProvider),
                  child: const Text('Retry'),
                ),
              ),
            ),
    );
  }
}

class ChatConversationScreen extends ConsumerStatefulWidget {
  const ChatConversationScreen({
    super.key,
    required this.conversationId,
    required this.otherUserName,
  });

  final String conversationId;
  final String otherUserName;

  @override
  ConsumerState<ChatConversationScreen> createState() => _ChatConversationScreenState();
}

class _ChatConversationScreenState extends ConsumerState<ChatConversationScreen> {
  final _controller = TextEditingController();
  final _scrollController = ScrollController();
  List<RecordModel> _messages = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetch();
    _subscribe();
  }

  Future<void> _fetch() async {
    final pb = ListingService().pb;
    final result = await pb.collection('messages').getList(
      filter: "conversation = '${widget.conversationId}'",
      sort: 'created',
      perPage: 200,
      expand: 'sender',
    );
    if (!mounted) return;
    setState(() {
      _messages = result.items;
      _isLoading = false;
    });
    _jumpToBottom();
  }

  Future<void> _subscribe() async {
    final pb = ListingService().pb;
    await pb.collection('messages').subscribe('*', (e) {
      final record = e.record;
      if (record == null) return;
      if (record.getStringValue('conversation') != widget.conversationId) return;
      _fetch();
    }, filter: "conversation = '${widget.conversationId}'");
  }

  void _jumpToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
      }
    });
  }

  Future<void> _send() async {
    final me = ref.read(authStateProvider).user;
    final text = _controller.text.trim();
    if (me == null || text.isEmpty) return;

    final pb = ListingService().pb;
    _controller.clear();
    await pb.collection('messages').create(body: {
      'conversation': widget.conversationId,
      'sender': me.id,
      'content': text,
      'message_type': 'text',
      'is_read': false,
    });
    await pb.collection('conversations').update(widget.conversationId, body: {
      'last_message': text,
      'last_message_at': DateTime.now().toIso8601String(),
    });
  }

  @override
  void dispose() {
    ListingService().pb.collection('messages').unsubscribe('*');
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final me = ref.watch(authStateProvider).user;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(widget.otherUserName, style: const TextStyle(color: AppColors.ink)),
        backgroundColor: AppColors.surface,
      ),
      body: Column(
        children: [
          Expanded(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : ListView.builder(
                    controller: _scrollController,
                    padding: const EdgeInsets.all(16),
                    itemCount: _messages.length,
                    itemBuilder: (context, index) {
                      final msg = _messages[index];
                      final mine = msg.getStringValue('sender') == me?.id;
                      return Align(
                        alignment: mine ? Alignment.centerRight : Alignment.centerLeft,
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 10),
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                          constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.75),
                          decoration: BoxDecoration(
                            color: mine ? AppColors.primary : AppColors.surface,
                            borderRadius: BorderRadius.circular(12),
                            border: mine ? null : Border.all(color: AppColors.border),
                          ),
                          child: Text(
                            msg.getStringValue('content'),
                            style: TextStyle(color: mine ? Colors.white : AppColors.ink),
                          ),
                        ),
                      );
                    },
                  ),
          ),
          SafeArea(
            top: false,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(12, 8, 12, 12),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      minLines: 1,
                      maxLines: 4,
                      decoration: const InputDecoration(hintText: 'Type a message...'),
                    ),
                  ),
                  IconButton(onPressed: _send, icon: const Icon(Icons.send, color: AppColors.primary)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

String _relativeTime(String? value) {
  if (value == null || value.isEmpty) return '';
  final dt = DateTime.tryParse(value)?.toLocal();
  if (dt == null) return '';
  final diff = DateTime.now().difference(dt);
  if (diff.inMinutes < 1) return 'Now';
  if (diff.inMinutes < 60) return '${diff.inMinutes}m ago';
  if (diff.inHours < 24) return '${diff.inHours}h ago';
  if (diff.inDays == 1) return 'Yesterday';
  return '${diff.inDays}d ago';
}

String _initials(String name) {
  final parts = name.trim().split(' ');
  if (parts.isEmpty) return 'U';
  if (parts.length == 1) return parts.first[0].toUpperCase();
  return '${parts.first[0]}${parts.last[0]}'.toUpperCase();
}

extension on List<RecordModel> {
  RecordModel? get firstOrNull => isEmpty ? null : first;
}
