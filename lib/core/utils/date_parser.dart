const months = [
  'JAN',
  'FEB',
  'MAR',
  'APR',
  'MAY',
  'JUN',
  'JUL',
  'AUG',
  'SEP',
  'OCT',
  'NOV',
  'DEC',
];

String formatTimeComplete(DateTime dateTime) {
  final year = dateTime.year;
  final month = months[dateTime.month - 1];
  final day = dateTime.day.toString().padLeft(2, '0');
  final hour = dateTime.hour;
  final minute = dateTime.minute;
  final isAM = hour < 12;
  final displayHour = hour == 0 ? 12 : (hour > 12 ? hour - 12 : hour);
  final minuteStr = minute.toString().padLeft(2, '0');
  final period = isAM ? 'am' : 'pm';
  return '$displayHour:$minuteStr$period // $day $month $year';
}

String formatTimeCompleteInverted(DateTime dateTime) {
  final year = dateTime.year;
  final month = months[dateTime.month - 1];
  final day = dateTime.day.toString().padLeft(2, '0');
  final hour = dateTime.hour;
  final minute = dateTime.minute;
  final isAM = hour < 12;
  final displayHour = hour == 0 ? 12 : (hour > 12 ? hour - 12 : hour);
  final minuteStr = minute.toString().padLeft(2, '0');
  final period = isAM ? 'am' : 'pm';
  return '$day $month $year // $displayHour:$minuteStr$period';
}

String formatTimeHour(DateTime dateTime) {
  const baseEpochDay = 312;
  final epoch = baseEpochDay + dateTime.difference(DateTime.now()).inDays;
  final hour = dateTime.hour;
  final minute = dateTime.minute;
  final displayHour = hour == 0 ? 12 : (hour > 12 ? hour - 12 : hour);
  final minuteStr = minute.toString().padLeft(2, '0');
  return 'E+$epoch $displayHour:$minuteStr';
}

String formatTime(DateTime dateTime) {
  final year = dateTime.year;
  final month = months[dateTime.month - 1];
  final day = dateTime.day.toString().padLeft(2, '0');

  return '$day.$month.$year';
}
