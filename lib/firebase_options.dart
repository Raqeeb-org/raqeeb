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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyAbZ2Jap00L4fdOXBOAEYuHSOp1MpNCxyo',
    appId: '1:479747832887:web:e59b52cd50e7648c4fd3b2',
    messagingSenderId: '479747832887',
    projectId: 'raqeeb-c6520',
    authDomain: 'raqeeb-c6520.firebaseapp.com',
    storageBucket: 'raqeeb-c6520.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyC23he1X2_AUWyoBKR7YkpmyZN6rQbkE8o',
    appId: '1:479747832887:android:d0910077f515ff994fd3b2',
    messagingSenderId: '479747832887',
    projectId: 'raqeeb-c6520',
    storageBucket: 'raqeeb-c6520.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBrC7qFw2MjQgVcPnFe8IhmolQD5vtvKDw',
    appId: '1:479747832887:ios:f74f7f9da56e3c304fd3b2',
    messagingSenderId: '479747832887',
    projectId: 'raqeeb-c6520',
    storageBucket: 'raqeeb-c6520.appspot.com',
    iosBundleId: 'com.example.raqeeb',
  );
}
