import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/theme/app_theme.dart';

// TODO: استبدل بـ GoRouter لاحقاً في PHASE 3
class GazaEduBridgeApp extends ConsumerWidget {
  const GazaEduBridgeApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      title: 'GazaEdu Bridge',
      debugShowCheckedModeBanner: false,

      // ─── Theme: Dark فقط ─────────────────────────────
      theme: AppTheme.darkTheme,
      themeMode: ThemeMode.dark,

      // ─── اللغة الافتراضية: عربي RTL ─────────────────
      locale: const Locale('ar'),
      supportedLocales: const [
        Locale('ar'),
        Locale('en'),
      ],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],

      // ─── الشاشة الأولى (مؤقت — سيُستبدل بـ GoRouter) ─
      home: const Scaffold(
        body: Center(
          child: Text(
            'GazaEdu Bridge\nجاري الإعداد...',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
        ),
      ),
    );
  }
}
