// screens/profile_page.dart
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:petscare/screens/start_screen.dart';
import 'package:image_picker/image_picker.dart'; // ต้องเพิ่ม dependency นี้

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String _name = "Loading...";
  String _email = "Loading...";
  String _password = "••••••••";
  String? _imageBase64; // เพิ่มตัวแปรเก็บรูปภาพในรูปแบบ Base64
  final ImagePicker _picker = ImagePicker(); // ตัวแปรสำหรับเลือกรูปภาพ

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  // โหลดข้อมูลผู้ใช้จาก SharedPreferences
  Future<void> _loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _name = prefs.getString('user_name') ?? "PetOwner";
      _email = prefs.getString('user_email') ?? "t@gmail.com";
      _imageBase64 = prefs.getString('user_image');
    });
  }

  // ฟังก์ชันเลือกรูปภาพจากแกลเลอรี่หรือกล้อง
  Future<void> _pickImage(ImageSource source) async {
    try {
      final XFile? pickedFile = await _picker.pickImage(
        source: source,
        maxWidth: 800, // ลดขนาดรูปภาพเพื่อประหยัดพื้นที่
        maxHeight: 800,
        imageQuality: 85, // คุณภาพของรูปภาพ 0-100
      );

      if (pickedFile != null) {
        // แปลงรูปภาพเป็น Base64 เพื่อเก็บใน SharedPreferences
        final bytes = await File(pickedFile.path).readAsBytes();
        final base64Image = base64Encode(bytes);

        // บันทึกลงใน SharedPreferences
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('user_image', base64Image);

        setState(() {
          _imageBase64 = base64Image;
        });
      }
    } catch (e) {
      // แสดงข้อความเมื่อเกิดข้อผิดพลาด
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('เกิดข้อผิดพลาด: $e')),
      );
    }
  }

  // แสดงตัวเลือกแหล่งที่มาของรูปภาพ (กล้องหรือแกลเลอรี่)
  void _showImageSourceOptions() {
    showModalBottomSheet(
      context: context,
      builder: (context) => SafeArea(
        child: Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.photo_camera),
              title: const Text('ถ่ายรูปใหม่'),
              onTap: () {
                Navigator.of(context).pop();
                _pickImage(ImageSource.camera);
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text('เลือกรูปจากแกลเลอรี่'),
              onTap: () {
                Navigator.of(context).pop();
                _pickImage(ImageSource.gallery);
              },
            ),
          ],
        ),
      ),
    );
  }

  // ฟังก์ชันแก้ไขข้อมูลโปรไฟล์
  Future<void> _editProfileDialog() async {
    TextEditingController nameController = TextEditingController(text: _name);
    TextEditingController emailController = TextEditingController(text: _email);
    TextEditingController passwordController = TextEditingController(text: "");

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
              controller: passwordController,
              decoration: const InputDecoration(labelText: "Password"),
              obscureText: true,
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
              if (passwordController.text.trim().isNotEmpty) {
                await prefs.setString(
                    'user_password', passwordController.text.trim());
              }

              setState(() {
                _name = nameController.text.trim();
                _email = emailController.text.trim();
              });

              Navigator.pop(context); // ปิด Dialog
            },
            child: const Text("Save"),
          ),
        ],
      ),
    );
  }

  // ฟังก์ชันออกจากระบบ
  Future<void> _logout(BuildContext context) async {
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
        title: const Text('Profile',
            style: TextStyle(color: Colors.brown, fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              color: Colors.white,
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  // Profile image with upload option
                  Stack(
                    children: [
                      // รูปโปรไฟล์
                      Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(8),
                          image: _imageBase64 != null
                              ? DecorationImage(
                                  image: MemoryImage(
                                    base64Decode(_imageBase64!),
                                  ),
                                  fit: BoxFit.cover,
                                )
                              : null,
                        ),
                        child: _imageBase64 == null
                            ? const Center(
                                child: Icon(
                                  Icons.person,
                                  size: 50,
                                  color: Colors.grey,
                                ),
                              )
                            : null,
                      ),
                      // ปุ่มอัพโหลดรูป
                      Positioned(
                        right: 0,
                        bottom: 0,
                        child: GestureDetector(
                          onTap: _showImageSourceOptions,
                          child: Container(
                            padding: const EdgeInsets.all(4),
                            decoration: const BoxDecoration(
                              color: Colors.yellow,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.camera_alt,
                              color: Colors.brown,
                              size: 20,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // Name field
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Name', style: TextStyle(fontSize: 14)),
                      const SizedBox(height: 4),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 12),
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(_name),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Email field
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Email', style: TextStyle(fontSize: 14)),
                      const SizedBox(height: 4),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 12),
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(_email),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Password field
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Password', style: TextStyle(fontSize: 14)),
                      const SizedBox(height: 4),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 12),
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(_password),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // Edit Profile button
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: _editProfileDialog,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.yellow,
                        foregroundColor: Colors.brown,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text('Edit Profile',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Log out button
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () => _logout(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text('Log out',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
