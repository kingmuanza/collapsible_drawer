import 'package:flutter/material.dart';

class SideItem {
  final IconData icon;
  final String label;
  final int? badge;
  final VoidCallback onTap;
  final bool isDivider;

  SideItem({
    required this.icon,
    required this.label,
    required this.onTap,
    this.badge,
    this.isDivider = false,
  });
}

class SideItemDivider {
  final int? height;
  final Color? color;

  SideItemDivider({
    this.height,
    this.color,
  });
}
