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
    apiKey: 'AIzaSyChditYKOapAEeFDnXxGOuAftS4KaJRozM',
    appId: '1:745013073848:web:8115df23950ede9574a14d',
    messagingSenderId: '745013073848',
    projectId: 'lassy-661fb',
    authDomain: 'lassy-661fb.firebaseapp.com',
    databaseURL: 'https://lassy-661fb-default-rtdb.firebaseio.com',
    storageBucket: 'lassy-661fb.appspot.com',
    measurementId: 'G-MWK12VV04V',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBSscrFfDN0-eTouypyKrpe35jphKmly9g',
    appId: '1:745013073848:android:72b0fbc2d950b6ab74a14d',
    messagingSenderId: '745013073848',
    projectId: 'lassy-661fb',
    databaseURL: 'https://lassy-661fb-default-rtdb.firebaseio.com',
    storageBucket: 'lassy-661fb.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyA-_qbB8RnloiZOctAfd1K2pHLnnS7aGh8',
    appId: '1:745013073848:ios:c5486cc4a6fe893e74a14d',
    messagingSenderId: '745013073848',
    projectId: 'lassy-661fb',
    databaseURL: 'https://lassy-661fb-default-rtdb.firebaseio.com',
    storageBucket: 'lassy-661fb.appspot.com',
    iosBundleId: 'com.example.pruebaone',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyA-_qbB8RnloiZOctAfd1K2pHLnnS7aGh8',
    appId: '1:745013073848:ios:871dbe4c339b5f5974a14d',
    messagingSenderId: '745013073848',
    projectId: 'lassy-661fb',
    databaseURL: 'https://lassy-661fb-default-rtdb.firebaseio.com',
    storageBucket: 'lassy-661fb.appspot.com',
    iosBundleId: 'com.example.pruebaone.RunnerTests',
  );
}
