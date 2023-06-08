import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../drugs/drugs_page.dart';
import '../../theme/app_theme.dart';

import '../../widgets/custom_button.dart';
import '../../widgets/custom_diabete_type.dart';

import '../../providers/auth_provider.dart';
import '../../providers/theme_mode_provider.dart';

class DiabeteTypesPage extends StatefulWidget {
  const DiabeteTypesPage({Key? key}) : super(key: key);

  @override
  _DiabeteTypesPageState createState() => _DiabeteTypesPageState();
}

class _DiabeteTypesPageState extends State<DiabeteTypesPage> {
  final _formKey = GlobalKey<FormState>();

  String selectedDiabetes = '';
  List<Map<String, dynamic>> diabetesTypes = [
    {
      'title': 'Diabète de Type 1',
      'subtitles': [
        'soif excessive',
        'Fatigue',
        'vision floue',
        'Faim constante',
        'urination fréquente',
        'Perte de poids',
      ],
      'isSelected': false,
    },
    {
      'title': 'Diabète de Type 2',
      'subtitles': [
        'soif excessive',
        'Fatigue',
        'vision floue',
        'Faim constante',
        'urination fréquente',
        'Perte de poids',
        'engourdissement',
        'infections fréquentes',
        'démangeaisons',
        'cicatrisation lente',
      ],
      'isSelected': false,
    },
    {
      'title': 'Diabète gestationnel',
      'subtitles': [
        'soif excessive',
        'Fatigue',
        'vision floue',
        'Faim constante',
        'nausées et vomissements',
        'douleurs abdominales',
        'infections fréquentes',
      ],
      'isSelected': false,
    },
    {
      'title': 'Prédiabète',
      'subtitles': [
        'soif excessive',
        'Fatigue',
        'surpoids',
        'Faim constante',
        'urination fréquente',
        'engourdissement des extrémités',
        'vision floue',
      ],
      'isSelected': false,
    },
  ];

  bool _isLoading = false;

  void _selectDiabetes(String title) {
    setState(() {
      selectedDiabetes = title;
      for (var diabetesType in diabetesTypes) {
        if (diabetesType['title'] == title) {
          diabetesType['isSelected'] = true;
        } else {
          diabetesType['isSelected'] = false;
        }
      }
    });
  }

  void _submitForm() async {
    setState(() {
      _isLoading = true;
    });

    // Effectuez le traitement asynchrone simulé ici
    // await Future.delayed(Duration(seconds: 2));

    setState(() {
      _isLoading = false;
    });

    for (var diabetesType in diabetesTypes) {
      if (diabetesType['isSelected']) {
        var snackBar = SnackBar(
          content:
              Text('${diabetesType['title']} ${diabetesType['subtitles']}'),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (BuildContext context) {
              return const DrugsPage();
            },
          ),
        );
      }
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
                                'Dites nous en plus sur vous',
                                style: TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(height: 12.0),
                              const Text(
                                'Pour vous accompagner au mieux, il est important de mieux vous connaitre.',
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                            ],
                          ),
                          Container(
                            height: MediaQuery.of(context).size.height * 0.54,
                            margin: EdgeInsets.symmetric(
                              horizontal:
                                  MediaQuery.of(context).size.width * 0.02,
                            ),
                            child: ListView.builder(
                              itemCount: diabetesTypes.length,
                              itemBuilder: (BuildContext context, int index) {
                                return CustomDiabeteType(
                                  title: diabetesTypes[index]['title'],
                                  subtitles: diabetesTypes[index]['subtitles'],
                                  isSelected: diabetesTypes[index]
                                      ['isSelected'],
                                  onTap: () => _selectDiabetes(
                                      diabetesTypes[index]['title']),
                                );
                              },
                            ),
                          ),
                          Center(
                            child: _isLoading
                                ? CircularProgressIndicator()
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
