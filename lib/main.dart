import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'app.dart';
import 'core/services/local_store.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await LocalStore.initialize();
  runZonedGuarded(
    () => runApp(const ProviderScope(child: StockSenseApp())),
    (error, stackTrace) => FlutterError.reportError(
      FlutterErrorDetails(exception: error, stack: stack),
    ),
  );
}
