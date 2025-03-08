// screens/healthlog_screen.dart
import 'package:flutter/material.dart';

class HealthlogScreen extends StatelessWidget {
  const HealthlogScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Text('helathlog', style: TextStyle(fontSize: 24)),
      ),
    );
  }
}
