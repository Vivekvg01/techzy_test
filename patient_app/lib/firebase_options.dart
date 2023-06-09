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
    apiKey: 'AIzaSyCEvkEIO8g_uJd3ZW7XHESzzR4616jYCVk',
    appId: '1:302841576200:web:49a3dc0a0965db8caa4abd',
    messagingSenderId: '302841576200',
    projectId: 'videocallapp-b8a90',
    authDomain: 'videocallapp-b8a90.firebaseapp.com',
    storageBucket: 'videocallapp-b8a90.appspot.com',
    measurementId: 'G-3KZ5FZ1695',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyD-2ukM8px8EaW8HFKvHSumrEbJUnY9qZo',
    appId: '1:302841576200:android:906c703053909e95aa4abd',
    messagingSenderId: '302841576200',
    projectId: 'videocallapp-b8a90',
    storageBucket: 'videocallapp-b8a90.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDTiMugwcuYz47sEqQIWO4gVFIIOzioJsw',
    appId: '1:302841576200:ios:e0f9a79a4bfaa7e1aa4abd',
    messagingSenderId: '302841576200',
    projectId: 'videocallapp-b8a90',
    storageBucket: 'videocallapp-b8a90.appspot.com',
    iosClientId: '302841576200-kq8cav95v04b9hpjuqe5sbknd8moqht3.apps.googleusercontent.com',
    iosBundleId: 'patientapp.com.patientApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDTiMugwcuYz47sEqQIWO4gVFIIOzioJsw',
    appId: '1:302841576200:ios:e0f9a79a4bfaa7e1aa4abd',
    messagingSenderId: '302841576200',
    projectId: 'videocallapp-b8a90',
    storageBucket: 'videocallapp-b8a90.appspot.com',
    iosClientId: '302841576200-kq8cav95v04b9hpjuqe5sbknd8moqht3.apps.googleusercontent.com',
    iosBundleId: 'patientapp.com.patientApp',
  );
}
