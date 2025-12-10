import 'package:gibas/core/app/constant/responsive.dart';
import 'package:gibas/core/app/theme.dart';
import 'package:gibas/shared/component/buttons.dart';
import 'package:gibas/shared/component/component.dart';
import 'package:gibas/shared/utils/form_scroll_utils.dart' show FormScrollUtils;
import 'package:flutter/material.dart';

class BaseFormScaffold extends StatelessWidget {
  final String? title;
  final VoidCallback? onSubmit;
  final String submitText;
  final bool showSubmitButton;
  final Widget contentMobile;
  final Widget? contentTablet;
  final Widget? contentDesktop;
  final bool? resizeToAvoidBottomInset;
  final bool usePaddingHorizontal;
  final void Function()? onTapFab;
  final Widget? bottomButton;

  BaseFormScaffold({
    super.key,
    this.title,
    required this.contentMobile,
    this.onSubmit,
    this.contentTablet,
    this.contentDesktop,
    this.submitText = 'Simpan',
    this.showSubmitButton = true,
    this.resizeToAvoidBottomInset,
    this.usePaddingHorizontal = true,
    this.onTapFab,
    this.bottomButton,
  });

  final _formKey = GlobalKey<FormState>();
  final _scrollController = ScrollController();

  void _handleSubmit() {
    final isValid = _formKey.currentState?.validate() ?? false;
    if (!isValid) {
      FormScrollUtils.scrollToFirstInvalid(_formKey, _scrollController);
      return;
    }

    if (showSubmitButton) {
      if (onSubmit != null) {
        onSubmit!();
      } else {
        throw UnimplementedError('onSubmit is not implemented');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: title != null ? Component.appBarDefault(title!) : null,
        backgroundColor: ColorPalette.white,
        resizeToAvoidBottomInset: resizeToAvoidBottomInset,
        floatingActionButton: onTapFab != null ? Component.floatingActionButton(onTap: onTapFab!) : null,
        body: showSubmitButton ? _contentWithBottomButton(context) : _contentWithoutBottomButton(context),
        bottomNavigationBar: showSubmitButton
            ? SafeArea(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.08),
                        offset: const Offset(0, -1),
                      ),
                    ],
                  ),
                  child: SizedBox(
                    width: double.infinity,
                    child: bottomButton ??
                        Buttons.primaryButton(
                          title: submitText,
                          onPressed: _handleSubmit,
                        ),
                  ),
                ),
              )
            : null,
      ),
    );
  }

  Widget _getResponsiveContent(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    if (width <= Responsive.mobile.maxWidth) {
      return contentMobile;
    } else if (width <= Responsive.tablet.maxWidth) {
      return contentTablet ?? contentMobile;
    } else if (width > Responsive.tablet.maxWidth) {
      return contentDesktop ?? contentMobile;
    } else {
      return contentMobile;
    }
  }

  Widget _contentWithBottomButton(BuildContext context) {
    return _contentWithBottomButtonWidget(context);
  }

  Widget _contentWithBottomButtonWidget(BuildContext context) {
    // if (showSubmitButton) {
    //   return Stack(
    //     children: [
    //       Padding(
    //         padding: EdgeInsets.only(top: 12, bottom: showSubmitButton ? 72 : 0),
    //         child: SingleChildScrollView(
    //           controller: _scrollController,
    //           padding: usePaddingHorizontal ? Dimens.marginContentHorizontal.copyWith(top: Dimens.value4, left: 24, right: 24) : EdgeInsets.zero,
    //           child: Form(
    //             key: _formKey,
    //             child: _getResponsiveContent(context),
    //           ),
    //         ),
    //       ),
    //       Align(
    //         alignment: Alignment.bottomCenter,
    //         child: Container(
    //           padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    //           decoration: BoxDecoration(
    //             color: Colors.white,
    //             boxShadow: [
    //               BoxShadow(
    //                 color: Colors.black.withValues(alpha: 0.08),
    //                 offset: const Offset(0, -1),
    //               ),
    //             ],
    //           ),
    //           child: SizedBox(
    //             width: double.infinity,
    //             child: bottomButton ??
    //                 Buttons.primaryButton(
    //                   title: submitText,
    //                   onPressed: _handleSubmit,
    //                 ),
    //           ),
    //         ),
    //       ),
    //     ],
    //   );
    // } else {
    return SingleChildScrollView(
      controller: _scrollController,
      padding: usePaddingHorizontal ? Dimens.marginContentHorizontal.copyWith(top: Dimens.value16, left: 24, right: 24) : EdgeInsets.zero,
      child: Form(
        key: _formKey,
        child: _getResponsiveContent(context),
      ),
    );
    // }
  }

  Widget _contentWithoutBottomButton(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            ColorPalette.primary,
            ColorPalette.secondary,
          ],
          begin: Alignment.topCenter,
          end: Alignment.topRight,
        ),
      ),
      child: SafeArea(
        maintainBottomViewPadding: true,
        bottom: false,
        child: Container(
          height: double.infinity,
          decoration: const BoxDecoration(
            color: ColorPalette.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
          ),
          child: SingleChildScrollView(
            controller: _scrollController,
            padding: Dimens.marginContentHorizontal.copyWith(top: 16),
            child: Form(
              key: _formKey,
              child: _getResponsiveContent(context),
            ),
          ),
        ),
      ),
    );
  }
}
