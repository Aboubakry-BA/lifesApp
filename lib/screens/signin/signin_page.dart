import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../theme/app_theme.dart';
import '../infos/infos_page.dart';

import '../../models/user_model.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_text_field.dart';

import '../../providers/auth_provider.dart';
import '../../providers/theme_mode_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SigninPage extends StatefulWidget {
  const SigninPage({Key? key}) : super(key: key);

  @override
  _SigninPageState createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {
  late AuthProvider _authProvider;
  bool _isLoading = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _authProvider = Provider.of<AuthProvider>(context);
  }

  final _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  late UserData _user;
  bool _obscureText = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
        _user = UserData(
          firstName: '',
          lastName: '',
          email: _emailController.text,
          password: _passwordController.text,
          acceptPolicies: true,
        );
      });

      final result = await _authProvider.signInWithEmailAndPassword(
        email: _user.email,
        password: _user.password,
      );

      if (result is User) {
        // L'utilisateur est connecté avec succès
        // Naviguer vers la page suivante
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (BuildContext context) {
              return const InfosPage();
            },
          ),
        );
      } else {
        // Il y a eu une erreur lors de la connexion de l'utilisateur
        // Afficher un message d'erreur à l'utilisateur
        var snackBar = SnackBar(
          content: Text(result.toString()),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }

      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<ThemeModeProvider>(
        builder: (context, themeModeProvider, child) {
          final isDarkMode = themeModeProvider.getThemeMode() == ThemeMode.dark;

          return Container(
            decoration:
                isDarkMode ? AppTheme.darkBackground : AppTheme.lightBackground,
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
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset('assets/images/LifeS3.png'),
                              Image.asset(
                                'assets/images/logo_LifeS.png',
                                height: 70,
                              ),
                            ],
                          ),
                          const SizedBox(height: 4.0),
                          const Text(
                            'Bienvenue à vous !',
                            style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 24.0),
                        ],
                      ),
                      Column(
                        children: [
                          CustomTextField(
                            label: 'Adresse email',
                            controller: _emailController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Veuillez entrer votre adresse e-mail';
                              }
                              if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                                  .hasMatch(value)) {
                                return 'Adresse e-mail invalide';
                              }
                              return null;
                            },
                            suffixIcon: const Icon(
                              Icons.email_outlined,
                              color: Colors.white38,
                            ),
                            keyboardType: TextInputType.emailAddress,
                            autofillHints: const [AutofillHints.email],
                          ),
                          const SizedBox(height: 16.0),
                          CustomTextField(
                            label: 'Mot de passe',
                            controller: _passwordController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Veuillez entrer votre mot de passe';
                              }
                              if (value.length < 6) {
                                return 'Le mot de passe doit contenir au moins 6 caractères';
                              }
                              return null;
                            },
                            suffixIcon: IconButton(
                              icon: const Icon(
                                Icons.remove_red_eye_outlined,
                                color: Colors.white38,
                              ),
                              onPressed: () {
                                setState(() {
                                  _obscureText = !_obscureText;
                                });
                              },
                            ),
                            obscureText: _obscureText,
                            autofillHints: const [AutofillHints.password],
                            keyboardType: TextInputType.visiblePassword,
                          ),
                          const SizedBox(height: 24.0),
                        ],
                      ),
                      Center(
                        child: _isLoading
                            ? CircularProgressIndicator() // Affiche le loader circulaire lorsque _isLoading est true
                            : CustomButton(
                                text: 'Se connecter',
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
      ),
    );
  }
}
