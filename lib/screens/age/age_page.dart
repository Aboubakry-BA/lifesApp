import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../theme/app_theme.dart';
import '../diabete_types/diabete_types_page.dart';

import '../../widgets/custom_button.dart';
import '../../widgets/custom_age_selector_field.dart';

import '../../providers/auth_provider.dart';
import '../../providers/theme_mode_provider.dart';

class AgePage extends StatefulWidget {
  const AgePage({Key? key}) : super(key: key);

  @override
  _AgePageState createState() => _AgePageState();
}

class _AgePageState extends State<AgePage> {
  final _formKey = GlobalKey<FormState>();

  int _age = 12;
  bool _isLoading = false;

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      setState(() {
        _isLoading = true;
      });

      // Simulating an asynchronous operation
      // await Future.delayed(Duration(seconds: 2));

      setState(() {
        _isLoading = false;
      });

      var snackBar = SnackBar(
        content: Text('$_age'),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (BuildContext context) {
            return const DiabeteTypesPage();
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
                    width: 0.85 * MediaQuery.of(context).size.width,
                    margin: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width * 0.075,
                    ),
                    child: Form(
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
                                'On customize l’appli pour vous.',
                                style: TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(height: 24.0),
                            ],
                          ),
                          CustomAgeSelector(
                            minValue: 10,
                            maxValue: 99,
                            initialAge: _age,
                            onChanged: (age) {
                              setState(() {
                                _age = age;
                              });
                            },
                          ),
                          Center(
                            child: _isLoading
                                ? CircularProgressIndicator() // Affiche le loader circulaire lorsque _isLoading est true
                                : CustomButton(
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
