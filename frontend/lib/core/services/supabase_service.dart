import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseService {
  SupabaseService._();
  static final SupabaseService _instance = SupabaseService._();
  static SupabaseService get instance => _instance;

  SupabaseClient get _client => Supabase.instance.client;

  /// Initialize Supabase. Call this in main() before runApp().
  static Future<void> initialize({
    required String url,
    required String anonKey,
  }) async {
    await Supabase.initialize(
      url: url,
      anonKey: anonKey,
    );
    debugPrint('SupabaseService: initialized');
  }

  /// The currently signed-in user, or null.
  User? get currentUser => _client.auth.currentUser;

  /// Whether a user is currently authenticated.
  bool get isAuthenticated => currentUser != null;

  /// Stream of auth state changes (sign in, sign out, token refresh, etc.).
  Stream<AuthState> get authStateChanges =>
      _client.auth.onAuthStateChange;

  /// Sign in with Google OAuth.
  Future<bool> signInWithGoogle() async {
    try {
      final response = await _client.auth.signInWithOAuth(
        OAuthProvider.google,
        redirectTo: kIsWeb ? null : 'io.supabase.deenapp://login-callback/',
      );
      return response;
    } catch (e) {
      debugPrint('SupabaseService: Google sign-in error: $e');
      return false;
    }
  }

  /// Sign out the current user.
  Future<void> signOut() async {
    try {
      await _client.auth.signOut();
    } catch (e) {
      debugPrint('SupabaseService: sign-out error: $e');
    }
  }
}
