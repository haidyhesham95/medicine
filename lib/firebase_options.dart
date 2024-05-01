// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
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
    apiKey: 'AIzaSyDbezYz8KXSbTotXxtYaOv-Uj-fqaDCIJQ',
    appId: '1:348491673932:web:729115a8c083d2b15d5fe9',
    messagingSenderId: '348491673932',
    projectId: 'pharmacy-7e07a',
    authDomain: 'pharmacy-7e07a.firebaseapp.com',
    storageBucket: 'pharmacy-7e07a.appspot.com',
    measurementId: 'G-PHWL9W6EFL',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyA1aj-2oWVc43yCNBjA5OMu-eHvpAUbCAo',
    appId: '1:348491673932:android:5fe3b286ccddde2b5d5fe9',
    messagingSenderId: '348491673932',
    projectId: 'pharmacy-7e07a',
    storageBucket: 'pharmacy-7e07a.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAEiZCLVW5QMVZzPO0kQkB-r18FnJI2RHE',
    appId: '1:348491673932:ios:5cd1ee1f070fd5215d5fe9',
    messagingSenderId: '348491673932',
    projectId: 'pharmacy-7e07a',
    storageBucket: 'pharmacy-7e07a.appspot.com',
    iosBundleId: 'com.example.pharmacy',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAEiZCLVW5QMVZzPO0kQkB-r18FnJI2RHE',
    appId: '1:348491673932:ios:5cd1ee1f070fd5215d5fe9',
    messagingSenderId: '348491673932',
    projectId: 'pharmacy-7e07a',
    storageBucket: 'pharmacy-7e07a.appspot.com',
    iosBundleId: 'com.example.pharmacy',
  );
}