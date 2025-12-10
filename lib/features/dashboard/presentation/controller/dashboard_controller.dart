import 'package:gibas/features/home/view/home_view.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart' show Widget, SizedBox;
import 'package:gibas/core/app/constant/icons_path.dart';
import 'package:gibas/core/app/constant/role.dart';
import 'package:gibas/core/app/controller/auth_controller.dart';
import 'package:gibas/core/utils/utils.dart';
import 'package:gibas/features/dashboard/model/dashboard_item.dart';
import 'package:get/get.dart';
import 'package:gibas/features/notification/view/notification_view.dart';
import 'package:gibas/features/profile/view/profile_view.dart';
import 'package:gibas/shared/view/coming_soon_view.dart';
import 'package:gibas/shared/view/coming_soon_widget.dart';

class DashboardController extends GetxController
    with StateMixin<List<DashboardItem>> {
  final snackBarDuration = const Duration(seconds: 3);
  DateTime? backButtonPressTime;
  int index = 0;
  final List<Widget> pages = [];

  @override
  void onReady() {
    setup();
    super.onReady();
  }

  void setup() {
    final List<DashboardMenuType> listMenu = [];
    if (listMenu.isEmpty) {
      listMenu.addAll([
        DashboardMenuType.home,
        DashboardMenuType.notification,
        DashboardMenuType.message,
        DashboardMenuType.profile,
      ]);
    }

    final List<DashboardItem> items = listMenu.map((menu) {
      final item = dashboardItem(menu);
      pages.add(item.page);
      return item.copyWith(page: const SizedBox());
    }).toList();

    change(items, status: RxStatus.success());
  }

  DashboardItem dashboardItem(DashboardMenuType type) {
    return switch (type) {
      DashboardMenuType.home => DashboardItem(
          title: 'Home',
          icon: IconsPath.menuDashboardHome,
          menu: DashboardMenuType.homePar,
          page: const HomeView(),
        ),
      DashboardMenuType.message => DashboardItem(
          title: 'Message',
          icon: IconsPath.menuChat,
          menu: DashboardMenuType.message,
          page: const ComingSoonView(),
        ),
      DashboardMenuType.homePar => DashboardItem(
          title: 'Home',
          icon: IconsPath.menuDashboardHome,
          menu: DashboardMenuType.homePar,
          page: const HomeView(),
        ),
      DashboardMenuType.homeMrc => DashboardItem(
          title: 'Home',
          icon: IconsPath.menuDashboardHome,
          menu: DashboardMenuType.homeMrc,
          page: const HomeView(),
        ),
      DashboardMenuType.visit => DashboardItem(
          title: 'Visit',
          icon: IconsPath.menuDashboardVisit,
          menu: DashboardMenuType.visit,
          page: const HomeView(),
        ),
      DashboardMenuType.report => DashboardItem(
          title: 'Report',
          icon: IconsPath.menuDashboardReport,
          menu: DashboardMenuType.report,
          page: const ComingSoonWidget(),
        ),
      DashboardMenuType.profile => DashboardItem(
          title: 'Profile',
          icon: IconsPath.menuDashboardProfile,
          menu: DashboardMenuType.profile,
          page: const ComingSoonView(),
        ),
      DashboardMenuType.history => DashboardItem(
          title: 'History',
          icon: IconsPath.menuDashboardReport,
          menu: DashboardMenuType.profile,
          page: const ProfileView(),
        ),
      DashboardMenuType.trackStaff => DashboardItem(
          title: 'Lacak',
          icon: IconsPath.menuDashboardVisit,
          menu: DashboardMenuType.trackStaff,
          page: const HomeView(),
        ),
      DashboardMenuType.notification => DashboardItem(
          title: 'Notification',
          icon: IconsPath.menuDashboardNotification,
          menu: DashboardMenuType.notification,
          page: const ComingSoonView(),
        ),
    };
  }

  void changeTab(int value) {
    index = value;
    update();
  }

  Future<void> onPopInvokedWithResult<T>(bool didPop, T? result) async {
    if (didPop) return;
    final now = DateTime.now();
    final backButtonHasNotBeenPressedOrSnackBarHasBeenClosed =
        backButtonPressTime == null ||
            now.difference(backButtonPressTime!) > snackBarDuration;
    if (backButtonHasNotBeenPressedOrSnackBarHasBeenClosed) {
      backButtonPressTime = now;
      Utils.toast('Tekan sekali lagi untuk keluar', snackType: SnackType.info);
    } else {
      SystemNavigator.pop();
    }
  }
}
