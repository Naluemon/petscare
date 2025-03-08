// screens/home_screen.dart
import 'package:flutter/material.dart';
import 'package:petscare/screens/healthlog_screen.dart';
import 'package:petscare/screens/knowledge_screen.dart';
import 'package:petscare/screens/proflie_page.dart';
import 'package:petscare/widgets/bottom_nav_bar.dart';
import 'package:petscare/screens/home_page.dart';
import 'package:petscare/screens/bookservice_page.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  // รายการหน้าที่จะใช้กับ Bottom Navigation
  final List<Widget> _pages = [
    const HomePage(),
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
        children: _pages,
      ),
      bottomNavigationBar: BottomNavBar(
        currentIndex: _currentIndex,
        onTabTapped: _onTabTapped,
      ),
    );
  }
}
