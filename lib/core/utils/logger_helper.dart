import 'package:flutter/foundation.dart';

class AnsiColors {

  static const String reset = '\x1B[0m';

  static const String black = '\x1B[30m';
  static const String red = '\x1B[31m';
  static const String green = '\x1B[32m';
  static const String yellow = '\x1B[33m';
  static const String blue = '\x1B[34m';
  static const String magenta = '\x1B[35m';
  static const String cyan = '\x1B[36m';
  static const String white = '\x1B[37m';

  static const String bgBlack = '\x1B[40m';
  static const String bgRed = '\x1B[41m';
  static const String bgGreen = '\x1B[42m';
  static const String bgYellow = '\x1B[43m';
  static const String bgBlue = '\x1B[44m';
  static const String bgMagenta = '\x1B[45m';
  static const String bgCyan = '\x1B[46m';
  static const String bgWhite = '\x1B[47m';

  static const String bold = '\x1B[1m';
  static const String dim = '\x1B[2m';
  static const String underline = '\x1B[4m';
  static const String blink = '\x1B[5m';
  static const String reverse = '\x1B[7m';
  static const String hidden = '\x1B[8m';
}

class LoggerHelper {

  static void log(
    String message, {
    String color = AnsiColors.reset,
    String? style,
  }) {
    String styledMessage = '';
    if (style != null) {
      styledMessage += style;
    }
    styledMessage += color;
    styledMessage += message;
    styledMessage += AnsiColors.reset;

    if (kDebugMode) {
      debugPrint(styledMessage);
    } else {

      print(styledMessage);
    }
  }

  static void info(String message) {
    log('[INFO] $message', color: AnsiColors.white);
  }

  static void success(String message) {
    log('[SUCCESS] $message', color: AnsiColors.green, style: AnsiColors.bold);
  }

  static void warning(String message) {
    log('[WARNING] $message', color: AnsiColors.yellow, style: AnsiColors.bold);
  }

  static void error(String message) {
    log('[ERROR] $message', color: AnsiColors.red, style: AnsiColors.bold);
  }

  static void debug(String message) {

    log('[DEBUG] $message', color: AnsiColors.cyan);
  }
}
