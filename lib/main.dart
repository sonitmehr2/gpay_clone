import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:gpay_clone/screens/home_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MainApp());
}

// ignore_for_file: prefer_const_constructors
class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: HomeScreen());
  }
}
