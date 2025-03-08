// screens/main_screen.dart
import 'package:flutter/material.dart';
import 'package:petscare/screens/bookservice_page.dart';
import 'package:petscare/screens/healthlog_screen.dart';
import 'package:petscare/screens/home_screen.dart';
import 'package:petscare/screens/knowledge_screen.dart';
import 'package:petscare/screens/profile_page.dart';
import 'package:petscare/widgets/bottom_nav_bar.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0; // ✅ เก็บ state ของแท็บที่เลือก

  final List<Widget> _screens = [
    const HomeScreen(),
    const BookservicePage(),
    const HealthlogScreen(),
    const KnowledgeScreen(),
    const ProfilePage(),
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
