import 'package:flutter/material.dart';

// import '../../models/user_model.dart';
// import 'package:firebase_auth/firebase_auth.dart';

class SpaceCreationPage extends StatefulWidget {
  const SpaceCreationPage({super.key});

  @override
  _SpaceCreationPageState createState() => _SpaceCreationPageState();
}

class _SpaceCreationPageState extends State<SpaceCreationPage> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const Text(
            'Nous créons votre espace ...',
            style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            width: 264,
            height: 264,
            child: CircularProgressIndicator(
              strokeWidth: 12,
              valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
            ),
          ),
          const Text(
            'Nous mettons tout en œuvre pour vous assurer une expérience utilisateur sur mesure et un confort dans  vos habitudes quotidiennes.',
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w300,
            ),
            textAlign: TextAlign.center,
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
  }
}
