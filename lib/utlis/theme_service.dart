import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'dart:ui';

class ThemeService {
  ThemeService(IThemeRepository themeRepository) : _themeRepository = themeRepository;
  IThemeRepository _themeRepository;

  //Configurar lightTheme
  ThemeData get lightTheme => ThemeData(
        primarySwatch: Colors.blue,
        accentColor: Colors.blueAccent,
        brightness: Brightness.light,
        scaffoldBackgroundColor: Color(0xFFecf0f1),
        primaryColor: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          foregroundColor: Colors.white,
        ),
      );

  //Configurar darkTheme
  ThemeData get darkTheme => ThemeData(
        primarySwatch: Colors.orange,
        accentColor: Colors.deepOrange,
        appBarTheme: AppBarTheme(color: Colors.pinkAccent),
        primaryColor: Colors.white,
        brightness: Brightness.dark,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        floatingActionButtonTheme:
            FloatingActionButtonThemeData(foregroundColor: Colors.white, backgroundColor: Colors.brown),
      );

  Future<ThemeData> getTheme() async {
    final String themeKey = await _themeRepository.getThemeKey();

    if (themeKey == null) {
      await _themeRepository.setThemeKey(lightTheme.brightness);

      return lightTheme;
    } else {
      return themeKey == "light" ? lightTheme : darkTheme;
    }
  }

  Future<ThemeData> toggleTheme(ThemeData theme) async {
    if (theme == lightTheme) {
      theme = darkTheme;
    } else {
      theme = lightTheme;
    }
    await _themeRepository.setThemeKey(theme.brightness);
    return theme;
  }
}

abstract class IThemeRepository {
  Future<String> getThemeKey();

  Future<void> setThemeKey(Brightness brightness);
}

class ThemeKey {
  static const String THEME = "theme";
}

class ThemeRepository implements IThemeRepository {
  @override
  Future<void> setThemeKey(Brightness brightness) async {
    (await SharedPreferences.getInstance()).setString(
      ThemeKey.THEME,
      brightness == Brightness.light ? "light" : "dark",
    );
  }

  @override
  Future<String> getThemeKey() async {
    return (await SharedPreferences.getInstance()).getString(ThemeKey.THEME);
  }
}
