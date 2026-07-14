import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

abstract final class LocalStore {
  static const _settingsBox = 'settings';
  static const watchlistBox = 'watchlist';
  static const portfolioBox = 'portfolio';
  static const searchBox = 'searchHistory';
  static late Box<dynamic> _settings;

  static Future<void> initialize() async {
    _settings = await Hive.openBox<dynamic>(_settingsBox);
    await Future.wait([
      Hive.openBox<String>(watchlistBox),
      Hive.openBox<Map>(portfolioBox),
      Hive.openBox<String>(searchBox),
    ]);
  }

  static ThemeMode get themeMode {
    switch (_settings.get('themeMode', defaultValue: 'system') as String) {
      case 'light': return ThemeMode.light;
      case 'dark': return ThemeMode.dark;
      default: return ThemeMode.system;
    }
  }

  static Future<void> setThemeMode(ThemeMode mode) =>
      _settings.put('themeMode', mode.name);
}
