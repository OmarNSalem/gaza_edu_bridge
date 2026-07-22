import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app.dart';
import 'core/di/injection.dart';

// TODO(PHASE 3): أعد تفعيل Firebase عند إضافة firebase_options.dart
// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_crashlytics/firebase_crashlytics.dart';
// import 'firebase_options.dart';

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

  // TODO(PHASE 3): فعّل Firebase بعد إضافة google-services.json
  // await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;

  // ─── إعداد Dependency Injection ────────────────────
  await configureDependencies();

  // ─── تشغيل التطبيق ─────────────────────────────────
  runApp(
    const ProviderScope(
      child: GazaEduBridgeApp(),
    ),
  );
}
