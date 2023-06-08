import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../age/age_page.dart';
import '../../theme/app_theme.dart';

import '../../widgets/custom_button.dart';

import '../../providers/auth_provider.dart';
import '../../providers/theme_mode_provider.dart';
import '../../widgets/custom_radio_button_field.dart';
import '../../widgets/custom_text_field_with_slider.dart';

class InfosPage extends StatefulWidget {
  const InfosPage({Key? key}) : super(key: key);

  @override
  _InfosPageState createState() => _InfosPageState();
}

class _InfosPageState extends State<InfosPage> {
  final _formKey = GlobalKey<FormState>();

  double _poids = 50;
  double _taille = 50;

  final _poidsController = TextEditingController();
  final _tailleController = TextEditingController();
  String _selectedSexe = "";

  bool _isLoading = false;

  @override
  void dispose() {
    _poidsController.dispose();
    _tailleController.dispose();
    super.dispose();
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      var snackBar = SnackBar(
        content: Text(
            '$_selectedSexe ${_poidsController.text}, ${_tailleController.text}'),
      );

      ScaffoldMessenger.of(context).showSnackBar(snackBar);

      // Simulating an asynchronous operation
      // await Future.delayed(Duration(seconds: 2));

      setState(() {
        _isLoading = false;
      });

      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (BuildContext context) {
            return const AgePage();
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
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CustomRadioButton(
                                text: "Femme",
                                image: AssetImage("assets/images/femme.png"),
                                isSelected: _selectedSexe == "Femme",
                                onSelect: () {
                                  setState(() {
                                    _selectedSexe = "Femme";
                                  });
                                },
                              ),
                              CustomRadioButton(
                                text: "Homme",
                                image: AssetImage("assets/images/homme.png"),
                                isSelected: _selectedSexe == "Homme",
                                onSelect: () {
                                  setState(() {
                                    _selectedSexe = "Homme";
                                  });
                                },
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              CustomTextFieldWithSlider(
                                label: 'Poids, KG',
                                controller: _poidsController,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Veuillez entrer votre poids';
                                  }
                                  final poids = double.tryParse(value);
                                  if (poids == null ||
                                      poids < 15 ||
                                      poids > 250) {
                                    return 'Le poids doit être compris entre 15 et 250 kg';
                                  }
                                  return null;
                                },
                                min: 15,
                                max: 250,
                                suffixIcon: const Icon(
                                  Icons.balance_outlined,
                                  color: Colors.white38,
                                ),
                                keyboardType: TextInputType.number,
                                autofillHints: const ["poids"],
                                sliderValue: _poids,
                                onSliderChanged: (value) {
                                  setState(() {
                                    _poids = value;
                                    _poidsController.text =
                                        _poids.toStringAsFixed(0);
                                  });
                                },
                              ),
                              const SizedBox(height: 16.0),
                              CustomTextFieldWithSlider(
                                label: 'Taille, CM',
                                controller: _tailleController,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Veuillez entrer votre taille';
                                  }
                                  final taille = double.tryParse(value);
                                  if (taille == null ||
                                      taille < 15 ||
                                      taille > 250) {
                                    return 'La taille doit être comprise entre 15 et 250 cm';
                                  }
                                  return null;
                                },
                                min: 15,
                                max: 250,
                                suffixIcon: const Icon(
                                  Icons.height_outlined,
                                  color: Colors.white38,
                                ),
                                keyboardType: TextInputType.number,
                                autofillHints: const ["taille"],
                                sliderValue: _taille,
                                onSliderChanged: (value) {
                                  setState(() {
                                    _taille = value;
                                    _tailleController.text =
                                        _taille.toStringAsFixed(0);
                                  });
                                },
                              ),
                              const SizedBox(height: 24.0),
                              Row(
                                children: [
                                  Expanded(
                                    flex: 5,
                                    child: Text(
                                      'L\'IMC sert à évaluer votre masse grasse basée sur votre poids et votre taille',
                                      style: TextStyle(
                                        fontSize: 12.0,
                                        fontWeight: FontWeight.w300,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 5,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.grey[900],
                                        borderRadius:
                                            BorderRadius.circular(7.0),
                                      ),
                                      height: 55.0,
                                      child: Center(
                                        child: Text(
                                          'IMC',
                                          style: TextStyle(
                                            fontSize: 18.0,
                                            color: Colors.white38,
                                            fontWeight: FontWeight.w300,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Center(
                            child: _isLoading
                                ? CircularProgressIndicator() // Affiche le loader circulaire lorsque _isLoading est true
                                : CustomButton(
                                    text: 'Suivant',
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
