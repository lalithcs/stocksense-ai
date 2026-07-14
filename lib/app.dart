import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/config/router.dart';
import 'core/config/theme.dart';

class StockSenseApp extends ConsumerWidget {
  const StockSenseApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final preference = ref.watch(themeModeProvider);
    return MaterialApp.router(
      title: 'StockSense AI',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: preference,
      routerConfig: appRouter,
    );
  }
}
