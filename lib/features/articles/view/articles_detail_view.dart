import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gibas/core/app/theme.dart';
import 'package:gibas/core/utils/full_image_viewer.dart';
import 'package:gibas/features/articles/controller/articles_detail_controller.dart';
import 'package:gibas/shared/base_scaffold.dart';
import 'package:gibas/shared/typography/typography_component.dart';
import 'package:gibas/shared/widgets/state_widget.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

import 'package:gibas/core/app/color_palette.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';

class ArticlesDetailView extends GetView<ArticlesDetailController> {
  const ArticlesDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: ArticlesDetailController(),
      builder: (controller) {
        return BaseScaffold(
          usePaddingHorizontal: false,
          contentMobile: _contentMobile(context),
        );
      },
    );
  }

  Widget _contentMobile(BuildContext context) {
    return controller.obx(
      (article) {
        if (article == null) {
          return const Center(child: Text('Artikel tidak ditemukan'));
        }

        final formattedDate = _formatDate(article.createdDate);

        return SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {
                  Get.dialog(
                    FullImageViewer(
                      imageUrl: '${Constant.baseUrlImage}${article.pathImage}',
                    ),
                    barrierColor: Colors.black87,
                  );
                },
                child: Stack(
                  children: [
                    CachedNetworkImage(
                      imageUrl: '${Constant.baseUrlImage}${article.pathImage}',
                      width: double.infinity,
                      height: 500,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => Container(
                        height: 500,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                            colors: [
                              ColorPalette.primary.withOpacity(0.8),
                              Colors.transparent,
                            ],
                          ),
                        ),
                      ),
                      errorWidget: (context, url, error) => Container(
                        height: 500,
                        color: ColorPalette.secondary,
                        child: const Icon(Iconsax.gallery,
                            size: 48, color: Colors.white54),
                      ),
                    ),
                    Container(
                      height: 500,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          colors: [
                            ColorPalette.textTitle.withOpacity(0.9),
                            Colors.transparent,
                          ],
                        ),
                      ),
                    ),
                    // Back button
                    Positioned(
                      top: 16,
                      left: 16,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.5),
                          shape: BoxShape.circle,
                        ),
                        child: IconButton(
                          icon: const Icon(Iconsax.arrow_left,
                              color: Colors.white),
                          onPressed: () => Get.back(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Konten artikel
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Category badge
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: ColorPalette.greenTheme,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Text(
                        article.categoryName.toUpperCase(),
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Judul
                    Text(
                      article.title,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                        color: Colors.black,
                        height: 1.3,
                      ),
                    ),
                    const SizedBox(height: 20),

                    HtmlWidget(
                      article.description,
                      textStyle: TextStyle(
                        fontSize: 16,
                        height: 1.6,
                        color: Colors.black.withOpacity(0.9),
                      ),
                      customStylesBuilder: (element) {
                        if (element.localName == 'b') {
                          return {'font-weight': 'bold'}; // optional
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 32),

                    // Author info
                    Row(
                      children: [
                        // Author avatar
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border:
                                Border.all(color: ColorPalette.grey, width: 2),
                          ),
                          child: ClipOval(
                            child: article.author.imageFoto != null
                                ? CachedNetworkImage(
                                    imageUrl:
                                        '${Constant.baseUrlImage}${article.author.imageFoto!}',
                                    fit: BoxFit.cover,
                                    placeholder: (context, url) => Container(
                                      color: ColorPalette.secondary,
                                      child: const Icon(Iconsax.user,
                                          color: Colors.white54),
                                    ),
                                    errorWidget: (context, url, error) =>
                                        Container(
                                      color: ColorPalette.secondary,
                                      child: const Icon(Iconsax.user,
                                          color: Colors.white54),
                                    ),
                                  )
                                : Container(
                                    color: ColorPalette.secondary,
                                    child: const Icon(Iconsax.user,
                                        color: Colors.black),
                                  ),
                          ),
                        ),
                        const SizedBox(width: 12),

                        // Author details
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextComponent.textTitle(
                                article.author.fullName,
                                type: TextTitleType.l2,
                                bold: true,
                              ),
                              const SizedBox(height: 2),
                              Text(
                                formattedDate,
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.black.withOpacity(0.7),
                                ),
                              ),
                            ],
                          ),
                        ),

                        // Stats
                        Row(
                          children: [
                            // _buildStatIcon(Iconsax.eye, article.counterView),
                            const SizedBox(width: 16),
                            Obx(() => _buildLikeIcon(controller.isLiked.value,
                                article.counterLike, controller, article.id)),

                            const SizedBox(width: 16),
                            _buildStatIcon(Iconsax.message,
                                article.counterComment, context),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),

                    // Divider
                    Divider(
                      color: Colors.white.withOpacity(0.2),
                      height: 1,
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ],
          ),
        );
      },
      onLoading: _buildShimmerDetail(),
      onError: (error) => StateWidget.error(
        message: error ?? 'Terjadi kesalahan',
        onRetry: () => controller.loadDetail(),
      ),
    );
  }

  Widget _buildStatIcon(
    IconData icon,
    int count,
    BuildContext context,
  ) {
    return InkWell(
      onTap: () => showComments(context),
      child: Row(
        children: [
          Icon(icon, size: 16, color: Colors.white.withOpacity(0.7)),
          const SizedBox(width: 4),
          Text(
            count.toString(),
            style: TextStyle(
              fontSize: 12,
              color: Colors.white.withOpacity(0.7),
            ),
          ),
        ],
      ),
    );
  }

  String _formatDate(String dateString) {
    try {
      final date = DateTime.parse(dateString);
      return DateFormat('dd MMMM yyyy • HH:mm', 'id_ID').format(date);
    } catch (e) {
      return dateString;
    }
  }

  Widget _buildLikeIcon(
      bool isLiked, int count, ArticlesDetailController controller, int id) {
    return InkWell(
      onTap: () => controller.toggleLike(id),
      borderRadius: BorderRadius.circular(20),
      child: Row(
        children: [
          Icon(
            Iconsax.heart,
            size: 16,
            color: isLiked ? Colors.red : Colors.white.withOpacity(0.7),
          ),
          const SizedBox(width: 4),
          Text(
            count.toString(),
            style: TextStyle(
              fontSize: 12,
              color: Colors.white.withOpacity(0.7),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildShimmerDetail() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        // Image shimmer
        Container(
          height: 280,
          decoration: BoxDecoration(
            color: Colors.grey.shade800,
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        const SizedBox(height: 20),

        // Category shimmer
        Container(
          height: 24,
          width: 80,
          decoration: BoxDecoration(
            color: Colors.grey.shade800,
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        const SizedBox(height: 16),

        // Title shimmer
        Container(
          height: 28,
          color: Colors.grey.shade800,
        ),
        const SizedBox(height: 8),
        Container(
          height: 28,
          width: 200,
          color: Colors.grey.shade800,
        ),
        const SizedBox(height: 20),

        // Author shimmer
        Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.grey.shade800,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 14,
                    width: 100,
                    color: Colors.grey.shade800,
                  ),
                  const SizedBox(height: 6),
                  Container(
                    height: 12,
                    width: 80,
                    color: Colors.grey.shade800,
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),

        // Content shimmer
        ...List.generate(
          8,
          (index) => Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Container(
              height: 14,
              color: Colors.grey.shade800,
            ),
          ),
        ),
      ],
    );
  }

  void showComments(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.black87,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (_) {
        return DraggableScrollableSheet(
          expand: false,
          initialChildSize: 0.7,
          minChildSize: 0.5,
          maxChildSize: 0.95,
          builder: (context, scrollController) {
            return Obx(() {
              if (controller.comments.isEmpty) {
                return const Center(child: Text("Belum ada komentar"));
              }
              return Column(
                children: [
                  // Header
                  Container(
                    height: 4,
                    width: 40,
                    margin: const EdgeInsets.symmetric(vertical: 12),
                    decoration: BoxDecoration(
                      color: Colors.white24,
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  Expanded(
                    child: ListView.separated(
                      controller: scrollController,
                      itemCount: controller.comments.length,
                      separatorBuilder: (_, __) =>
                          Divider(color: Colors.white24),
                      itemBuilder: (context, index) {
                        final comment = controller.comments[index];
                        return ListTile(
                          leading: CircleAvatar(
                            backgroundImage: NetworkImage(
                              "${Constant.baseUrlImage}${comment.author?.imageFoto}",
                            ),
                          ),
                          title: Text(comment.author?.fullName ?? "",
                              style: const TextStyle(color: Colors.white)),
                          subtitle: Text(comment.comment ?? "",
                              style: const TextStyle(color: Colors.white70)),
                          trailing: Text(
                            _formatDate(comment.createdDate.toString()),
                            style: const TextStyle(
                              color: Colors.white54,
                              fontSize: 12,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  // Input komentar fixed bawah
                  SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: controller.commentController,
                              style: const TextStyle(color: Colors.white),
                              decoration: InputDecoration(
                                hintText: "Tulis komentar...",
                                hintStyle:
                                    const TextStyle(color: Colors.white54),
                                filled: true,
                                fillColor: Colors.white12,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(24),
                                  borderSide: BorderSide.none,
                                ),
                                contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 8),
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          IconButton(
                            icon: const Icon(Icons.send, color: Colors.white),
                            onPressed: () => controller.sendComment(),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              );
            });
          },
        );
      },
    );
  }
}
