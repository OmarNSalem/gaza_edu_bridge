import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/router/app_router.dart';
import 'core/theme/app_theme.dart';
import 'l10n/app_localizations.dart';

/// نقطة دخول التطبيق — MaterialApp.router مع GoRouter + AppLocalizations
class GazaEduBridgeApp extends ConsumerWidget {
  const GazaEduBridgeApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(appRouterProvider);

    return MaterialApp.router(
      title: 'GazaEdu Bridge',
      debugShowCheckedModeBanner: false,

      // ─── Theme: Dark Mode فقط ────────────────────────
      theme: AppTheme.darkTheme,
      themeMode: ThemeMode.dark,

      // ─── اللغة الافتراضية: عربي RTL ─────────────────
      locale: const Locale('ar'),
      supportedLocales: const [Locale('ar'), Locale('en')],
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],

      // ─── Navigation عبر GoRouter ─────────────────────
      routerConfig: router,
    );
  }
}
