// main.dart
import 'package:flutter/material.dart';
import 'screens/start_screen.dart'; // import หน้า StartScreen

void main() {
  runApp(const PetsCareApp());
}

class PetsCareApp extends StatelessWidget {
  const PetsCareApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'PetsCare',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: const StartScreen(), // เริ่มต้นที่หน้า StartScreen
    );
  }
}
