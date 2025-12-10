import 'package:flutter/material.dart';
import 'package:gibas/core/app/constant.dart';
import 'package:gibas/core/utils/debouncer.dart';
import 'package:gibas/core/utils/log.dart';
import 'package:gibas/domain/models/base_model.dart';
import 'package:gibas/domain/models/base_params.dart';
import 'package:gibas/features/approval/repository/approval_repository.dart';
import 'package:gibas/features/approval/view/approval_view.dart';
import 'package:gibas/features/global/model/resource_response.dart';
import 'package:gibas/features/global/repository/global_repository.dart';
import 'package:gibas/features/member/bottomsheet/card_bottomsheet.dart';
import 'package:gibas/features/member/model/member.dart';
import 'package:gibas/features/member/repository/promotion_repository.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class ListApprovalController extends GetxController {
  late ApprovalRepository approvalRepository;
  List<BaseModel> optionsFilter = [
    BaseModel(id: Constant.statusAll, name: 'Semua'),
    BaseModel(id: Constant.statusImplemented, name: 'Sudah Di Setujui'),
    BaseModel(id: Constant.statusNotImplemented, name: 'Belum Di Setujui'),
  ];
  BaseModel? selectedFilter;
  final PagingController<int, Resource> pagingController =
      PagingController(firstPageKey: 1);
  final BaseParams params = BaseParams();
  final Debouncer debouncer = Debouncer(milliseconds: 500);

  @override
  void onInit() {
    super.onInit();
    approvalRepository = ApprovalRepository();
    selectedFilter = optionsFilter.first;

    pagingController.addPageRequestListener(fetchMember);
    pagingController.refresh(); // ✅ trigger load pertama
  }

  void fetchMember(int page) async {
    try {
      params.page = page;
      print(
          "🔄 [MemberController] Fetching page $page dengan search='${params.search}'");

      final result = await approvalRepository.getMember(
        page: page,
        q: params.search,
      );

      if (result.isSuccess) {
        final response = result.data;

        // kalau response null atau result kosong
        if (response == null || response.values.isEmpty) {
          print("ℹ️ [MemberController] Data kosong dari API");

          // kasih empty list, supaya trigger noItemsFoundIndicator
          if (page == 1) {
            pagingController.appendLastPage([]);
          } else {
            pagingController.appendPage([], page + 1);
          }
          return;
        }

        final newItems = response.values;
        print("✅ [MemberController] Fetch success!");
        print("📊 total=${response.total}, newItems=${newItems.length}");

        final alreadyLoadedItemCount = (page - 1) * 10 + newItems.length;
        print("📦 loaded=$alreadyLoadedItemCount / total=${response.total}");

        final isLastPage = alreadyLoadedItemCount >= response.total;

        if (isLastPage) {
          print("🏁 Append last page");
          pagingController.appendLastPage(newItems);
        } else {
          print("➡️ Append next page (page ${page + 1})");
          pagingController.appendPage(newItems, page + 1);
        }
      } else {
        print("❌ [MemberController] Fetch failed: ${result.message}");
        pagingController.error = result.message ?? "Terjadi kesalahan";
      }
    } catch (e, stack) {
      print("💥 [MemberController] Exception saat fetch: $e");
      print(stack);
      pagingController.error = e;
    }
  }

  void onSearchChanged(String query) {
    Log.d(query, tag: 'search');
    debouncer.run(() {
      params.search = query;
      refreshMembers();
    });
  }

  void onSelectFilter(BaseModel? value) {
    Log.d(value, tag: 'SELECT FILTER');
    selectedFilter = value;
    pagingController.refresh();
  }

  /// reset paging dan ambil ulang dari page pertama
  void refreshMembers() {
    pagingController.refresh();
  }

  void onNavAdd() {
    // Get.to(() => const PromotionFormView())!.then(
    //   (value) {
    //     if (value ?? false) {
    //       pagingController.refresh();
    //     }
    //   },
    // );
  }

  void onClickOutlet(int index) {
    // if (pagingController.itemList?[index].isImplemented ?? false) {
    //   onNavDetail(index);
    // } else {
    //   onNavForm(index);
    // }
  }

  void onNavForm(int index) {
    // Get.to(() => const PromotionFormView(), arguments: pagingController.itemList?[index])!.then(
    //   (value) {
    //     if (value ?? false) {
    //       pagingController.refresh();
    //     }
    //   },
    // );
  }

  void onNavDetail(int index) {
    // Get.to(() => const PromotionOutletDetailView(), arguments: pagingController.itemList?[index]);
  }

  void showMemberCard(Resource member) {
    showModalBottomSheet(
      context: Get.context!,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => MemberCardBottomSheet(member: member),
    );
  }

  void goToApproval(Resource member) {
    Get.to(
      () => const ApprovalView(),
      arguments: member,
    )?.then((_) {
      // dipanggil saat user kembali dari ApprovalView
      refreshMembers();
    });
  }

  void onSearch(String? value) {
    debouncer.run(() {
      params.name = value;
      pagingController.refresh();
    });
  }
}
