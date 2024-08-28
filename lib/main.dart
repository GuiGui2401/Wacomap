import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'login_register_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Set the status bar icon brightness to light
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(statusBarIconBrightness: Brightness.light),
  );

  // Initialize Firebase
  await Firebase.initializeApp();

  // Lock the app orientation to portrait mode
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then(
    (_) => runApp(const LoginRegisterApp()),
  );
}
