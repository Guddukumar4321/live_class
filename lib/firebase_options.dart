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
    apiKey: 'AIzaSyCd49IGwFyD0hAaCE1V1boZ5VR9nQKLdHc',
    appId: '1:547287648953:web:a3561a78952d39d6c96968',
    messagingSenderId: '547287648953',
    projectId: 'weighty-opus-340606',
    authDomain: 'weighty-opus-340606.firebaseapp.com',
    databaseURL: 'https://weighty-opus-340606-default-rtdb.firebaseio.com',
    storageBucket: 'weighty-opus-340606.appspot.com',
    measurementId: 'G-1TH3FH6BNM',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCZUbhiVaWdHSkt0PcmlFpENznsvZCSfF0',
    appId: '1:547287648953:android:70466cd47334cdcac96968',
    messagingSenderId: '547287648953',
    projectId: 'weighty-opus-340606',
    databaseURL: 'https://weighty-opus-340606-default-rtdb.firebaseio.com',
    storageBucket: 'weighty-opus-340606.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDu4RmZeXmBblX2bUjQXVmDjuHI_sI0bfY',
    appId: '1:547287648953:ios:377f29262bb70613c96968',
    messagingSenderId: '547287648953',
    projectId: 'weighty-opus-340606',
    databaseURL: 'https://weighty-opus-340606-default-rtdb.firebaseio.com',
    storageBucket: 'weighty-opus-340606.appspot.com',
    iosBundleId: 'com.example.liveClassroom',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDu4RmZeXmBblX2bUjQXVmDjuHI_sI0bfY',
    appId: '1:547287648953:ios:377f29262bb70613c96968',
    messagingSenderId: '547287648953',
    projectId: 'weighty-opus-340606',
    databaseURL: 'https://weighty-opus-340606-default-rtdb.firebaseio.com',
    storageBucket: 'weighty-opus-340606.appspot.com',
    iosBundleId: 'com.example.liveClassroom',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyCd49IGwFyD0hAaCE1V1boZ5VR9nQKLdHc',
    appId: '1:547287648953:web:9ffd49e2e6faf43fc96968',
    messagingSenderId: '547287648953',
    projectId: 'weighty-opus-340606',
    authDomain: 'weighty-opus-340606.firebaseapp.com',
    databaseURL: 'https://weighty-opus-340606-default-rtdb.firebaseio.com',
    storageBucket: 'weighty-opus-340606.appspot.com',
    measurementId: 'G-4813HPVV46',
  );
}
