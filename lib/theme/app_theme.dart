import 'package:flutter/material.dart';

class AppTheme {
  static final BoxDecoration lightBackground = BoxDecoration(
    image: DecorationImage(
      image: AssetImage('assets/images/light_bg.png'),
      fit: BoxFit.fill,
    ),
  );

  static final BoxDecoration darkBackground = BoxDecoration(
    image: DecorationImage(
      image: AssetImage('assets/images/dark_bg.png'),
      fit: BoxFit.fill,
    ),
  );

  static final ThemeData lightTheme = ThemeData.light().copyWith(
    // Customize the light theme
    scaffoldBackgroundColor: Colors.white,
    // Customize the text color
    textTheme: ThemeData.light().textTheme.apply(
          fontFamily: 'Montserrat',
          bodyColor: Colors.black,
          displayColor: Colors.black,
        ),
  );

  static final ThemeData darkTheme = ThemeData.dark().copyWith(
    // Customize the dark theme
    scaffoldBackgroundColor: Colors.black,
    // Customize the text color
    textTheme: ThemeData.dark().textTheme.apply(
          fontFamily: 'Montserrat',
          bodyColor: Colors.white,
          displayColor: Colors.white,
        ),
  );
}
