import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'typography.dart';

final themeProvider = StateNotifierProvider((ref) {
  return ThemeProvider(true);
});

class ThemeProvider extends StateNotifier<bool> {
  ThemeProvider(super.state);
  bool get getAppCurrentTheme => state;
  changeThemeState() {
    state = !state;
  }

  returnThemeBasedOnBool() {
    return state == true ? Ttheme.lightMode : Ttheme.darkMode;
  }
}

abstract class Ttheme {
  static ThemeData get lightMode {
    return ThemeData(
      textTheme: TextTheme(
        bodyLarge: Ttypography.normalText,
        bodySmall: Ttypography.normalText,
        bodyMedium: Ttypography.normalText,
        titleLarge: Ttypography.normalText,
        titleMedium: Ttypography.normalText,
        titleSmall: Ttypography.normalText,
      ),
    );
  }

  static ThemeData get darkMode {
    return ThemeData.dark().copyWith(
      textTheme: TextTheme(
        bodyLarge: Ttypography.normalText.copyWith(color: Colors.white),
        bodySmall: Ttypography.normalText.copyWith(color: Colors.white),
        bodyMedium: Ttypography.normalText.copyWith(color: Colors.white),
        titleLarge: Ttypography.normalText.copyWith(color: Colors.white),
        titleMedium: Ttypography.normalText.copyWith(color: Colors.white),
        titleSmall: Ttypography.normalText.copyWith(color: Colors.white),
      ),
    );
  }
}
