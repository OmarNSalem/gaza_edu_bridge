import 'package:logger/logger.dart';

/// Logger مركزي للتطبيق
final appLogger = Logger(
  printer: PrettyPrinter(
    methodCount: 2,
    errorMethodCount: 8,
    lineLength: 120,
    colors: true,
    printEmojis: true,
  ),
  level: Level.debug,
);
