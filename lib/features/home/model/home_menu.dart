import 'package:flutter/material.dart';

enum HomeMenuType {
  outlet,
  promotion,
}

class HomeMenu {
  final String title;
  final IconData icon;
  final VoidCallback? onTap;
  final String? iconPath;

  HomeMenu(
      {required this.title, required this.icon, this.onTap, this.iconPath});
}
