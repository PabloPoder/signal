const months = [
  'JAN', 'FEB', 'MAR', 'APR', 'MAY', 'JUN',
  'JUL', 'AUG', 'SEP', 'OCT', 'NOV', 'DEC'
];

String formatTimeWithHour(DateTime dateTime) {
  final year = dateTime.year;
  final month = months[dateTime.month - 1];
  final day = dateTime.day;
  final hour = dateTime.hour;
  final minute = dateTime.minute;
  final isAM = hour < 12;
  final displayHour = hour == 0 ? 12 : (hour > 12 ? hour - 12 : hour);
  final minuteStr = minute.toString().padLeft(2, '0');
  final period = isAM ? 'am' : 'pm';
  return '$displayHour:$minuteStr$period // $day $month $year';
}

String formatTime(DateTime dateTime) {
  final year = dateTime.year;
  final month = months[dateTime.month - 1];
  final day = dateTime.day;

  return '$day.$month.$year';
}