import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import 'package:deenapp/features/prayer/models/prayer_time.dart';

class PrayerProvider extends ChangeNotifier {
  List<PrayerTime> _prayerTimes = [];
  List<PrayerTime> get prayerTimes => _prayerTimes;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  String _cityName = '';
  String get cityName => _cityName;

  String _hijriDate = '';
  String get hijriDate => _hijriDate;

  Timer? _countdownTimer;

  PrayerTime? get nextPrayer {
    final now = DateTime.now();
    for (final prayer in _prayerTimes) {
      if (prayer.time.isAfter(now)) {
        return prayer;
      }
    }
    // If all prayers have passed, return tomorrow's Fajr (first prayer)
    return _prayerTimes.isNotEmpty ? _prayerTimes.first : null;
  }

  Duration get countdownToNext {
    final next = nextPrayer;
    if (next == null) return Duration.zero;

    final now = DateTime.now();
    if (next.time.isAfter(now)) {
      return next.time.difference(now);
    }
    // Next day's first prayer
    return next.time.add(const Duration(days: 1)).difference(now);
  }

  String get countdownFormatted {
    final d = countdownToNext;
    final hours = d.inHours;
    final minutes = d.inMinutes.remainder(60);
    final seconds = d.inSeconds.remainder(60);
    return '${hours.toString().padLeft(2, '0')}:'
        '${minutes.toString().padLeft(2, '0')}:'
        '${seconds.toString().padLeft(2, '0')}';
  }

  Future<void> fetchPrayerTimes(double lat, double lng,
      {String city = ''}) async {
    _isLoading = true;
    _errorMessage = null;
    _cityName = city;
    notifyListeners();

    try {
      final now = DateTime.now();
      final timestamp = now.millisecondsSinceEpoch ~/ 1000;
      final url = Uri.parse(
        'https://api.aladhan.com/v1/timings/$timestamp'
        '?latitude=$lat&longitude=$lng&method=2',
      );

      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body) as Map<String, dynamic>;
        final timings =
            data['data']['timings'] as Map<String, dynamic>;
        final hijri = data['data']['date']['hijri'];

        _hijriDate =
            '${hijri['day']} ${hijri['month']['en']} ${hijri['year']}';
        _prayerTimes = PrayerTime.fromAladhanResponse(
          timings.map((k, v) => MapEntry(k, v.toString())),
          now,
        );

        _startCountdownTimer();
      } else {
        _errorMessage = 'Failed to fetch prayer times';
      }
    } catch (e) {
      _errorMessage = 'Error: $e';
      debugPrint('PrayerProvider: fetch error: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void _startCountdownTimer() {
    _countdownTimer?.cancel();
    _countdownTimer = Timer.periodic(const Duration(seconds: 1), (_) {
      notifyListeners();
    });
  }

  @override
  void dispose() {
    _countdownTimer?.cancel();
    super.dispose();
  }
}
