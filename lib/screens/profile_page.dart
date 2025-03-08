// screens/profile_page.dart
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart'; // 📌 ใช้ SharedPreferences
import 'package:petscare/screens/start_screen.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String _name = "Loading...";
  String _email = "Loading...";
  String _phone = "Loading...";

  @override
  void initState() {
    super.initState();
    _loadUserData(); // 📌 โหลดข้อมูลเมื่อหน้า Profile ถูกสร้าง
  }

  // ✅ โหลดข้อมูลผู้ใช้จาก SharedPreferences
  Future<void> _loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _name = prefs.getString('user_name') ?? "John Doe";
      _email = prefs.getString('user_email') ?? "johndoe@email.com";
      _phone = prefs.getString('user_phone') ?? "081-234-5678";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Profile'),
        centerTitle: true,
        backgroundColor: Colors.yellow,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const CircleAvatar(
              radius: 60,
              backgroundImage:
                  AssetImage('assets/images/profile.jpg'), // เปลี่ยนเป็นรูปจริง
            ),
            const SizedBox(height: 12),

            // 🔥 ข้อมูลผู้ใช้จาก SharedPreferences
            Text(
              _name,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 6),

            Text(
              _email,
              style: const TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 6),

            Text(
              'Phone: $_phone',
              style: const TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 20),

            ElevatedButton.icon(
              onPressed: () {
                // TODO: เพิ่มฟังก์ชันแก้ไขโปรไฟล์
              },
              icon: const Icon(Icons.edit, color: Colors.white),
              label: const Text('Edit Profile'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.brown,
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
              ),
            ),
            const SizedBox(height: 20),

            TextButton(
              onPressed: () {
                _logout(context);
              },
              child: const Text(
                'Logout',
                style: TextStyle(color: Colors.red, fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _logout(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear(); //  ล้างข้อมูลผู้ใช้เมื่อออกจากระบบ

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const StartScreen()),
      (Route<dynamic> route) => false,
    );
  }
}
