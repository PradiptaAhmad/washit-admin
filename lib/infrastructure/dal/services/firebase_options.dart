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
    apiKey: 'AIzaSyBxwX80ofWAJ-66jRJqJuR8cfiMdeESqjg',
    appId: '1:181032125482:web:00dae619bbc0dab80c2f53',
    messagingSenderId: '181032125482',
    projectId: 'washit-project',
    authDomain: 'washit-project.firebaseapp.com',
    databaseURL: 'https://washit-project-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'washit-project.appspot.com',
    measurementId: 'G-QDL178EWTP',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAB8iFrkS4NoruDS4lhZ0l04uonluDgB4Y',
    appId: '1:181032125482:android:d76e211d4338e68c0c2f53',
    messagingSenderId: '181032125482',
    projectId: 'washit-project',
    databaseURL: 'https://washit-project-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'washit-project.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCOHQmGuDULpQEXMcu26yyCSgbUaIRdFzk',
    appId: '1:181032125482:ios:b23c3e1fe89d30300c2f53',
    messagingSenderId: '181032125482',
    projectId: 'washit-project',
    databaseURL: 'https://washit-project-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'washit-project.appspot.com',
    iosBundleId: 'com.example.washitAdmin',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCOHQmGuDULpQEXMcu26yyCSgbUaIRdFzk',
    appId: '1:181032125482:ios:39f3907d32965df60c2f53',
    messagingSenderId: '181032125482',
    projectId: 'washit-project',
    databaseURL: 'https://washit-project-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'washit-project.appspot.com',
    iosBundleId: 'com.example.washitAdmin.RunnerTests',
  );
}