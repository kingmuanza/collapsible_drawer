import 'package:flutter/material.dart';

class SideItem {
  final IconData icon;
  final String label;
  final int? badge;
  final VoidCallback onTap;

  SideItem({
    required this.icon,
    required this.label,
    required this.onTap,
    this.badge,
  });
}
