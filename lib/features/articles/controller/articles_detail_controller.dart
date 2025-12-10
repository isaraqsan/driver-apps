import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gibas/core/utils/log.dart';
import 'package:gibas/core/utils/utils.dart';
import 'package:gibas/domain/models/base_model.dart';
import 'package:gibas/domain/models/base_params.dart';
import 'package:get/get.dart';
import 'package:gibas/features/articles/model/article_response.dart';
import 'package:gibas/features/articles/model/comment_request.dart';
import 'package:gibas/features/articles/repository/article_repository.dart';
import 'package:gibas/features/global/model/article_detail.dart';
import 'package:gibas/features/global/model/like.dart';
import 'package:gibas/features/global/repository/global_repository.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class ArticlesDetailController extends GetxController
    with StateMixin<ArticleDetail> {
  late GlobalRepository articleRepository;
  late ArticleRepository commentRepository;
  double? imageAspectRatio; // width / height
  final commentController = TextEditingController();
  final comments = <Comment>[].obs; // 👈 RxList

  BaseModel? selectedFilter;
  final PagingController<int, ArticleDetail> pagingController =
      PagingController(firstPageKey: 1);
  final BaseParams params = BaseParams();

  // ID artikel yang akan ditampilkan
  String? articleId;

  var isLiked = false.obs;

  @override
  void onInit() {
    super.onInit();

    // Mendapatkan ID dari parameter route
    articleRepository = GlobalRepository();
    commentRepository = ArticleRepository();
    final arguments = Get.arguments;
    if (arguments != null && arguments is String) {
      articleId = arguments;
      loadDetail();
    } else if (Get.parameters['id'] != null) {
      articleId = Get.parameters['id'];
      loadDetail();
    } else {
      change(null, status: RxStatus.error('ID artikel tidak ditemukan'));
    }
  }

  // Future<void> initData() async {
  //   await loadDetail();
  //   await loadComments();
  // }

  // Method untuk memuat detail artikel
  Future<void> loadDetail() async {
    try {
      if (articleId == null) {
        change(null, status: RxStatus.error('ID artikel tidak valid'));
        return;
      }

      change(null, status: RxStatus.loading());

      // Panggil repository untuk mendapatkan detail artikel
      final result = await articleRepository.detailArticle(articleId!);

      if (result.isSuccess) {
        final article = result.data;
        isLiked.value = article?.like ?? false; // jika ada field isLiked
        change(article, status: RxStatus.success());
        await loadComments();
      } else {
        change(null, status: RxStatus.error('Artikel tidak ditemukan'));
      }
    } catch (e) {
      change(null, status: RxStatus.error('Gagal memuat detail artikel: $e'));
      Log.e(e.toString());
    }
  }

  Future<void> loadComments() async {
    try {
      if (state == null) return;
      params.group = '1';
      params.idExternal = state?.id.toString();
      params.perPage = '50'; // ambil semua komentar
      final result = await commentRepository.commentList(params);

      if (result.isSuccess) {
        comments.assignAll(result.data?.values ?? []); // 👈 langsung assignAll
        Log.i('Comments loaded: ${comments.length}');
        Log.i('Comments data: ${result.data?.values}');
      }
    } catch (e) {
      Log.e(e.toString());
    }
  }

  Future<void> sendComment() async {
    final text = commentController.text.trim();
    if (text.isEmpty || state == null) return;

    final body = CommentRequest(
      id: state!.id,
      group: 1,
      status: 1,
      comment: text,
    );

    try {
      final result = await commentRepository.commentCreate(body);
      if (result.isSuccess) {
        commentController.clear();
        await loadComments();

        // ✅ opsi ringan pakai snackbar
        HapticFeedback.vibrate();
      } else {
        Get.snackbar(
          'Gagal',
          result.message ?? 'Komentar gagal dikirim',
          snackPosition: SnackPosition.BOTTOM,
          duration: const Duration(seconds: 2),
          backgroundColor: Colors.red.shade600,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Terjadi kesalahan koneksi',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.shade600,
        colorText: Colors.white,
      );
    }
  }

  void toggleLike(int id) async {
    final oldState = isLiked.value;
    isLiked.value = !isLiked.value; // Optimistic UI

    try {
      final body = Like(id: id, group: 1);
      final result = await articleRepository.like(body);

      if (result.isSuccess) {
        // ✅ Refresh artikel supaya counterLike ikut update
        await loadDetail();
      } else {
        // Rollback kalau gagal
        isLiked.value = oldState;
        Utils.toast(
          result.message ?? 'Gagal menyukai artikel',
          snackType: SnackType.error,
        );
      }
    } catch (e) {
      isLiked.value = oldState;
      Utils.toast(
        'Terjadi kesalahan koneksi',
        snackType: SnackType.error,
      );
    }
  }

  // final comments = <dynamic>[].obs;

  // Future<void> loadComments() async {
  //   // Panggil API ambil comment di sini
  //   final result = await ArticleApi.getComments(articleId);
  //   comments.assignAll(result);
  // }

  Future<void> postComment() async {
    final text = commentController.text.trim();
    if (text.isEmpty) return;
    // Kirim komentar ke API
    // await ArticleApi.postComment(articleId, text);
    commentController.clear();
    await loadComments(); // refresh list
  }

  void getImageAspectRatio(String imageUrl) {
    final image = Image.network(imageUrl);
    image.image.resolve(const ImageConfiguration()).addListener(
      ImageStreamListener((ImageInfo info, bool _) {
        final width = info.image.width;
        final height = info.image.height;

        if (width != 0 && height != 0) {
          imageAspectRatio = width / height;
          update(); // Ini penting agar Obx/GetBuilder tahu untuk re-render UI
          Log.i("Aspect ratio updated: $imageAspectRatio");
        }
      }),
    );
  }

  // Method untuk refresh data
  Future<void> refreshData() async {
    await loadDetail();
  }

  @override
  void onClose() {
    pagingController.dispose();
    super.onClose();
  }
}
