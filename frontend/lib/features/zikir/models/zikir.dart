enum ZikirType { postSalat, morning, evening }

class Zikir {
  Zikir({
    required this.id,
    required this.name,
    required this.arabicText,
    required this.transliteration,
    required this.target,
    this.current = 0,
    required this.type,
  });

  final String id;
  final String name;
  final String arabicText;
  final String transliteration;
  final int target;
  int current;
  final ZikirType type;

  bool get isCompleted => current >= target;
  double get progress => target > 0 ? (current / target).clamp(0.0, 1.0) : 0.0;

  Zikir copyWith({int? current}) {
    return Zikir(
      id: id,
      name: name,
      arabicText: arabicText,
      transliteration: transliteration,
      target: target,
      current: current ?? this.current,
      type: type,
    );
  }

  static List<Zikir> get postSalatPresets => [
    Zikir(
      id: 'post_subhanallah',
      name: 'SubhanAllah',
      arabicText: '\u0633\u0628\u062D\u0627\u0646 \u0627\u0644\u0644\u0647',
      transliteration: 'SubhanAllah',
      target: 33,
      type: ZikirType.postSalat,
    ),
    Zikir(
      id: 'post_alhamdulillah',
      name: 'Alhamdulillah',
      arabicText: '\u0627\u0644\u062D\u0645\u062F \u0644\u0644\u0647',
      transliteration: 'Alhamdulillah',
      target: 33,
      type: ZikirType.postSalat,
    ),
    Zikir(
      id: 'post_allahuakbar',
      name: 'AllahuAkbar',
      arabicText: '\u0627\u0644\u0644\u0647 \u0623\u0643\u0628\u0631',
      transliteration: 'Allahu Akbar',
      target: 33,
      type: ZikirType.postSalat,
    ),
  ];

  static List<Zikir> get morningPresets => [
    Zikir(
      id: 'morning_ayat_kursi',
      name: 'Ayat al-Kursi',
      arabicText:
          '\u0627\u0644\u0644\u0647 \u0644\u0627 \u0625\u0644\u0647 \u0625\u0644\u0627 \u0647\u0648 \u0627\u0644\u062D\u064A \u0627\u0644\u0642\u064A\u0648\u0645',
      transliteration: 'Allahu la ilaha illa huwal hayyul qayyum',
      target: 1,
      type: ZikirType.morning,
    ),
    Zikir(
      id: 'morning_sayyidul_istighfar',
      name: 'Sayyidul Istighfar',
      arabicText:
          '\u0627\u0644\u0644\u0647\u0645 \u0623\u0646\u062A \u0631\u0628\u064A \u0644\u0627 \u0625\u0644\u0647 \u0625\u0644\u0627 \u0623\u0646\u062A',
      transliteration: 'Allahumma anta rabbi la ilaha illa anta',
      target: 1,
      type: ZikirType.morning,
    ),
    Zikir(
      id: 'morning_subhanallah_33',
      name: 'SubhanAllah',
      arabicText: '\u0633\u0628\u062D\u0627\u0646 \u0627\u0644\u0644\u0647',
      transliteration: 'SubhanAllah',
      target: 33,
      type: ZikirType.morning,
    ),
    Zikir(
      id: 'morning_la_ilaha',
      name: 'La ilaha illAllah',
      arabicText:
          '\u0644\u0627 \u0625\u0644\u0647 \u0625\u0644\u0627 \u0627\u0644\u0644\u0647',
      transliteration: 'La ilaha illAllah',
      target: 100,
      type: ZikirType.morning,
    ),
  ];

  static List<Zikir> get eveningPresets => [
    Zikir(
      id: 'evening_ayat_kursi',
      name: 'Ayat al-Kursi',
      arabicText:
          '\u0627\u0644\u0644\u0647 \u0644\u0627 \u0625\u0644\u0647 \u0625\u0644\u0627 \u0647\u0648 \u0627\u0644\u062D\u064A \u0627\u0644\u0642\u064A\u0648\u0645',
      transliteration: 'Allahu la ilaha illa huwal hayyul qayyum',
      target: 1,
      type: ZikirType.evening,
    ),
    Zikir(
      id: 'evening_subhanallah_33',
      name: 'SubhanAllah',
      arabicText: '\u0633\u0628\u062D\u0627\u0646 \u0627\u0644\u0644\u0647',
      transliteration: 'SubhanAllah',
      target: 33,
      type: ZikirType.evening,
    ),
    Zikir(
      id: 'evening_alhamdulillah_33',
      name: 'Alhamdulillah',
      arabicText: '\u0627\u0644\u062D\u0645\u062F \u0644\u0644\u0647',
      transliteration: 'Alhamdulillah',
      target: 33,
      type: ZikirType.evening,
    ),
    Zikir(
      id: 'evening_allahuakbar_33',
      name: 'AllahuAkbar',
      arabicText: '\u0627\u0644\u0644\u0647 \u0623\u0643\u0628\u0631',
      transliteration: 'Allahu Akbar',
      target: 33,
      type: ZikirType.evening,
    ),
  ];
}
