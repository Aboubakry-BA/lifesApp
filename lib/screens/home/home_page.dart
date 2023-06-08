import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/date_symbol_data_local.dart';

import '../../theme/app_theme.dart';

// import '../../models/user_model.dart';

import '../../widgets/custom_kit.dart';
import '../../widgets/custom_stat.dart';
import '../../widgets/custom_container.dart';

import '../../providers/auth_provider.dart';
import '../../providers/theme_mode_provider.dart';
// import 'package:firebase_auth/firebase_auth.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    // Initialisez les données de localisation
    initializeDateFormatting('fr_FR', null);

    DateTime maintenant = DateTime.now();

    // Format de date personnalisé
    DateFormat formatDate = DateFormat('EEE d MMM', 'fr_FR');

    String dateFormatee = formatDate.format(maintenant);
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
                    margin: EdgeInsets.symmetric(
                      vertical: 50.0,
                      horizontal: MediaQuery.of(context).size.width * 0.065,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Bonjour Abou !',
                                  style: TextStyle(
                                    fontSize: 24.0,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const Icon(Icons.notifications),
                              ],
                            ),
                            const SizedBox(height: 10.0),
                            Text(
                              dateFormatee,
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                            const SizedBox(height: 28.0),
                            CustomContainer(
                              icon: Icons.info,
                              title: 'Penser à activer les notifications',
                              text:
                                  'Permettez nous de vous rappeler de prendre vos médicaments ou de faire votre séance de sport à temps. C’est pour votre bien !',
                              backgroundColor: Colors.blue,
                            ),
                            const SizedBox(height: 28.0),
                            Container(
                              height: 182,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15.0),
                                color: Colors.grey[850],
                              ),
                              padding: EdgeInsets.all(12.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Mon kit',
                                        style: TextStyle(
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      Icon(
                                        Icons.more_vert,
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 16.0),
                                  SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Row(
                                      children: [
                                        CustomKit(
                                          icon1: Icons.circle_outlined,
                                          icon2: Icons.bloodtype,
                                          title: 'Objectifs',
                                          text:
                                              '35% par rapport à la semaine dernière',
                                          iconColor: Colors.red,
                                        ),
                                        SizedBox(width: 12.0),
                                        CustomKit(
                                          icon1: Icons.circle_outlined,
                                          icon2: Icons.bloodtype,
                                          title: 'Objectifs',
                                          text:
                                              '35% par rapport à la semaine dernière',
                                          iconColor: Colors.red,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 16.0),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Favoris',
                                  style: TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Text(
                                  'voir tout',
                                  style: TextStyle(
                                    fontSize: 12.0,
                                    color: Colors.blue,
                                    fontWeight: FontWeight.w300,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 16.0),
                            CustomStat(
                              icon1: Icons.favorite,
                              icon2: Icons.chevron_right,
                              title: 'Rythme cardiaque',
                              text: '104 bt/sec',
                              time: '23:36',
                              iconColor: Colors.red,
                            ),
                            SizedBox(height: 10.0),
                            CustomStat(
                              icon1: Icons.headphones,
                              icon2: Icons.chevron_right,
                              title: 'Pression artérielle',
                              text: '120 mm Hg',
                              time: '12:45',
                              iconColor: Colors.red,
                            ),
                          ],
                        ),
                        SizedBox(height: 16.0),
                        Text(
                          'Mes statistiques',
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: 16.0),
                        CustomStat(
                          icon1: Icons.favorite,
                          icon2: Icons.chevron_right,
                          title: 'Rythme cardiaque',
                          text: '104 bt/sec',
                          time: '23:36',
                          iconColor: Colors.red,
                        ),
                        SizedBox(height: 10.0),
                        CustomStat(
                          icon1: Icons.headphones,
                          icon2: Icons.chevron_right,
                          title: 'Pression artérielle',
                          text: '120 mm Hg',
                          time: '12:45',
                          iconColor: Colors.red,
                        ),
                        SizedBox(height: 32.0),
                      ],
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
