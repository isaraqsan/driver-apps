import 'package:flutter/material.dart';
import 'package:gibas/core/app/color_palette.dart';
import 'package:gibas/core/app/dimens.dart';
import 'package:gibas/core/utils/log.dart';
import 'package:gibas/shared/component/component.dart';
import 'package:gibas/shared/typography/_text_component.dart';
import 'package:gibas/shared/widgets/week_day_selection/week_day.dart';

class WeekDaySelectionWidget extends StatefulWidget {
  final int length;
  final List<WeekDay> value;
  final ValueChanged<List<WeekDay>> onChanged;

  const WeekDaySelectionWidget({
    super.key,
    this.value = const [],
    this.length = 4,
    required this.onChanged,
  });

  @override
  State<WeekDaySelectionWidget> createState() => _WeekDaySelectionWidgetState();
}

class _WeekDaySelectionWidgetState extends State<WeekDaySelectionWidget> {
  final List<WeekDay> selectedWeekDay = [];
  final List<WeekDay> listWeekDay = [];

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        listWeekDay.addAll(
          List.generate(
            widget.length,
            (index) {
              return WeekDay(name: 'Minggu ${index + 1}', days: Day.values);
            },
          ),
        );
        onSetData();
      });
    });
    super.initState();
  }

  void onSetData() {
    selectedWeekDay.clear();
    selectedWeekDay.addAll(
      List.generate(
        listWeekDay.length,
        (index) {
          return WeekDay(name: 'Minggu ${index + 1}', days: []);
        },
      ),
    );
    if (widget.value.isEmpty) {
      return;
    }
    for (var i = 0; i < widget.value.length; i++) {
      selectedWeekDay[i].days.clear();
      selectedWeekDay[i].days.addAll(widget.value[i].days);
      selectedWeekDay[i].isExpanded = widget.value[i].isExpanded;
    }
    setState(() {});
  }

  void onSelectDay(int indexWeekDay, Day day) {
    setState(() {
      selectedWeekDay[indexWeekDay].isExpanded = true;
      if (selectedWeekDay[indexWeekDay].days.contains(day)) {
        selectedWeekDay[indexWeekDay].days.remove(day);
      } else {
        selectedWeekDay[indexWeekDay].days.add(day);
      }
    });
    widget.onChanged(selectedWeekDay);
  }

  void onExpansionChanged(int index, bool value) {
    Log.v('onExpansionChanged $index $value', tag: 'WeekDaySelectionWidget');
    setState(() {
      selectedWeekDay[index].isExpanded = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(
        listWeekDay.length,
        (index) {
          return Container(
            margin: const EdgeInsets.only(bottom: 8),
            padding: const EdgeInsets.all(8),
            decoration: Component.shadow(),
            child: Theme(
              data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
              child: ExpansionTile(
                key: PageStorageKey('week-day-$index'),
                initiallyExpanded: selectedWeekDay[index].isExpanded,
                title: TextComponent.textTitle(
                  listWeekDay[index].name,
                ),
                onExpansionChanged: (value) => onExpansionChanged(index, value),
                children: [
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: listWeekDay[index].days.map((day) {
                      final isSelected = selectedWeekDay[index].days.contains(day);
                      return InkWell(
                        onTap: () => onSelectDay(index, day),
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                          decoration: BoxDecoration(
                            color: isSelected ? ColorPalette.primary : ColorPalette.white2,
                            borderRadius: BorderRadius.circular(Dimens.radiusLarge),
                          ),
                          child: TextComponent.textBody(
                            day.label,
                            colors: isSelected ? ColorPalette.white : ColorPalette.black,
                            type: TextBodyType.l1,
                          ),
                        ),
                      );
                    }).toList(),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
