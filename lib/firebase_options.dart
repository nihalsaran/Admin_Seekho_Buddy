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
        return windows;
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
    apiKey: 'AIzaSyBmWKEO93cXQlNgvRoVMZ1prohyIA1IGZY',
    appId: '1:379236444299:web:296e341bbadda115228c8e',
    messagingSenderId: '379236444299',
    projectId: 'seekhobuddy',
    authDomain: 'seekhobuddy.firebaseapp.com',
    storageBucket: 'seekhobuddy.appspot.com',
    measurementId: 'G-XRRN2M7MFY',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyB2TVG4QnkJg9AVytJRcrh6iLwQgznc4RI',
    appId: '1:379236444299:android:7e99ff6589f675b4228c8e',
    messagingSenderId: '379236444299',
    projectId: 'seekhobuddy',
    storageBucket: 'seekhobuddy.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyC4SqQj3nQJ9zAJ1oPj3RH-UgIB8DRgZSg',
    appId: '1:379236444299:ios:fbeee03dc014d0e7228c8e',
    messagingSenderId: '379236444299',
    projectId: 'seekhobuddy',
    storageBucket: 'seekhobuddy.appspot.com',
    iosBundleId: 'com.example.seekhoBuddy',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyC4SqQj3nQJ9zAJ1oPj3RH-UgIB8DRgZSg',
    appId: '1:379236444299:ios:fbeee03dc014d0e7228c8e',
    messagingSenderId: '379236444299',
    projectId: 'seekhobuddy',
    storageBucket: 'seekhobuddy.appspot.com',
    iosBundleId: 'com.example.seekhoBuddy',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyBmWKEO93cXQlNgvRoVMZ1prohyIA1IGZY',
    appId: '1:379236444299:web:bd67943470956b16228c8e',
    messagingSenderId: '379236444299',
    projectId: 'seekhobuddy',
    authDomain: 'seekhobuddy.firebaseapp.com',
    storageBucket: 'seekhobuddy.appspot.com',
    measurementId: 'G-GTCJ44LYR7',
  );
}