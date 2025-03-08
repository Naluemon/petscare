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
              'assets/images/your_image.png', // ระบุที่อยู่ของไฟล์ภาพในโฟลเดอร์ assets
              width: 100, // ขนาดความกว้างของภาพ
              height: 100, // ขนาดความสูงของภาพ
            ),
            const SizedBox(height: 20),
            const Text(
              'PetsCare',
              style: TextStyle(
                fontSize: 30,
                color: Color.fromARGB(255, 119, 64, 0),
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 30),
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
                  fontSize: 18,
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
