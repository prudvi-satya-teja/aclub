class DateUtils {
  static String formatDate(DateTime date) {
    return "${date.day}/${date.month}/${date.year}";
  }

  static String formatDateTime(DateTime dateTime) {
    return "${dateTime.day}/${dateTime.month}/${dateTime.year} ${dateTime.hour}:${dateTime.minute}";
  }

  static bool isToday(DateTime date) {
    final today = DateTime.now();
    return date.year == today.year && date.month == today.month && date.day == today.day;
  }

  static bool isSameDay(DateTime date1, DateTime date2) {
    return date1.year == date2.year && date1.month == date2.month && date1.day == date2.day;
  }
}
