import 'package:flutter/material.dart';

// Updated color palette with blue-related colors
const Color customPrimaryColor = Color(0xFF64B5F6); // Primary blue
const Color customAccentColor =
    Color.fromARGB(255, 135, 198, 250); // Light blue accent
const Color customErrorColor = Color(0xFFEB5757); // Error red
const Color customSecondaryColor = Color(0xFFFFFFFF); // White
const Color customBlackColor = Colors.black; // Black
const Color customGreenColor = Color.fromARGB(255, 17, 102, 20); // Green

const surfaceColor = Color(0xFFF8F7FF); // Very light purple for surfaces
const textColorPrimary = Color(0xFF2D2B52); // Dark purple for primary text

// Additional semantic colors for specific use cases
const Color surfaceBackground = Color(0xFFF9F9F9); // Light grey for backgrounds
const Color textPrimary = Color(0xFF2D3142); // Dark grey for primary text
const Color textSecondary = Color(0xFF757575); // Medium grey for secondary text
const Color dividerColor = Color(0xFFE0E0E0); // Light grey for dividers

const FontWeight w900Font = FontWeight.w900;
const FontWeight w800Font = FontWeight.w800;
const FontWeight w700Font = FontWeight.w700;
const FontWeight boldFont = FontWeight.bold;
const FontWeight w500Font = FontWeight.w500;
const FontWeight w400Font = FontWeight.w400;
const FontWeight w300Font = FontWeight.w300;
const double borderRadius = 3.0;
const double titleFontSize = 20.0;
const double subtitleFontSize = 16;
const double caparolBrandingTextSize = 40;
const FontWeight titleFontWeight = w700Font;
const FontWeight subTitleFontWeight = w400Font;
const double headFontSize = 18.0;
const double textFontSize = 12.0;
const double appBarIconSize = 23.0;
const double labelMargin = 10.0;
const double margin = 20.0;
const double maxImageSize = 5242880;
const double maxProfileSize = 4990000;

const textColorSecondary =
    Color(0xFF6E6C8F); // Medium purple for secondary text
const cardColor = Colors.white;
const accentColor = Color(0xFFEDE9FE); // Very light purple for accents

final ThemeData appLightTheme = ThemeData(
  brightness: Brightness.light,

  primaryColor: customPrimaryColor,
  scaffoldBackgroundColor: const Color(0xFFF3F8FD),
  // Light blue background
  colorScheme: const ColorScheme.light(
    primary: customPrimaryColor,
    secondary: customAccentColor,
    error: customErrorColor,
    surface: Colors.white,
  ),
  fontFamily: 'Roboto',
  appBarTheme: const AppBarTheme(
    backgroundColor: customPrimaryColor,
    titleTextStyle: TextStyle(
        color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
    iconTheme: IconThemeData(color: Colors.white),
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: Colors.white,
    selectedItemColor: customPrimaryColor,
    unselectedItemColor: Colors.grey,
    selectedIconTheme: IconThemeData(size: 30),
    unselectedIconTheme: IconThemeData(size: 20),
    selectedLabelStyle: TextStyle(fontSize: 15),
    unselectedLabelStyle: TextStyle(fontSize: 13),
  ),
  buttonTheme: const ButtonThemeData(
    buttonColor: customPrimaryColor,
    shape: RoundedRectangleBorder(),
    textTheme: ButtonTextTheme.primary,
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: customAccentColor,
      foregroundColor: Colors.white,
      textStyle: const TextStyle(fontWeight: FontWeight.bold),
    ),
  ),
  cardColor: const Color.fromARGB(255, 38, 38, 38),

  textTheme: const TextTheme(
    displayLarge: TextStyle(
        fontSize: 57, fontWeight: FontWeight.bold, color: Colors.black),
    displayMedium: TextStyle(
        fontSize: 45, fontWeight: FontWeight.bold, color: Colors.black),
    displaySmall: TextStyle(
        fontSize: 36, fontWeight: FontWeight.w500, color: Colors.black),
    headlineLarge: TextStyle(
        fontSize: 32, fontWeight: FontWeight.bold, color: Colors.black),
    headlineMedium: TextStyle(
        fontSize: 28, fontWeight: FontWeight.bold, color: Colors.black),
    headlineSmall: TextStyle(
        fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black),
    titleLarge: TextStyle(
        fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
    titleMedium: TextStyle(
        fontSize: 16, fontWeight: FontWeight.w600, color: Colors.black),
    titleSmall: TextStyle(
        fontSize: 14, fontWeight: FontWeight.w500, color: Colors.grey),
    bodyLarge: TextStyle(
        fontSize: 17, fontWeight: FontWeight.w500, color: Colors.black),
    bodyMedium: TextStyle(
        fontSize: 14, fontWeight: FontWeight.w400, color: Colors.black),
    bodySmall: TextStyle(
        fontSize: 12, fontWeight: FontWeight.w400, color: Colors.grey),
    labelLarge: TextStyle(
        fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black),
    labelMedium: TextStyle(
        fontSize: 12, fontWeight: FontWeight.w500, color: Colors.grey),
    labelSmall: TextStyle(
        fontSize: 11, fontWeight: FontWeight.w400, color: Colors.white),
  ),
  iconTheme: const IconThemeData(color: Colors.black),
  inputDecorationTheme: InputDecorationTheme(
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(color: Color.fromARGB(255, 57, 57, 57)),
    ),
  ),
);

final ThemeData appDarkTheme = ThemeData(
  brightness: Brightness.dark,
  primaryColor: customPrimaryColor,
  scaffoldBackgroundColor: const Color(0xFF121212),
  // Dark background
  colorScheme: const ColorScheme.dark(
    primary: customPrimaryColor,
    secondary: customAccentColor,
    error: customErrorColor,
    surface: Color(0xFF1E1E1E),
  ),
  fontFamily: 'Roboto',
  appBarTheme: const AppBarTheme(
    backgroundColor: customPrimaryColor,
    titleTextStyle: TextStyle(
        color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
    iconTheme: IconThemeData(color: Colors.white),
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: Color.fromARGB(255, 43, 43, 43),
    selectedItemColor: customAccentColor,
    unselectedItemColor: Colors.grey,
    selectedIconTheme: IconThemeData(size: 30),
    unselectedIconTheme: IconThemeData(size: 20),
    selectedLabelStyle: TextStyle(fontSize: 15),
    unselectedLabelStyle: TextStyle(fontSize: 13),
  ),
  buttonTheme: const ButtonThemeData(
    buttonColor: customAccentColor,
    shape: RoundedRectangleBorder(),
    textTheme: ButtonTextTheme.primary,
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: customAccentColor,
      foregroundColor: Colors.white,
      textStyle: const TextStyle(fontWeight: FontWeight.bold),
    ),
  ),
  cardColor: const Color.fromARGB(173, 102, 102, 102),
  textTheme: const TextTheme(
    displayLarge: TextStyle(
        fontSize: 57, fontWeight: FontWeight.bold, color: Colors.white),
    displayMedium: TextStyle(
        fontSize: 45, fontWeight: FontWeight.bold, color: Colors.white),
    displaySmall: TextStyle(
        fontSize: 36, fontWeight: FontWeight.w500, color: Colors.white),
    headlineLarge: TextStyle(
        fontSize: 32, fontWeight: FontWeight.bold, color: Colors.white),
    headlineMedium: TextStyle(
        fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white),
    headlineSmall: TextStyle(
        fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
    titleLarge: TextStyle(
        fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
    titleMedium: TextStyle(
        fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white),
    titleSmall: TextStyle(
        fontSize: 14, fontWeight: FontWeight.w500, color: Colors.grey),
    bodyLarge: TextStyle(
        fontSize: 17, fontWeight: FontWeight.w500, color: Colors.white),
    bodyMedium: TextStyle(
        fontSize: 14, fontWeight: FontWeight.w400, color: Colors.white),
    bodySmall: TextStyle(
        fontSize: 12, fontWeight: FontWeight.w400, color: Colors.grey),
    labelLarge: TextStyle(
        fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black),
    labelMedium: TextStyle(
        fontSize: 12, fontWeight: FontWeight.w500, color: Colors.white),
    labelSmall: TextStyle(
        fontSize: 11, fontWeight: FontWeight.w400, color: Colors.white),
  ),
  iconTheme: const IconThemeData(color: Colors.white),
  inputDecorationTheme: InputDecorationTheme(
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(color: customPrimaryColor),
    ),
  ),
);
