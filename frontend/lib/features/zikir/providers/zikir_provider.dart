import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'package:deenapp/features/zikir/models/zikir.dart';

class ZikirProvider extends ChangeNotifier {
  ZikirProvider() {
    _loadPresets();
  }

  List<Zikir> _zikirItems = [];
  List<Zikir> get zikirItems => _zikirItems;

  List<Zikir> get postSalatItems =>
      _zikirItems.where((z) => z.type == ZikirType.postSalat).toList();

  List<Zikir> get morningItems =>
      _zikirItems.where((z) => z.type == ZikirType.morning).toList();

  List<Zikir> get eveningItems =>
      _zikirItems.where((z) => z.type == ZikirType.evening).toList();

  double get totalProgress {
    if (_zikirItems.isEmpty) return 0.0;
    final totalTarget =
        _zikirItems.fold<int>(0, (sum, z) => sum + z.target);
    final totalCurrent =
        _zikirItems.fold<int>(0, (sum, z) => sum + z.current);
    if (totalTarget == 0) return 0.0;
    return (totalCurrent / totalTarget).clamp(0.0, 1.0);
  }

  int get completedCount =>
      _zikirItems.where((z) => z.isCompleted).length;

  void _loadPresets() {
    _zikirItems = [
      ...Zikir.postSalatPresets,
      ...Zikir.morningPresets,
      ...Zikir.eveningPresets,
    ];
    notifyListeners();
  }

  void increment(String id) {
    final index = _zikirItems.indexWhere((z) => z.id == id);
    if (index == -1) return;

    final zikir = _zikirItems[index];
    if (zikir.current < zikir.target) {
      _zikirItems[index] = zikir.copyWith(current: zikir.current + 1);
      HapticFeedback.lightImpact();
      notifyListeners();
    }
  }

  void resetAll() {
    _zikirItems = _zikirItems.map((z) => z.copyWith(current: 0)).toList();
    notifyListeners();
  }
}
