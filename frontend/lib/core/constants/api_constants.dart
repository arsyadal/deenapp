class ApiConstants {
  static const String backendBaseUrl = 'http://localhost:8080/api';
  static const String aladhanBaseUrl = 'https://api.aladhan.com/v1';

  // Supabase
  static const String supabaseUrl = String.fromEnvironment('SUPABASE_URL');

  // Google OAuth
  static const String googleClientId = String.fromEnvironment('GOOGLE_CLIENT_ID');

  // Backend endpoints
  static const String habits = '$backendBaseUrl/habits';
  static const String prayerLog = '$backendBaseUrl/prayer-log';
  static const String zikir = '$backendBaseUrl/zikir';
  static const String userProfile = '$backendBaseUrl/user/profile';

  // Aladhan endpoints
  static String prayerTimesByCoordinates(double lat, double lng) =>
      '$aladhanBaseUrl/timings?latitude=$lat&longitude=$lng&method=2';
}
