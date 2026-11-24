import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../constants/app_constants.dart';

class ThemeCubit extends Cubit<ThemeMode> {
  ThemeCubit() : super(ThemeMode.light) {
    _loadSavedTheme();
  }

  Future<void> _loadSavedTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final savedTheme = prefs.getString(AppConstants.themeKey);
    if (savedTheme != null) {
      if (savedTheme == 'dark') {
        emit(ThemeMode.dark);
      } else if (savedTheme == 'light') {
        emit(ThemeMode.light);
      } else {
        emit(ThemeMode.system);
      }
    }
  }

  Future<void> setThemeMode(ThemeMode mode) async {
    final prefs = await SharedPreferences.getInstance();
    String value = 'light';
    if (mode == ThemeMode.dark) value = 'dark';
    if (mode == ThemeMode.system) value = 'system';
    await prefs.setString(AppConstants.themeKey, value);
    emit(mode);
  }

  void toggleTheme() {
    if (state == ThemeMode.dark) {
      setThemeMode(ThemeMode.light);
    } else {
      setThemeMode(ThemeMode.dark);
    }
  }
}
