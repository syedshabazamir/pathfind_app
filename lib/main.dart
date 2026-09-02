import 'package:careerguidance_app/Screens/LoginScreen.dart';
import 'package:careerguidance_app/Screens/WrapperScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: "AIzaSyBaSXqVs358BG4yZtuVVXRGhsINFu4UkBQ",
      appId: "1:1072089637932:android:b46044cc03bc023a245d89",
      messagingSenderId: "1072089637932",
      projectId: "pathfind-98def",
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: Wrapper(), debugShowCheckedModeBanner: false);
  }
}
