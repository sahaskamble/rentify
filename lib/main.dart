import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rentify/generated/pocketbase/listings_record.dart';
import 'package:rentify/providers/auth_provider.dart';
import 'package:rentify/screens/auth/auth_gate.dart';
import 'package:rentify/services/listing_service.dart';
import 'package:rentify/theme/app_theme.dart';

void main() {
  runApp(const ProviderScope(child: MainApp()));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      title: 'Rentify',
      home: const AuthGate(),
    );
  }
}

class ListinsScreen extends ConsumerStatefulWidget {
  const ListinsScreen({super.key});

  @override
  ConsumerState<ListinsScreen> createState() => _ListinsScreenState();
}

class _ListinsScreenState extends ConsumerState<ListinsScreen> {
  final service = ListingService();
  late Future<List<ListingsRecord>> future;

  @override
  void initState() {
    super.initState();
    future = service.getListings();
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authStateProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          authState.user?.name?.trim().isNotEmpty == true
              ? 'Welcome, ${authState.user!.name!.trim()}'
              : 'Rentify Listings',
        ),
        actions: [
          IconButton(
            tooltip: 'Logout',
            onPressed: () => ref.read(authStateProvider.notifier).logout(),
            icon: const Icon(Icons.logout_rounded),
          ),
        ],
      ),
      body: FutureBuilder<List<ListingsRecord>>(
        future: future,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          final listings = snapshot.data!;
          return ListView.builder(
            itemCount: listings.length,
            itemBuilder: (context, index) {
              final item = listings[index];
              return ListTile(
                title: Text(item.title.isEmpty ? "No Title" : item.title),
                subtitle: Column(
                  children: [
                    Text("₹${item.pricePerDay} / day"),
                    Text("₹${item.pricePerWeek} / week"),
                    Text("₹${item.pricePerMonth} / month"),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
