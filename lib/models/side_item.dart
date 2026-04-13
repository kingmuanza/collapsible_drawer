import 'package:flutter/material.dart';

class SideItem {
  final IconData icon;
  final String label;
  final int? badge;
  final VoidCallback onTap;
  final bool withDivider;

  SideItem({
    required this.icon,
    required this.label,
    required this.onTap,
    this.badge,
    this.withDivider = false,
  });
}
