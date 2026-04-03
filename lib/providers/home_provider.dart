import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

/// Provider to track selected home tab (0-3)
/// 0 = Home
/// 1 = Browse
/// 2 = Chat
/// 3 = Profile
final selectedHomeTabProvider = StateProvider<int>((ref) => 0);
