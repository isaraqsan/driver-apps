import 'package:gibas/core/utils/debouncer.dart';
import 'package:gibas/domain/models/base_model.dart';
import 'package:gibas/domain/models/base_params.dart';
import 'package:get/get.dart';
import 'package:gibas/features/notification/model/notification_model.dart';
import 'package:gibas/features/notification/repository/notification_repository.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class NotificationController extends GetxController {
  final PagingController<int, NotifItem> pagingController =
      PagingController(firstPageKey: 1);
  final BaseParams params = BaseParams();
  final Debouncer debouncer = Debouncer(milliseconds: 500);
  final int _pageSize = 10;

  @override
  void onInit() {
    super.onInit();
    pagingController.addPageRequestListener(fetchNotif);
  }

  Future<void> fetchNotif(int pageKey) async {
    try {
      final repository = NotificationRepository();
      final result = await repository.listNotification(
        params: BaseParams(
          page: pageKey,
          perPage: _pageSize.toString(),
          name: params.name,
        ),
      );

      if (!result.isSuccess || result.data == null) {
        pagingController.error = result.message ?? "Gagal memuat notifikasi";
        return;
      }

      final response = result.data!;
      final newItems = response.values ?? [];

      final isLastPage = (pageKey * _pageSize) >= response.total;
      if (isLastPage) {
        pagingController.appendLastPage(newItems);
      } else {
        pagingController.appendPage(newItems, pageKey + 1);
      }
    } catch (e) {
      pagingController.error = e;
    }
  }

  void onSearch(String? value) {
    debouncer.run(() {
      params.name = value;
      pagingController.refresh();
    });
  }

  @override
  void onClose() {
    pagingController.dispose();
    super.onClose();
  }
}
