// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';

class FormScrollUtils {
  static void scrollToFirstInvalid(GlobalKey<FormState> formKey, ScrollController scrollController, {int offestHeight = 100}) {
    Future.delayed(Duration.zero, () {
      final form = formKey.currentState;
      if (form == null) return;

      final fields = _collectInvalidFields(form.context);
      if (fields.isEmpty) return;

      final firstContext = fields.first;
      final box = firstContext.findRenderObject() as RenderBox?;
      if (box != null) {
        final y = box.localToGlobal(Offset.zero).dy;
        scrollController.animateTo(
          scrollController.offset + y - offestHeight,
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  static List<BuildContext> _collectInvalidFields(BuildContext context) {
    final result = <BuildContext>[];

    void visitor(Element element) {
      if (element is StatefulElement && element.state is FormFieldState) {
        final field = element.state as FormFieldState;
        if (!field.isValid) {
          result.add(element);
        }
      }
      element.visitChildren(visitor);
    }

    context.visitChildElements(visitor);
    return result;
  }
}
