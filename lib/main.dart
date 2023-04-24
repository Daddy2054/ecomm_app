import 'package:ecomm_app/common/logger/logger_provider.dart';
import 'package:ecomm_app/core/db/hive_db.dart';
import 'package:ecomm_app/core/env/env_reader.dart';
import 'package:ecomm_app/core/flavor/flavor.dart';
import 'package:ecomm_app/core/providers/internet_connection_observer.dart';
import 'package:ecomm_app/main_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void mainApp(Flavor flavor) async {
  // An object that stores the state of the providers and allows overriding
  /// the behavior of a specific provider.
  final container = ProviderContainer();

  //Read the env file with dotEnv
  final envReader = container.read(envReaderProvider);
  final envFile = envReader.getEnvFileName(flavor);
  await dotenv.load(fileName: envFile);

//Setup logger
  container.read(setupLoggerProvider);

  //setup the hive database
  container.read(hiveDbProvider);

//Observer internet connection
  container.read(internetConnectionObserverProvider);

// Expose a [ProviderContainer] to the widget tree.
  runApp(
    UncontrolledProviderScope(
      container: container,
      child: const MainWidget(),
    ),
  );
}
