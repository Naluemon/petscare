// main.dart
import 'package:flutter/material.dart';
import 'package:petscare/screens/bookservice_page.dart';
import 'package:petscare/screens/healthlog_screen.dart';
import 'package:petscare/screens/home_screen.dart';
import 'package:petscare/screens/knowledge_screen.dart';
import 'package:petscare/screens/login_screen.dart';
import 'package:petscare/screens/profile_page.dart';
import 'package:petscare/screens/start_screen.dart';
import 'package:petscare/widgets/bottom_nav_bar.dart';

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
        primaryColor: Colors.brown,
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.yellow,
          foregroundColor: Colors.black,
          elevation: 2,
        ),
      ),
      home: const MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const HomeScreen(),
    const BookservicePage(),
    const HealthlogScreen(),
    const KnowledgeScreen(),
    const ProfilePage(), // ✅ ตรวจสอบว่า `ProfilePage` มี `const`
  ];

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),
      bottomNavigationBar: BottomNavBar(
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
      ),
    );
  }
}
