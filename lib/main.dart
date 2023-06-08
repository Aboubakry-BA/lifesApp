import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

import 'theme/app_theme.dart';
import 'package:provider/provider.dart';
import 'package:lifes/providers/auth_provider.dart';
import 'package:lifes/providers/theme_mode_provider.dart';

// import 'package:lifes/screens/age/age_page.dart';
// import 'package:lifes/screens/home/home_page.dart';
// import 'package:lifes/screens/infos/infos_page.dart';
// import 'package:lifes/widgets/bottom_navigation.dart';
// import 'package:lifes/screens/signup/signup_page.dart';
import 'package:lifes/screens/connect/connect_page.dart';
// import 'package:lifes/screens/diabete_types/diabete_types_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await initialization(null);
  runApp(MyApp());
}

Future initialization(BuildContext? context) async {
  await Future.delayed(Duration(seconds: 2));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthProvider>(
          create: (context) => AuthProvider(),
        ),
        ChangeNotifierProvider<ThemeModeProvider>(
          create: (context) => ThemeModeProvider(),
        ),
      ],
      child: Consumer<ThemeModeProvider>(
        builder: (context, ThemeModeProvider, child) {
          final isDarkMode = ThemeModeProvider.getThemeMode() == ThemeMode.dark;
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'LifeS',
            theme: isDarkMode ? AppTheme.darkTheme : AppTheme.lightTheme,
            home: Consumer<AuthProvider>(
              builder: (context, authProvider, child) {
                if (authProvider.currentUser == null) {
                  return const ConnectPage();
                } else {
                  return const ConnectPage();
                }
              },
            ),
          );
        },
      ),
    );
  }
}
