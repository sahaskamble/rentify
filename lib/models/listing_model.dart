import 'package:flutter/material.dart';

class ListingModel {
  final String id;
  final String title;
  final String price;
  final String distance;
  final String badge;
  final Color badgeColor;
  final Color imageColor;
  final IconData icon;

  const ListingModel({
    required this.id,
    required this.title,
    required this.price,
    required this.distance,
    required this.badge,
    required this.badgeColor,
    required this.imageColor,
    required this.icon,
  });
}
