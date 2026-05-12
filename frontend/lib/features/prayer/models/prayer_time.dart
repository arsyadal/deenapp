import 'package:intl/intl.dart';

class PrayerTime {
  PrayerTime({
    required this.name,
    required this.time,
    required this.arabicName,
  });

  final String name;
  final DateTime time;
  final String arabicName;

  static const Map<String, String> arabicNames = {
    'Fajr': '\u0627\u0644\u0641\u062C\u0631',
    'Sunrise': '\u0627\u0644\u0634\u0631\u0648\u0642',
    'Dhuhr': '\u0627\u0644\u0638\u0647\u0631',
    'Asr': '\u0627\u0644\u0639\u0635\u0631',
    'Maghrib': '\u0627\u0644\u0645\u063A\u0631\u0628',
    'Isha': '\u0627\u0644\u0639\u0634\u0627\u0621',
  };

  static const List<String> orderedNames = [
    'Fajr',
    'Sunrise',
    'Dhuhr',
    'Asr',
    'Maghrib',
    'Isha',
  ];

  String get formattedTime => DateFormat('hh:mm a').format(time);

  factory PrayerTime.fromJson(String name, String timeStr, DateTime date) {
    final parts = timeStr.split(' ')[0].split(':');
    final hour = int.parse(parts[0]);
    final minute = int.parse(parts[1]);

    final dateTime = DateTime(
      date.year,
      date.month,
      date.day,
      hour,
      minute,
    );

    return PrayerTime(
      name: name,
      time: dateTime,
      arabicName: arabicNames[name] ?? name,
    );
  }

  static List<PrayerTime> fromAladhanResponse(
    Map<String, dynamic> timings,
    DateTime date,
  ) {
    return orderedNames.map((name) {
      return PrayerTime.fromJson(name, timings[name] as String, date);
    }).toList();
  }
}
