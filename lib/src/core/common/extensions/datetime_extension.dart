extension DateOnlyCompare on DateTime {
  bool isSameDate(DateTime other) {
    return year == other.year && month == other.month && day == other.day;
  }

  String formatDate() {
    return '${day.toString().padLeft(2, '0')}.${month.toString().padLeft(2, '0')}.${year.toString().substring(2)}';
  }
}
