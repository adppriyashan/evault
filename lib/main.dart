import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:identifyapp/Views/Common/SplashScreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'PGFHH',
      home: Scaffold(
        body: SplashScreen(),
      ),
    );
  }
}