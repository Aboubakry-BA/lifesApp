import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  // renvoie l'utilisateur actuellement connecté
  Object? get currentUser => _firebaseAuth.currentUser;

  // méthode pour enregistrer un nouvel utilisateur avec l'adresse e-mail et le mot de passe
  Future<Object?> registerWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      UserCredential result =
          await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      User? user = result.user;

      // Send email verification to the user
      await user?.sendEmailVerification();

      // Check if the user has verified their email
      if (user?.emailVerified == false) {
        throw FirebaseAuthException(
          code: 'email-not-verified',
          message:
              'Pour continuer, vous devez d\'abord vérifier votre adresse e-mail en cliquant sur le lien de vérification que nous avons envoyé à votre adresse e-mail.',
        );
      }

      return user;
    } on FirebaseAuthException catch (e) {
      throw e;
    }
  }

  // méthode pour connecter un utilisateur avec l'adresse e-mail et le mot de passe
  Future<Object?> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      UserCredential result = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      if (!user!.emailVerified) {
        throw FirebaseAuthException(
          code: 'email-not-verified',
          message:
              'Vous devez vérifier votre adresse e-mail avant de continuer.',
        );
      }
      return user;
    } on FirebaseAuthException catch (e) {
      throw e;
    }
  }

  // méthode pour déconnecter l'utilisateur actuel
  Future<void> signOut() async {
    try {
      await _firebaseAuth.signOut();
    } on FirebaseAuthException catch (e) {
      throw e;
    }
  }
}
