import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../common/constant/configuration/prefs_key.dart';
import '../../../config/theme/app_theme.dart';
import '../../domin/repositories/prefs_repository.dart';
import 'dart:convert' as convert;

class PrefsRepositoryImpl extends PrefsRepository {
  PrefsRepositoryImpl(this._preferences);

  final SharedPreferences _preferences;

  @override
  Future<bool> setToken(String token) => _preferences.setString(PrefsKey.token, token);

  @override
  String? get token => _preferences.getString(PrefsKey.token);

  @override
  ThemeMode get getTheme {
    final res = _preferences.getString(PrefsKey.theme);
    if (res == null) {
      setTheme(defaultAppTheme);
      return defaultAppTheme;
    }
    return defaultAppTheme;
    //return mapAppThemeMode[res]!;
  }

  @override
  Future<bool> setTheme(ThemeMode themeMode) => _preferences.setString(PrefsKey.theme, themeMode.name);

  @override
  Future<bool> clearUser() async {
    await _preferences.remove(PrefsKey.token);
    return _preferences.remove(PrefsKey.user);
  }

  @override
  bool get registeredUser => token != null;
}
