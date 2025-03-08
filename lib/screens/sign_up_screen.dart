// screens/sign_up_screen.dart
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart'; // ⭐ เพิ่ม SharedPreferences
import 'login_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  Future<void> _register() async {
    String name = _nameController.text.trim();
    String email = _emailController.text.trim();
    String password = _passwordController.text.trim();
    String confirmPassword = _confirmPasswordController.text.trim();

    if (name.isEmpty ||
        email.isEmpty ||
        password.isEmpty ||
        confirmPassword.isEmpty) {
      _showErrorDialog("กรุณากรอกข้อมูลให้ครบทุกช่อง");
      return;
    }

    if (password != confirmPassword) {
      _showErrorDialog("รหัสผ่านไม่ตรงกัน");
      return;
    }

    // ⭐ บันทึกข้อมูลลง SharedPreferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('name', name);
    await prefs.setString('email', email);
    await prefs.setString('password',
        password); // **เก็บรหัสผ่านแบบง่ายๆ (ไม่แนะนำสำหรับแอปจริง)**

    // สมัครเสร็จแล้วไปที่หน้า Login
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginScreen()),
    );
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Error"),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("OK"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 40),
              Text(
                'Register',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.brown[700],
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'Create a New Account',
                style: TextStyle(
                  color: Colors.brown[700],
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),

              // ช่องกรอกชื่อ
              _buildTextField(controller: _nameController, hint: "Full Name"),
              const SizedBox(height: 10),

              // ช่องกรอกอีเมล
              _buildTextField(controller: _emailController, hint: "Email"),
              const SizedBox(height: 10),

              // ช่องกรอกรหัสผ่าน
              _buildTextField(
                  controller: _passwordController,
                  hint: "Password",
                  isPassword: true),
              const SizedBox(height: 10),

              // ช่องยืนยันรหัสผ่าน
              _buildTextField(
                  controller: _confirmPasswordController,
                  hint: "Confirm Password",
                  isPassword: true),
              const SizedBox(height: 20),

              // ปุ่มลงทะเบียน
              ElevatedButton(
                onPressed: _register,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.yellow,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'Register',
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
      {required TextEditingController controller,
      required String hint,
      bool isPassword = false}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(4),
      ),
      child: TextField(
        controller: controller,
        obscureText: isPassword,
        decoration: InputDecoration(
          hintText: hint,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
