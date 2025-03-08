// screens/start_screen.dart
import 'package:flutter/material.dart';
import 'login_screen.dart'; // import หน้า LoginScreen

class StartScreen extends StatelessWidget {
  const StartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          const Color.fromARGB(255, 255, 211, 68), // สีพื้นหลังของหน้าเริ่มต้น
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/logo.png',
              width: 350, // ขนาดความกว้างของภาพ
              height: 450, // ขนาดความสูงของภาพ
            ),
            const SizedBox(height: 20), // ระยะห่างระหว่างภาพและข้อความ
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text(
                  'Pets',
                  style: TextStyle(
                    fontSize: 40,
                    color: Color.fromARGB(255, 119, 64, 0),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(width: 10), // ระยะห่างระหว่างคำ
                Text(
                  'Care',
                  style: TextStyle(
                    fontSize: 40,
                    color: Color.fromARGB(255, 119, 64, 0),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20), // ระยะห่างระหว่างข้อความและปุ่ม
            ElevatedButton(
              onPressed: () {
                // เมื่อกดปุ่มจะพาไปที่หน้า Login
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    const Color.fromARGB(255, 255, 255, 255), // สีปุ่ม
                padding:
                    const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                textStyle: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              child: const Text('Start'),
            ),
          ],
        ),
      ),
    );
  }
}
