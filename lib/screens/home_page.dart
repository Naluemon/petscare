// screens/home_page.dart
import 'package:flutter/material.dart';
import 'package:petscare/widgets/bottom_nav_bar.dart'; // Import BottomNavBar

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0; // Track the current tab index

  // Define the pages for each tab
  final List<Widget> _pages = [
    const Center(child: Text("Home Page")), // Home Tab
    const Center(child: Text("Book Service Page")), // Book Service Tab
    const Center(child: Text("Health Log Page")), // Health Log Tab
    const Center(child: Text("Knowledge Page")), // Knowledge Tab
    const Center(child: Text("Profile Page")), // Profile Tab
  ];

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index; // Update current index
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: _pages[_currentIndex], // Display the selected page
      bottomNavigationBar: BottomNavBar(
        currentIndex: _currentIndex, // Pass the current index to BottomNavBar
        onTabTapped: _onTabTapped, // Pass the onTap function
      ),
    );
  }
}
