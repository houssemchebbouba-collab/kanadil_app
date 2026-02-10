import 'package:flutter/material.dart';
import '../services/storage_service.dart';

class ThemeProvider extends ChangeNotifier {
  bool _isDarkMode = false;

  bool get isDarkMode => _isDarkMode;

  ThemeMode get themeMode => _isDarkMode ? ThemeMode.dark : ThemeMode.light;

  ThemeProvider() {
    _loadTheme();
  }

  void _loadTheme() {
    _isDarkMode = StorageService.getDarkMode();
    notifyListeners();
  }

  Future<void> toggleTheme() async {
    _isDarkMode = !_isDarkMode;
    await StorageService.setDarkMode(_isDarkMode);
    notifyListeners();
  }

  /// toggleDarkMode alias for toggleTheme
  Future<void> toggleDarkMode() async {
    await toggleTheme();
  }

  Future<void> setDarkMode(bool value) async {
    _isDarkMode = value;
    await StorageService.setDarkMode(value);
    notifyListeners();
  }
}
