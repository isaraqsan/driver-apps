enum DashboardMenuType {
  home,
  homePar,
  homeMrc,
  visit,
  history,
  notification,
  profile,
  report,
  trackStaff,
  message
}

class DashboardItem {
  String icon;
  String title;
  DashboardMenuType menu;
  dynamic page;

  DashboardItem({
    required this.icon,
    required this.title,
    required this.menu,
    required this.page,
  });

  DashboardItem copyWith({
    String? icon,
    String? title,
    DashboardMenuType? menu,
    dynamic page,
  }) {
    return DashboardItem(
      icon: icon ?? this.icon,
      title: title ?? this.title,
      menu: menu ?? this.menu,
      page: page ?? this.page,
    );
  }
}
