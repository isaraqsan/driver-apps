import 'package:flutter/material.dart';
import 'package:gibas/core/app/color_palette.dart';
import 'package:gibas/core/app/dimens.dart';
import 'package:gibas/domain/models/base_model.dart';
import 'package:gibas/shared/typography/typography_component.dart';

class ChipButtonHorizontal extends StatefulWidget {
  final double height;
  final BaseModel? initialValue;
  final List<BaseModel> listContent;
  final ValueChanged<BaseModel?> onChanged;
  final EdgeInsetsGeometry? padding;

  const ChipButtonHorizontal({
    this.height = 40,
    this.initialValue,
    required this.listContent,
    required this.onChanged,
    this.padding = const EdgeInsets.all(0),
    super.key,
  });

  @override
  State<ChipButtonHorizontal> createState() => _ChipButtonHorizontalState();
}

class _ChipButtonHorizontalState extends State<ChipButtonHorizontal> {
  BaseModel? _selectedContent;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    if (widget.initialValue != null) {
      _selectedContent = widget.initialValue;
      // _scrollController.animateTo(
      //   widget.listContent.indexOf(_selectedContent!).toDouble(),
      //   duration: const Duration(milliseconds: 500),
      //   curve: Curves.ease,
      // );
    }
    super.initState();
  }

  void onClickContent(int index) {
    setState(() {
      _selectedContent = widget.listContent[index];
    });
    widget.onChanged(_selectedContent);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height,
      width: double.infinity,
      child: ListView.builder(
        itemCount: widget.listContent.length,
        shrinkWrap: true,
        controller: _scrollController,
        padding: widget.padding,
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) => InkWell(
          onTap: () => onClickContent(index),
          child: Container(
            alignment: Alignment.center,
            padding: Dimens.paddingTile,
            margin: const EdgeInsets.only(right: 5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(Dimens.radiusMedium),
              color: _selectedContent?.id == widget.listContent[index].id ? ColorPalette.primary : ColorPalette.white2,
            ),
            child: TextComponent.textTitle(
              widget.listContent[index].name,
              colors: _selectedContent?.id == widget.listContent[index].id ? ColorPalette.white2 : ColorPalette.black2,
              // type: TextTitleType.l1,
            ),
          ),
        ),
      ),
    );
  }
}
