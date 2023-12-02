// Firebase összekötésénél jön létre
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
    apiKey: 'AIzaSyDdmWlMBjiHpZEXhvslEckJDwK2zDT5ubs',
    appId: '1:323318676450:web:e117988e2e1640faa1d7bb',
    messagingSenderId: '323318676450',
    projectId: 'fgdh-74592',
    authDomain: 'fgdh-74592.firebaseapp.com',
    storageBucket: 'fgdh-74592.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyB00o4-ticI3Bt7cP54shxEFBteqGVwyII',
    appId: '1:323318676450:android:d2777d9ce3ea2294a1d7bb',
    messagingSenderId: '323318676450',
    projectId: 'fgdh-74592',
    storageBucket: 'fgdh-74592.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCW9bFJb57_hiGGzOuP-a1vYII7LhW2uOs',
    appId: '1:323318676450:ios:4c4020944a1a9c62a1d7bb',
    messagingSenderId: '323318676450',
    projectId: 'fgdh-74592',
    storageBucket: 'fgdh-74592.appspot.com',
    iosBundleId: 'com.example.webControl',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCW9bFJb57_hiGGzOuP-a1vYII7LhW2uOs',
    appId: '1:323318676450:ios:d71c98b976dba59da1d7bb',
    messagingSenderId: '323318676450',
    projectId: 'fgdh-74592',
    storageBucket: 'fgdh-74592.appspot.com',
    iosBundleId: 'com.example.webControl.RunnerTests',
  );
}
