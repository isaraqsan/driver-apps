import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gibas/core/app/dimens.dart';
import 'package:gibas/core/utils/log.dart';
import 'package:gibas/features/articles/view/articles_detail_view.dart';
import 'package:gibas/features/articles/view/create_articles_view.dart';
import 'package:gibas/shared/typography/typography_component.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:gibas/core/app/color_palette.dart';
import 'package:gibas/features/articles/controller/articles_controller.dart';
import 'package:gibas/features/global/model/article.dart';
import 'package:gibas/shared/base_scaffold.dart';
import 'package:gibas/shared/typography/_input_field.dart';
import 'package:gibas/shared/widgets/shimmer.dart';
import 'package:gibas/shared/widgets/state_widget.dart';

class ArticlesView extends GetView<ArticlesController> {
  const ArticlesView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: ArticlesController(),
      builder: (controller) {
        return BaseScaffold(
            // onTapFab: () async {
            //   final result = await Get.to(const CreateArticlesView());
            //   Log.i(result);
            //   if (result == true) {
            //     controller.pagingController.refresh();
            //     controller
            //         .fetchArticle(1); // Atau nama method refresh artikel kamu
            //   }
            // },
            title: 'Berita',
            usePaddingHorizontal: false,
            contentMobile: _contentMobile(context));
      },
    );
  }

  Widget _contentMobile(BuildContext context) {
    return Column(
      children: [
        _buildSearchBar(),
        Expanded(
          child: PagedListView(
            pagingController: controller.pagingController,
            padding: const EdgeInsets.all(12),
            builderDelegate: PagedChildBuilderDelegate<Article>(
              itemBuilder: (context, article, index) =>
                  _buildArticleItem(article),
              // firstPageProgressIndicatorBuilder: (_) => _buildShimmerList(),
              newPageProgressIndicatorBuilder: (_) => const Padding(
                padding: EdgeInsets.all(12),
                child: CupertinoActivityIndicator(),
              ),
              noItemsFoundIndicatorBuilder: (_) => StateWidget.emptyData(
                message: 'Tidak ada artikel',
              ),
              firstPageErrorIndicatorBuilder: (_) => StateWidget.error(
                message: 'Gagal memuat artikel',
                onRetry: () => controller.pagingController.refresh(),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: Dimens.marginContentHorizontal,
      child: InputField(
        hint: 'Cari Berita',
        prefixIcon: CupertinoIcons.search,
        onChanged: controller.onSearch,
      ),
    );
  }

  Widget _buildArticleItem(Article article) {
    final textStyle = TextStyle(
      fontSize: 14,
      height: 1.6,
      color: Colors.white.withOpacity(0.9),
    );
    return GestureDetector(
      onTap: () {
        Get.to(() => const ArticlesDetailView(), arguments: article.slug);
      },
      child: Card(
        elevation: 2,
        color: ColorPalette.textTitle,
        margin: const EdgeInsets.only(bottom: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CachedNetworkImage(
              imageUrl: '${Constant.baseUrlImage}${article.pathImage}' ?? '',
              height: 180,
              width: double.infinity,
              fit: BoxFit.cover,
              placeholder: (context, url) =>
                  Container(color: Colors.grey.shade300),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextComponent.textTitle(article.title,
                      colors: ColorPalette.white,
                      maxLines: 2,
                      bold: true,
                      type: TextTitleType.l3),
                  const SizedBox(height: 6),
                  // HtmlWidget(
                  //   article.description,
                  //   textStyle: textStyle,

                  // ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 12,
                        backgroundColor: Colors.grey.shade300,
                        backgroundImage: article.author.imageFoto != null
                            ? NetworkImage(
                                '${Constant.baseUrlImage}${article.author.imageFoto!}')
                            : null,
                        child: article.author.imageFoto == null
                            ? const Icon(Icons.person, size: 16)
                            : null,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          article.author.fullName,
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.white,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildShimmerList() {
    return ListView.builder(
      shrinkWrap: true,
      padding: const EdgeInsets.all(12),
      itemCount: 6,
      itemBuilder: (context, index) => ShimmerWidget.rectangularList(
        itemCount: 1,
      ),
    );
  }
}
