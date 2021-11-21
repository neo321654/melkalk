import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// A service that stores and retrieves user settings.
///
/// By default, this class does not persist user settings. If you'd like to
/// persist the user settings locally, use the shared_preferences package. If
/// you'd like to store settings on a web server, use the http package.
class SettingsService {
  /// Loads the User's preferred ThemeMode from local or remote storage.
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  late final oldThemeMode = _prefs.then((SharedPreferences prefs) {
    return (prefs.getString('ThemeMode') ?? 'dark');
  });

  Future<ThemeMode> themeMode() async {
    switch (await oldThemeMode) {
      case 'dark':
        return ThemeMode.dark;
      case 'light':
        return ThemeMode.light;
      default:
        return ThemeMode.light;
    }
  }

  Future<SharedPreferences> getPref() async {
    return _prefs;
  }

  /// Persists the user's preferred ThemeMode to local or remote storage.
  Future<void> updateThemeMode(ThemeMode theme) async {
    // Use the shared_preferences package to persist settings locally or the
    // http package to persist settings over the network.
    String newTheme = 'light';
    switch (theme) {
      case ThemeMode.dark:
        newTheme = 'dark';
        break;
      case ThemeMode.light:
        newTheme = 'light';
        break;
      case ThemeMode.system:
        newTheme = 'light';
        break;
    }

    _prefs.then((SharedPreferences prefs) {
      prefs.setString('ThemeMode', newTheme);
    });
  }

  Future<void> updateSettings(String category, int val) async {
    _prefs.then((value) {
      //print(value);
      value.setInt(category, val);
    });
  }

  Future<void> updateTimeFormat(String format) async {
    _prefs.then((value) {
      //print(value);
      value.setString("format", format);
    });
  }
}
