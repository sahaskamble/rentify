import 'package:flutter/material.dart';
import '../models/listing_model.dart';
import '../theme/app_colors.dart';

const List<ListingModel> mockListings = [
  ListingModel(
    id: '1',
    title: 'Honda Activa',
    price: '₹9/hr',
    distance: '3.9 km',
    badge: 'Verified',
    badgeColor: AppColors.badgeVerified,
    imageColor: AppColors.primaryLight,
    icon: Icons.two_wheeler,
  ),
  ListingModel(
    id: '2',
    title: 'DSLR Camera',
    price: '₹500/day',
    distance: '8.8 km',
    badge: 'Top-rated',
    badgeColor: AppColors.badgeTopRated,
    imageColor: const Color(0xFFEEF2FF),
    icon: Icons.camera_alt,
  ),
  ListingModel(
    id: '3',
    title: 'Royal Enfield',
    price: '₹15/hr',
    distance: '1.2 km',
    badge: 'Verified',
    badgeColor: AppColors.badgeVerified,
    imageColor: const Color(0xFFF3F4F6),
    icon: Icons.two_wheeler,
  ),
  ListingModel(
    id: '4',
    title: 'Xbox Console',
    price: '₹50/day',
    distance: '5.5 km',
    badge: 'Top-rated',
    badgeColor: AppColors.badgeTopRated,
    imageColor: const Color(0xFFF0FDF4),
    icon: Icons.sports_esports,
  ),
];

const List<Map<String, String>> categories = [
  {'icon': '🏍️', 'label': 'Bikes'},
  {'icon': '📷', 'label': 'Camera'},
  {'icon': '🌱', 'label': 'Sapling'},
  {'icon': '🪑', 'label': 'Furniture'},
  {'icon': '🔧', 'label': 'Tools'},
  {'icon': '🎮', 'label': 'Gaming'},
  {'icon': '💻', 'label': 'Electronics'},
];
