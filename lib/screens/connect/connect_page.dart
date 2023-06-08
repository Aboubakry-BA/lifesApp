import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:lifes/theme/app_theme.dart';
import 'package:lifes/screens/signin/signin_page.dart';
import 'package:lifes/screens/signup/signup_page.dart';

import '../../widgets/custom_button.dart';
import '../../providers/theme_mode_provider.dart';

class ConnectPage extends StatelessWidget {
  const ConnectPage({Key? key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Consumer<ThemeModeProvider>(
          builder: (context, themeModeProvider, child) {
            final isDarkMode =
                themeModeProvider.getThemeMode() == ThemeMode.dark;

            return Container(
              decoration: isDarkMode
                  ? AppTheme.darkBackground
                  : AppTheme.lightBackground,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Transform.translate(
                    offset: Offset(0, -40),
                    child: Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/images/bgImage.png'),
                          fit: BoxFit.fill,
                        ),
                      ),
                      width: MediaQuery.of(context).size.width,
                      height: 0.55 * MediaQuery.of(context).size.height,
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(0, 0, 0, 70),
                        child: Image.asset('assets/images/LifeS1.png'),
                      ),
                    ),
                  ),
                  Container(
                    width: 0.88 * MediaQuery.of(context).size.width,
                    margin: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width * 0.06,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        SizedBox(height: 8.0),
                        Text(
                          'Prenez en main votre santé',
                          style: TextStyle(
                            fontSize: 34.0,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: 8.0),
                        Text(
                          'LifeS, c’est votre compagnon de vie',
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 0.7 * MediaQuery.of(context).size.width,
                    margin: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width * 0.15,
                    ),
                    child: Column(
                      children: [
                        const SizedBox(height: 16.0),
                        CustomButton(
                          text: 'Créer un compte',
                          // textColor: Colors.black,
                          // backgroundColor: Colors.white,
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (BuildContext context) {
                                  return const SignupPage();
                                },
                              ),
                            );
                          },
                        ),
                        const SizedBox(height: 16.0),
                        CustomButton(
                          text: 'Se connecter',
                          textColor: Colors.white,
                          backgroundColor: Colors.black,
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (BuildContext context) {
                                  return const SigninPage();
                                },
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Besoin d’assistance ? Appelez le',
                        style: TextStyle(
                          fontSize: 13.0,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      const Text(
                        ' 77 495 43 57',
                        style: TextStyle(
                          fontSize: 13.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
