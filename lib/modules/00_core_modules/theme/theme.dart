import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  AppTheme._();

  // *****************
  // static colors
  // *****************
  // static const Color _lightPrimaryBackgroundColor = Color(0XFFFFFFFF);

  static const Color _lightPrimaryColor = Color(0XFFFFFFFF);
  static const Color _lightSecondaryVariantColor = Color(0XFF2E5834);
  static const Color _lightTertiaryVariantColor = Color(0XFFB5101C);

  // static final Color _lightOnPrimaryColor = Colors.blueGrey.shade200;

  static const Color _lightTextColorVariantWhite = Color(0XFFFFFFFF);
  static const Color _lightTextColorVariantGrey = Color(0XFF7A7676);
  static const Color _lightTextColorVariantBlack = Colors.black;
  // static final Color _darkPrimaryColor = Colors.blueGrey.shade900;
  // static const Color _darkPrimaryVariantColor = Colors.black;
  // static final Color _darkOnPrimaryColor = Colors.blueGrey.shade300;
  // static const Color _darkTextColorPrimary = Colors.white;
  // static final Color _appbarColorDark = Colors.blueGrey.shade800;

  static const Color _iconColor = Colors.white;

  // static const Color _accentColor = Color.fromRGBO(74, 217, 217, 1);

  // *****************
  // Text Style - light
  // *****************
  // static const TextStyle _lightHeading1Text = TextStyle(
  //     color: _lightTextColorVariantDark,
  //     fontFamily: "Rubik",
  //     fontSize: 20,
  //     fontWeight: FontWeight.bold);

  static final TextStyle _lightHeading1Text = GoogleFonts.poppins(
    textStyle: const TextStyle(
        color: _lightTextColorVariantBlack, letterSpacing: .5, fontSize: 48),
  );

  static final TextStyle _lightHeading2Text = GoogleFonts.poppins(
    textStyle: const TextStyle(
        color: _lightTextColorVariantBlack, letterSpacing: .5, fontSize: 40),
  );

  static final TextStyle _lightHeading3Text = GoogleFonts.poppins(
    textStyle: const TextStyle(
        color: _lightTextColorVariantBlack, letterSpacing: .5, fontSize: 33),
  );

  static final TextStyle _lightHeading4Text = GoogleFonts.poppins(
    textStyle: const TextStyle(
        color: _lightTextColorVariantBlack, letterSpacing: .5, fontSize: 28),
  );

  static final TextStyle _lightHeading5Text = GoogleFonts.poppins(
    textStyle: const TextStyle(
        color: _lightTextColorVariantBlack, letterSpacing: .5, fontSize: 23),
  );

  static final TextStyle _lightParagraphText = GoogleFonts.poppins(
    textStyle: const TextStyle(
        color: _lightTextColorVariantBlack, letterSpacing: .5, fontSize: 16),
  );

  static final TextStyle _lightSmallText = GoogleFonts.poppins(
    textStyle: const TextStyle(
        color: _lightTextColorVariantBlack, letterSpacing: .5, fontSize: 12),
  );

  static final TextTheme _lightTextTheme = TextTheme(
    displayLarge: _lightHeading1Text,
    displayMedium: _lightHeading2Text,
    displaySmall: _lightHeading3Text,
    headlineMedium: _lightHeading4Text,
    headlineSmall: _lightHeading5Text,
    bodySmall: _lightSmallText,
    bodyMedium: _lightParagraphText,
  );

  // *****************
  // Text Style - dark
  // *****************
  // static final TextStyle _darkThemeHeadingTextStyle =
  //     _lightHeadingText.copyWith(color: _darkTextColorPrimary);

  // static final TextStyle _darkThemeBodyeTextStyle =
  //     _lightBodyText.copyWith(color: _darkTextColorPrimary);

  // static final TextTheme _darkTextTheme = TextTheme(
  //   displayLarge: _darkThemeHeadingTextStyle,
  //   bodyLarge: _darkThemeBodyeTextStyle,
  // );

  // *****************
  // Theme light/dark
  // *****************

  static final ThemeData lightTheme = ThemeData(
      scaffoldBackgroundColor: _lightPrimaryColor,
      inputDecorationTheme: InputDecorationTheme(
        hintStyle: _lightTextTheme.bodySmall,
        prefixIconColor: _lightPrimaryColor,
        suffixIconColor: _lightPrimaryColor,
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(30),
          ),
        ),
      ),
      appBarTheme: const AppBarTheme(
        color: _lightSecondaryVariantColor,
        iconTheme: IconThemeData(color: _iconColor),
      ),
      textButtonTheme: TextButtonThemeData(
          style: ButtonStyle(
              textStyle: MaterialStateProperty.all(_lightParagraphText))),
      // bottomAppBarColor: _appbarColorLight,
      colorScheme: const ColorScheme.light(
        background: _lightPrimaryColor,
        primary: _lightPrimaryColor,
        onPrimary: _lightTextColorVariantBlack,
        secondary: _lightSecondaryVariantColor,
        onSecondary: _lightTextColorVariantWhite,
        tertiary: _lightTertiaryVariantColor,
        outline: _lightTextColorVariantGrey,

        // secondary: _accentColor,
        // primaryContainer: _lightPrimaryVariantColor,
      ),
      textTheme: _lightTextTheme);

  // static final ThemeData darkTheme = ThemeData(
  //     scaffoldBackgroundColor: _darkPrimaryColor,
  //     appBarTheme: AppBarTheme(
  //         color: _appbarColorDark,
  //         iconTheme: const IconThemeData(color: _iconColor)),
  //     bottomAppBarColor: _appbarColorDark,
  //     colorScheme: ColorScheme.dark(
  //       primary: _darkPrimaryColor,
  //       secondary: _accentColor,
  //       onPrimary: _darkOnPrimaryColor,
  //       primaryContainer: _darkPrimaryVariantColor,
  //     ),
  //     textTheme: _darkTextTheme);
}
