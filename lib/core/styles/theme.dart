import 'package:bingo/core/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DefaultAppThemes {
  static final darkTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: AppColors.bgDark,
    primaryColor: AppColors.primary,
    bottomSheetTheme:
        const BottomSheetThemeData(backgroundColor: AppColors.bgDark),
    cardColor: AppColors.cardBgDark,
    focusColor: Colors.white,
    appBarTheme: const AppBarTheme(elevation: 0, color: AppColors.bgDark),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: AppColors.primary,
    ),
    inputDecorationTheme: const InputDecorationTheme(
      fillColor: AppColors.cardBgDark,
      hintStyle: TextStyle(
        fontWeight: FontWeight.normal,
        fontSize: 16,
      ),
    ),
    textTheme: TextTheme(
      displaySmall: GoogleFonts.roboto(
          textStyle: const TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.w400,
        color: AppColors.textDark,
      )),
      headlineMedium: GoogleFonts.roboto(
          textStyle: const TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w800,
        color: AppColors.textDark,
      )),
      headlineSmall: GoogleFonts.roboto(
          textStyle: const TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w800,
        color: AppColors.textDark,
      )),
      titleLarge: GoogleFonts.roboto(
          textStyle: const TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.w800,
        color: AppColors.textDark,
      )),
      titleMedium: GoogleFonts.roboto(
          textStyle: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w800,
        color: AppColors.textDark,
      )),
      titleSmall: GoogleFonts.roboto(
          textStyle: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w700,
        color: AppColors.textDark,
      )),
      bodyLarge: GoogleFonts.roboto(
          textStyle: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: AppColors.textDark,
      )),
      bodyMedium: GoogleFonts.roboto(
          textStyle: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: AppColors.textDark,
      )),
      bodySmall: GoogleFonts.roboto(
          textStyle: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: AppColors.textDark,
      )),
      labelLarge: GoogleFonts.inriaSans(
          textStyle: const TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w700,
        color: AppColors.textDark,
      )),
      labelMedium: GoogleFonts.inriaSans(
          textStyle: const TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: AppColors.textDark,
      )),
      labelSmall: GoogleFonts.inriaSans(
          textStyle: const TextStyle(
        fontSize: 10,
        fontWeight: FontWeight.w500,
        color: AppColors.textDark,
      )),
    ),
    colorScheme:
        const ColorScheme.dark().copyWith(background: AppColors.bgDark),
  );

  static final lightTheme = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: AppColors.bgLight,
    primaryColor: AppColors.primary,
    colorScheme:
        const ColorScheme.light().copyWith(background: AppColors.bgLight),
    bottomSheetTheme:
        const BottomSheetThemeData(backgroundColor: AppColors.bgLight),
    cardColor: AppColors.white,
    focusColor: AppColors.grey,
    appBarTheme: const AppBarTheme(elevation: 0, color: AppColors.bgLight),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: AppColors.primary,
    ),
    inputDecorationTheme: const InputDecorationTheme(
      fillColor: Colors.white,
      hintStyle: TextStyle(
        fontWeight: FontWeight.normal,
        fontSize: 16,
      ),
    ),
    textTheme: TextTheme(
      displaySmall: GoogleFonts.roboto(
          textStyle: const TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.w400,
        color: AppColors.textLight,
      )),
      headlineMedium: GoogleFonts.roboto(
          textStyle: const TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w800,
        color: AppColors.textLight,
      )),
      headlineSmall: GoogleFonts.roboto(
          textStyle: const TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w800,
        color: AppColors.textLight,
      )),
      titleLarge: GoogleFonts.roboto(
          textStyle: const TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.w800,
        color: AppColors.textLight,
      )),
      titleMedium: GoogleFonts.roboto(
          textStyle: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w800,
        color: AppColors.textLight,
      )),
      titleSmall: GoogleFonts.roboto(
          textStyle: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w700,
        color: AppColors.textLight,
      )),
      bodyLarge: GoogleFonts.roboto(
          textStyle: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: AppColors.textLight,
      )),
      bodyMedium: GoogleFonts.roboto(
          textStyle: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: AppColors.textLight,
      )),
      bodySmall: GoogleFonts.roboto(
          textStyle: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: AppColors.textLight,
      )),
      labelLarge: GoogleFonts.inriaSans(
          textStyle: const TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w700,
        color: AppColors.textLight,
      )),
      labelMedium: GoogleFonts.inriaSans(
          textStyle: const TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: AppColors.textLight,
      )),
      labelSmall: GoogleFonts.inriaSans(
          textStyle: const TextStyle(
        fontSize: 10,
        fontWeight: FontWeight.w500,
        color: AppColors.textLight,
      )),
    ),
  );
}
