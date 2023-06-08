// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyD5I90r2xYZdOJb8DXeNzUwSeR4yThcYq4',
    appId: '1:352536974823:web:6ef8f474b6800250e71942',
    messagingSenderId: '352536974823',
    projectId: 'lifes-esp',
    authDomain: 'lifes-esp.firebaseapp.com',
    storageBucket: 'lifes-esp.appspot.com',
    measurementId: 'G-05E0Z6RTXL',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBCWMGavZBQ9MdC1Cuzds3nZ69864tqCpM',
    appId: '1:352536974823:android:b1763ed2356f5948e71942',
    messagingSenderId: '352536974823',
    projectId: 'lifes-esp',
    storageBucket: 'lifes-esp.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyB3w_jDy4x8eC89ncfQ3pCygP3_z1X4h60',
    appId: '1:352536974823:ios:8b493e628ed8b627e71942',
    messagingSenderId: '352536974823',
    projectId: 'lifes-esp',
    storageBucket: 'lifes-esp.appspot.com',
    iosClientId: '352536974823-as3bsauekfr73t8kd5icsp4ssqafuoob.apps.googleusercontent.com',
    iosBundleId: 'com.example.lifes',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyB3w_jDy4x8eC89ncfQ3pCygP3_z1X4h60',
    appId: '1:352536974823:ios:8b493e628ed8b627e71942',
    messagingSenderId: '352536974823',
    projectId: 'lifes-esp',
    storageBucket: 'lifes-esp.appspot.com',
    iosClientId: '352536974823-as3bsauekfr73t8kd5icsp4ssqafuoob.apps.googleusercontent.com',
    iosBundleId: 'com.example.lifes',
  );
}