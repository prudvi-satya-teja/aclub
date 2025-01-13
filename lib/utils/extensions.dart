extension StringExtensions on String {
  bool get isNullOrEmpty => this == null || isEmpty;

  String capitalize() {
    if (this == null || isEmpty) return this;
    return "${this[0].toUpperCase()}${substring(1)}";
  }
}

extension DateTimeExtensions on DateTime {
  String toFormattedString() {
    return "${day}/${month}/${year}";
  }

  bool isSameDay(DateTime other) {
    return year == other.year && month == other.month && day == other.day;
  }
}

extension ListExtensions<T> on List<T> {
  T? getOrNull(int index) {
    if (index < 0 || index >= length) return null;
    return this[index];
  }
}
