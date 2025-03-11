// screens/profile_page.dart
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
    _loadUserData();
  }

  //  โหลดข้อมูลผู้ใช้จาก SharedPreferences
  Future<void> _loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _name = prefs.getString('user_name') ?? "John Doe";
      _email = prefs.getString('user_email') ?? "johndoe@email.com";
      _phone = prefs.getString('user_phone') ?? "081-234-5678";
    });
  }

  //  ฟังก์ชันแก้ไขข้อมูลโปรไฟล์
  Future<void> _editProfileDialog() async {
    TextEditingController nameController = TextEditingController(text: _name);
    TextEditingController emailController = TextEditingController(text: _email);
    TextEditingController phoneController = TextEditingController(text: _phone);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Edit Profile"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: "Full Name"),
            ),
            TextField(
              controller: emailController,
              decoration: const InputDecoration(labelText: "Email"),
            ),
            TextField(
              controller: phoneController,
              decoration: const InputDecoration(labelText: "Phone Number"),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () async {
              final prefs = await SharedPreferences.getInstance();
              await prefs.setString('user_name', nameController.text.trim());
              await prefs.setString('user_email', emailController.text.trim());
              await prefs.setString('user_phone', phoneController.text.trim());

              setState(() {
                _name = nameController.text.trim();
                _email = emailController.text.trim();
                _phone = phoneController.text.trim();
              });

              Navigator.pop(context); // ปิด Dialog
            },
            child: const Text("Save"),
          ),
        ],
      ),
    );
  }

  //  ฟังก์ชันออกจากระบบ
  Future<void> _logout(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear(); // ล้างข้อมูล

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const StartScreen()),
      (Route<dynamic> route) => false,
    );
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

            //  ข้อมูลผู้ใช้จาก SharedPreferences
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

            //  ปุ่มแก้ไขข้อมูล
            ElevatedButton.icon(
              onPressed: _editProfileDialog,
              icon: const Icon(Icons.edit, color: Colors.white),
              label: const Text('Edit Profile'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.brown,
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
              ),
            ),
            const SizedBox(height: 20),

            //  ปุ่ม Logout
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
}
