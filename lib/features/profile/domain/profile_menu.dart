import 'package:flutter/widgets.dart';

enum ProfileMenuKey {
  edit,
  fAQ,
  feedback,
  help,
  info,
  logout,
  password,
  pjp,
  rate,
  settings,
  terms,
}

class ProfileMenu {
  String title;
  IconData icon;
  ProfileMenuKey profileMenuKey;

  ProfileMenu({required this.title, required this.icon, required this.profileMenuKey});
}
