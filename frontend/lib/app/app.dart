import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:deenapp/core/theme/app_theme.dart';
import 'package:deenapp/features/auth/providers/auth_provider.dart';
import 'package:deenapp/features/prayer/providers/prayer_provider.dart';
import 'package:deenapp/features/zikir/providers/zikir_provider.dart';
import 'package:deenapp/app/routes.dart';

class DeenApp extends StatelessWidget {
  const DeenApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => PrayerProvider()),
        ChangeNotifierProvider(create: (_) => ZikirProvider()),
      ],
      child: Consumer<AuthProvider>(
        builder: (context, authProvider, _) {
          final router = createRouter(authProvider);
          return MaterialApp.router(
            title: 'DeenApp',
            debugShowCheckedModeBanner: false,
            theme: AppTheme.darkTheme,
            routerConfig: router,
          );
        },
      ),
    );
  }
}
