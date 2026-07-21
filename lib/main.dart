import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';

import 'app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // ─── إجبار الاتجاه عمودي فقط ──────────────────────
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  // ─── Status bar شفاف ───────────────────────────────
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
    ),
  );

  // ─── Firebase Core (إلزامي قبل runApp) ────────────
  await Firebase.initializeApp();

  // ─── Crashlytics: تسجيل الأخطاء غير المتوقعة ──────
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;

  // ─── تشغيل التطبيق ─────────────────────────────────
  runApp(
    const ProviderScope(
      child: GazaEduBridgeApp(),
    ),
  );
}
