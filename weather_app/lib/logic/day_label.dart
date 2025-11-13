enum DayLabel {
  monday,
  tuesday,
  wednesday,
  thursday,
  friday,
  saturday,
  sunday;

  String get label {
    switch (this) {
      case DayLabel.monday:
        return 'Monday';
      case DayLabel.tuesday:
        return 'Tuesday';
      case DayLabel.wednesday:
        return 'Wednesday';
      case DayLabel.thursday:
        return 'Thursday';
      case DayLabel.friday:
        return 'Friday';
      case DayLabel.saturday:
        return 'Saturday';
      case DayLabel.sunday:
        return 'Sunday';
    }
  }
}
