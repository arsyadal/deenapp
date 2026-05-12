import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:deenapp/features/auth/providers/auth_provider.dart';
import 'package:deenapp/features/auth/screens/login_screen.dart';
import 'package:deenapp/features/home/screens/home_screen.dart';
import 'package:deenapp/features/prayer/screens/prayer_screen.dart';
import 'package:deenapp/features/zikir/screens/zikir_screen.dart';
import 'package:deenapp/shared/widgets/bottom_nav.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKey = GlobalKey<NavigatorState>();

GoRouter createRouter(AuthProvider authProvider) {
  return GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: '/',
    redirect: (context, state) {
      final isAuthenticated = authProvider.isAuthenticated;
      final isLoggingIn = state.matchedLocation == '/login';

      if (!isAuthenticated && !isLoggingIn) return '/login';
      if (isAuthenticated && isLoggingIn) return '/';
      return null;
    },
    routes: [
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginScreen(),
      ),
      ShellRoute(
        navigatorKey: _shellNavigatorKey,
        builder: (context, state, child) {
          return _ShellScaffold(child: child);
        },
        routes: [
          GoRoute(
            path: '/',
            builder: (context, state) => const HomeScreen(),
          ),
          GoRoute(
            path: '/prayer',
            builder: (context, state) => const PrayerScreen(),
          ),
          GoRoute(
            path: '/zikir',
            builder: (context, state) => const ZikirScreen(),
          ),
        ],
      ),
    ],
  );
}

class _ShellScaffold extends StatelessWidget {
  final Widget child;
  const _ShellScaffold({required this.child});

  @override
  Widget build(BuildContext context) {
    final location = GoRouterState.of(context).matchedLocation;
    int currentIndex = 0;
    if (location == '/prayer') currentIndex = 1;
    if (location == '/zikir') currentIndex = 2;

    return Scaffold(
      body: child,
      bottomNavigationBar: BottomNav(
        currentIndex: currentIndex,
        onTap: (index) {
          switch (index) {
            case 0:
              context.go('/');
              break;
            case 1:
              context.go('/prayer');
              break;
            case 2:
              context.go('/zikir');
              break;
          }
        },
      ),
    );
  }
}
