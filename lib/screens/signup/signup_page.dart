import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../theme/app_theme.dart';
import '../signin/signin_page.dart';
// import '../connect/connect_page.dart';

import '../../models/user_model.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_text_field.dart';

import '../../providers/auth_provider.dart';
import '../../providers/theme_mode_provider.dart';
// import 'package:firebase_auth/firebase_auth.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  late AuthProvider _authProvider;
  final _formKey = GlobalKey<FormState>();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _acceptPolicies = false;

  late UserData _user;

  bool _isLoading = false;

  bool _obscureText1 = true;
  bool _obscureText2 = true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _authProvider = Provider.of<AuthProvider>(context);
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      if (!_acceptPolicies) {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('Attention'),
              content: Text(
                  'Vous devez accepter les règles de confidentialité et politique de données pour accéder à l\'application'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('OK'),
                ),
              ],
            );
          },
        );
        return;
      } else {
        setState(() {
          _user = UserData(
            firstName: _firstNameController.text,
            lastName: _lastNameController.text,
            email: _emailController.text,
            password: _passwordController.text,
            acceptPolicies: _acceptPolicies,
          );

          _isLoading = true;
        });

        final result = await _authProvider.registerWithEmailAndPassword(
          email: _user.email,
          password: _user.password,
        );

        if (result.toString() ==
            'Pour continuer, vous devez d\'abord vérifier votre adresse e-mail en cliquant sur le lien de vérification que nous avons envoyé à votre adresse e-mail.') {
          // l'utilisateur a été enregistré avec succès et un email de vérification a été envoyé
          // naviguer vers la page suivante
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (BuildContext context) {
                return const SigninPage();
              },
            ),
          );
        }

        var snackBar = SnackBar(
          content: Text(result.toString()),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);

        setState(() {
          _isLoading = false; // Arrête le chargement
        });
      }
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
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.asset('assets/images/LifeS2.png'),
                          const SizedBox(height: 12.0),
                          const Text(
                            'Tout commence ici.',
                            style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 24.0),
                        ],
                      ),
                      Column(
                        children: [
                          CustomTextField(
                            label: 'Nom de famille',
                            controller: _lastNameController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Veuillez entrer votre nom de famille';
                              }
                              return null;
                            },
                            suffixIcon: const Icon(
                              Icons.person_outlined,
                              color: Colors.white38,
                            ),
                            autofillHints: const [AutofillHints.familyName],
                            keyboardType: TextInputType.name,
                          ),
                          const SizedBox(height: 12.0),
                          CustomTextField(
                            label: 'Prénoms',
                            controller: _firstNameController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Veuillez entrer votre prénom';
                              }
                              return null;
                            },
                            autofillHints: const [AutofillHints.givenName],
                            keyboardType: TextInputType.name,
                          ),
                          const SizedBox(height: 12.0),
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
                          const SizedBox(height: 12.0),
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
                                  _obscureText1 = !_obscureText1;
                                });
                              },
                            ),
                            obscureText: _obscureText1,
                            autofillHints: const [AutofillHints.newPassword],
                            keyboardType: TextInputType.visiblePassword,
                          ),
                          const SizedBox(height: 12.0),
                          CustomTextField(
                            label: 'Confirmer le mot de passe',
                            controller: _confirmPasswordController,
                            validator: (value) {
                              final password = _passwordController.text;
                              final confirmPassword =
                                  _confirmPasswordController.text;
                              if (confirmPassword.isEmpty) {
                                return 'Veuillez confirmer votre mot de passe';
                              }
                              if (password != confirmPassword) {
                                return 'Les mots de passe ne correspondent pas';
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
                                  _obscureText2 = !_obscureText2;
                                });
                              },
                            ),
                            obscureText: _obscureText2,
                            autofillHints: const [AutofillHints.password],
                            keyboardType: TextInputType.visiblePassword,
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Checkbox(
                            value: _acceptPolicies,
                            onChanged: (value) {
                              setState(() {
                                _acceptPolicies = value ?? false;
                              });
                            },
                            checkColor: Colors.black,
                            fillColor:
                                const MaterialStatePropertyAll(Colors.white),
                          ),
                          const Flexible(
                            child: Text(
                              'J’atteste avoir lu et accepter les règles de confidentialité et politique de données',
                              style: TextStyle(
                                fontSize: 10.0,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
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
      ),
    );
  }
}
