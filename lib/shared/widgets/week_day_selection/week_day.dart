enum Day {
  monday(1, 'senin'),
  tuesday(2, 'selasa'),
  wednesday(3, 'rabu'),
  thursday(4, 'kamis'),
  friday(5, 'jumat'),
  saturday(6, 'sabtu'),
  sunday(7, 'minggu');

  final int value;
  final String label;

  const Day(this.value, this.label);
}

class WeekDay {
  String name;
  List<Day> days;
  bool isExpanded;

  WeekDay({
    required this.name,
    required this.days,
    this.isExpanded = false,
  });
}
