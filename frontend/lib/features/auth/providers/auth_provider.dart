import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:deenapp/core/services/supabase_service.dart';

class AuthProvider extends ChangeNotifier {
  AuthProvider() {
    _init();
  }

  final SupabaseService _supabaseService = SupabaseService.instance;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  bool get isAuthenticated => _supabaseService.isAuthenticated;

  User? get user => _supabaseService.currentUser;

  StreamSubscription<AuthState>? _authSubscription;

  void _init() {
    _authSubscription = _supabaseService.authStateChanges.listen((authState) {
      notifyListeners();
    });
  }

  Future<void> signInWithGoogle() async {
    _isLoading = true;
    notifyListeners();

    try {
      await _supabaseService.signInWithGoogle();
    } catch (e) {
      debugPrint('AuthProvider: sign-in error: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> signOut() async {
    _isLoading = true;
    notifyListeners();

    try {
      await _supabaseService.signOut();
    } catch (e) {
      debugPrint('AuthProvider: sign-out error: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  @override
  void dispose() {
    _authSubscription?.cancel();
    super.dispose();
  }
}
