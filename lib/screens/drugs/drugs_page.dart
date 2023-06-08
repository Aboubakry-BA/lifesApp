import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../theme/app_theme.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_frequence_selector.dart';

import '../../widgets/bottom_navigation.dart';
import '../space_creation/space_creation_page.dart';

import '../../providers/auth_provider.dart';
import '../../providers/theme_mode_provider.dart';

class DrugsPage extends StatefulWidget {
  const DrugsPage({Key? key}) : super(key: key);

  @override
  _DrugsPageState createState() => _DrugsPageState();
}

class _DrugsPageState extends State<DrugsPage> {
  final _formKey = GlobalKey<FormState>();
  String _selectedFrequency = '';
  bool _isLoading = false;

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      setState(() {
        _isLoading = true;
      });

      // Effectuez le traitement asynchrone simulé ici
      await Future.delayed(Duration(seconds: 2));

      setState(() {
        _isLoading = false;
      });

      print(_selectedFrequency);
      var snackBar = SnackBar(
        content: Text('$_selectedFrequency'),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);

      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (BuildContext context) {
            return const BottomNavigationPage();
          },
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<ThemeModeProvider>(
        builder: (context, themeModeProvider, child) {
          final isDarkMode = themeModeProvider.getThemeMode() == ThemeMode.dark;

          return Consumer<AuthProvider>(
            builder: (context, authProvider, child) {
              print(authProvider.currentUser);
              return Container(
                decoration: isDarkMode
                    ? AppTheme.darkBackground
                    : AppTheme.lightBackground,
                child: SingleChildScrollView(
                  child: Container(
                    height: MediaQuery.of(context).size.height,
                    width: 0.83 * MediaQuery.of(context).size.width,
                    margin: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width * 0.065,
                    ),
                    child: _isLoading
                        ? SpaceCreationPage()
                        : Form(
                            key: _formKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Transform.translate(
                                  offset: Offset(-15, 0),
                                  child: IconButton(
                                    icon: Icon(
                                      Icons.arrow_back,
                                      size: 30,
                                    ),
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Image.asset('assets/images/LifeS2.png'),
                                    const SizedBox(height: 12.0),
                                    const Text(
                                      'Combien de fois par jour prenez vous vos médicaments',
                                      style: TextStyle(
                                        fontSize: 21.0,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    const SizedBox(height: 12.0),
                                    const Text(
                                      'Ces informations nous permettent d’assurer un suivi plus personnalisé et de vous rappeler de prendre vos médicaments à temps.',
                                      style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w300,
                                      ),
                                    ),
                                  ],
                                ),
                                Center(
                                  child: Wrap(
                                    direction: Axis.horizontal,
                                    spacing:
                                        12.0, // Espacement horizontal entre les sélecteurs
                                    runSpacing:
                                        12.0, // Espacement vertical entre les lignes de sélecteurs
                                    children: [
                                      for (int i = 0; i <= 5; i++)
                                        CustomFrequenceSelector(
                                          text: 'x$i',
                                          isSelected:
                                              _selectedFrequency == '$i',
                                          onSelect: () {
                                            setState(() {
                                              _selectedFrequency = '$i';
                                            });
                                          },
                                        ),
                                    ],
                                  ),
                                ),
                                Center(
                                  child: CustomButton(
                                    text: 'Suivant',
                                    textColor: Colors.black,
                                    onPressed: _submitForm,
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
                          ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
