extension ExtendedDateTimeMethods on DateTime? {
  String toDayMonthYearString([String separator = '/']) {
    if (this == null) return '';
    return '${this!.day > 9 ? this!.day : '0${this!.day}'}$separator${this!.month > 9 ? this!.month : '0${this!.month}'}$separator${this!.year}';
  }

  String toYearMonthDayString([String separator = '/']) {
    if (this == null) return '';
    return '${this!.year}$separator${this!.month > 9 ? this!.month : '0${this!.month}'}$separator${this!.day > 9 ? this!.day : '0${this!.day}'}';
  }

  bool isFutureDate(){
    if (this == null) return true;
    final now = DateTime.now();
    if (this!.year > now.year) return true;
    if (this!.month > now.month) return true;
    if (this!.month == now.month && this!.add(Duration(days: 1)).day > now.day) return true;
    return false;
  }
}
