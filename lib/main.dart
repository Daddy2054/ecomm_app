import 'package:ecomm_app/core/env/env_reader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/flavor/flavor.dart';
import 'main_widget.dart';

void mainApp(Flavor flavor) async {
  // An object that stores the state of the providers and allows overriding
  /// the behavior of a specific provider.
  final container = ProviderContainer();

  //Read the env file with dotEnv
  final envReader = container.read(envReaderProvider);
  final envFile = envReader.getEnvFileName(flavor);
  await dotenv.load(fileName: envFile);

// Expose a [ProviderContainer] to the widget tree.
  runApp(UncontrolledProviderScope(
    container: container,
    child: const MainWidget(),
  ));
}
