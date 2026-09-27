import \'../data/verses_data.dart\';

String getCopticOccasion(DateTime date) {
  // حساب عيد القيامة وتحديد الصوم الكبير والخمسين المقدسة
  // تبسيط: هنحدد المناسبات الثابتة الأول
  final coptic = toCoptic(date); // دالة تحويل في coptic_calendar.dart
  if (coptic.month == 4 && coptic.day == 29) return "nativity"; // 29 كيهك
  if (coptic.month == 5 && coptic.day == 11) return "epiphany"; // 11 طوبة
  if (coptic.month == 12 && coptic.day >= 1 && coptic.day <= 15) return "st_mary_fast";
  if (isGreatLent(date)) return "great_lent";
  if (isHolyWeek(date)) return "holy_week";
  if (isPentecost(date)) return "resurrection";
  return "daily";
}

Map<String,String> getTodayVerse() {
  String occasion = getCopticOccasion(DateTime.now());
  var list = verses.where((v) => v[\'occasion\'] == occasion).toList();
  if (list.isEmpty) list = verses.where((v) => v[\'occasion\'] == "daily").toList();
  int dayOfYear = DateTime.now().difference(DateTime(DateTime.now().year, 1, 1)).inDays;
  return list[dayOfYear % list.length];
}
