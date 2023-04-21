import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logging/logging.dart';

final setupLoggerProvider = Provider<SetupLogger>(
  (ref) {
    return SetupLogger();
  },
);


class SetupLogger {
  SetupLogger() {
    _init();
  }

  void _init() {
    if (kDebugMode) {
      Logger.root.level = Level.ALL;
      Logger.root.onRecord.listen((event) {
        if (event.level == Level.SEVERE) {
          debugPrint(
              "${event.time} : ${event.level.name} : ${event.message} : ${event.error} : ${event.stackTrace} ");
        } else if (event.level == Level.INFO) {
          debugPrint("${event.time} => ${event.level.name} : ${event.message}");
        } else {
          debugPrint(
              "${event.time} : ${event.level.name} : ${event.message} : ${event.error} : ${event.stackTrace} ");
        }
      });
    } else {
      Logger.root.level = Level.OFF;
    }
  }
}
