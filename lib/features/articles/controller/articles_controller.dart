import 'package:gibas/core/utils/debouncer.dart';
import 'package:gibas/domain/models/base_model.dart';
import 'package:gibas/domain/models/base_params.dart';
import 'package:gibas/features/global/model/article.dart';
import 'package:gibas/features/global/model/article_response.dart';
import 'package:gibas/features/global/repository/global_repository.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class ArticlesController extends GetxController with StateMixin<List<Article>> {
  BaseModel? selectedFilter;
  final PagingController<int, Article> pagingController =
      PagingController(firstPageKey: 1);
  final BaseParams params = BaseParams();
  final Debouncer debouncer = Debouncer(milliseconds: 500);
  final int _pageSize = 10; // ✅ jumlah artikel per page (samakan dengan API)

  @override
  void onInit() {
    super.onInit();
    change(null, status: RxStatus.loading()); // ⬅️ set loading dulu
    pagingController.addPageRequestListener((pageKey) {
      fetchArticle(pageKey);
    });
    // fetchArticle(1);
  }

  Future<void> fetchArticle(int pageKey) async {
    try {
      final repository = GlobalRepository();
      final result = await repository.listArticle(
        page: pageKey,
        perPage: _pageSize,
        q: params.name,
      );

      // kalau API balikin success tapi data kosong
      if (result.data != null && (result.data!.values.isEmpty)) {
        if (pageKey == 1) {
          pagingController
              .appendLastPage([]); // biar trigger noItemsFoundIndicatorBuilder
        } else {
          pagingController.appendLastPage([]);
        }
        return;
      }

      // kalau gagal beneran
      if (!result.isSuccess || result.data == null) {
        // cek kalau message-nya "Data kosong" jangan dianggap error
        if (result.message?.toLowerCase().contains("kosong") ?? false) {
          pagingController.appendLastPage([]);
          return;
        }

        pagingController.error = result.message ?? "Gagal memuat artikel";
        return;
      }

      // --- kalau sukses ada data ---
      final response = result.data!;
      final newItems = response.values;

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
      pagingController.refresh(); // reload dari page 1
    });
  }

  // @override
  // void onClose() {
  //   pagingController.dispose();
  //   super.onClose();
  // }
}
