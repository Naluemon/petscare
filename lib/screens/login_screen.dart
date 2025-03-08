// screens/login_screen.dart
import 'package:flutter/material.dart';
import 'package:petscare/screens/pet_info_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              decoration: const InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              decoration: const InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
              ),
              obscureText: true, // ซ่อนข้อความ
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // ลอจิกการเข้าสู่ระบบที่นี่
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          const PetInfoScreen()), // หลังจากล็อกอินสำเร็จ ไปที่หน้า Pet Info
                );
              },
              child: const Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}
