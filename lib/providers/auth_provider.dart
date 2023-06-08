import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:lifes/services/auth_service.dart';

class AuthProvider with ChangeNotifier {
  final AuthService _authService = AuthService();

  // méthode pour renvoyer l'utilisateur actuellement connecté
  Object? get currentUser => _authService.currentUser;

  // méthode pour enregistrer un nouvel utilisateur avec l'adresse e-mail et le mot de passe
  Future<Object?> registerWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      Object? user = await _authService.registerWithEmailAndPassword(
        email: email,
        password: password,
      );

      // faire quelque chose avec l'utilisateur enregistré, comme l'enregistrer dans une base de données Firestore

      notifyListeners();

      return user;
    } on FirebaseAuthException catch (e) {
      print(e.toString());

      String errorMessage;

      if (e.code == 'weak-password') {
        errorMessage = 'Le mot de passe est trop faible.';
      } else if (e.code == 'email-already-in-use') {
        errorMessage = 'Un compte avec cet e-mail existe déjà.';
      } else if (e.code == 'email-not-verified') {
        errorMessage =
            'Pour continuer, vous devez d\'abord vérifier votre adresse e-mail en cliquant sur le lien de vérification que nous avons envoyé à votre adresse e-mail.';
      } else {
        errorMessage = 'Une erreur est survenue. Veuillez réessayer plus tard.';
      }

      print(errorMessage);

      return errorMessage;
    }
  }

  // méthode pour connecter un utilisateur avec l'adresse e-mail et le mot de passe
  Future<Object?> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      Object? user = await _authService.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      notifyListeners();

      return user;
    } on FirebaseAuthException catch (e) {
      // gérer l'erreur ici
      print(e.toString());

      String errorMessage;

      if (e.code == 'user-not-found') {
        errorMessage =
            'L\'adresse e-mail ou le mot de passe est incorrect. Veuillez réessayer.';
      } else if (e.code == 'wrong-password') {
        errorMessage =
            'L\'adresse e-mail ou le mot de passe est incorrect. Veuillez réessayer.';
      } else if (e.code == 'email-not-verified') {
        errorMessage =
            'Vous devez vérifier votre adresse e-mail avant de continuer.';
      } else {
        errorMessage = 'Une erreur est survenue. Veuillez réessayer plus tard.';
      }

      print(errorMessage);

      return errorMessage;
    }
  }

  // méthode pour déconnecter l'utilisateur actuel
  Future<Object?> signOut() async {
    try {
      await _authService.signOut();

      notifyListeners();
    } on FirebaseAuthException catch (e) {
      print(e.toString());
      String errorMessage =
          'Une erreur est survenue. Veuillez réessayer plus tard.';
      print(errorMessage);
      return errorMessage;
    }
    return null;
  }
}
