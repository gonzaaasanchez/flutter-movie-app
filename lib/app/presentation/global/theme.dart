import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'colors.dart';

ThemeData getTheme(bool darkMode) {
  /// TODO no me terminar de convencer
  /// Trataría de overridear exactamente las mismas
  /// properties en ambos temas (aunque queden con el valor por defecto)
  /// para asegurar que no falte ninguna
  if (darkMode) {
    final darkTheme = ThemeData.dark();
    final textTheme = darkTheme.textTheme;
    const boldStyle = TextStyle(
      fontWeight: FontWeight.bold,
    );
    const darkStyle = TextStyle(
      color: AppColors.dark,
    );
    return darkTheme.copyWith(
      textTheme: GoogleFonts.nunitoSansTextTheme(
        textTheme.copyWith(
          titleSmall: textTheme.titleSmall?.merge(boldStyle),
          titleMedium: textTheme.titleMedium?.merge(boldStyle),
          titleLarge: textTheme.titleLarge?..merge(boldStyle),
          bodySmall: textTheme.bodySmall?.merge(darkStyle),
        ),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.dark,
        elevation: 0,
        titleTextStyle: TextStyle(
          color: Colors.white,
          fontSize: 18,
        ),
      ),
      scaffoldBackgroundColor: AppColors.darkLight,
      canvasColor: AppColors.dark,
      switchTheme: SwitchThemeData(
        thumbColor: const WidgetStatePropertyAll(
          Colors.blue,
        ),
        trackColor: WidgetStatePropertyAll(
          Colors.lightBlue.withOpacity(0.3),
        ),
      ),
    );
  }
  final lightTheme = ThemeData.light();
  final textTheme = lightTheme.textTheme;
  const boldStyle = TextStyle(
    color: AppColors.dark,
    fontWeight: FontWeight.bold,
  );
  const whiteStyle = TextStyle(
    color: Colors.white,
  );
  return lightTheme.copyWith(
    textTheme: GoogleFonts.nunitoSansTextTheme(
      textTheme.copyWith(
        titleSmall: textTheme.titleSmall?.merge(boldStyle),
        titleMedium: textTheme.titleMedium?.merge(boldStyle),
        titleLarge: textTheme.titleLarge?.merge(boldStyle),
        bodySmall: textTheme.bodySmall?.merge(whiteStyle),
      ),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white,
      elevation: 0,
      iconTheme: IconThemeData(
        color: AppColors.dark,
      ),
      titleTextStyle: TextStyle(
        color: AppColors.dark,
        fontSize: 18,
      ),
    ),
    tabBarTheme: const TabBarTheme(
      labelColor: AppColors.dark,
    ),
  );
}
