// widgets/bottom_nav_bar.dart
import 'package:flutter/material.dart';

class BottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTabTapped;

  const BottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTabTapped,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: onTabTapped,
      selectedItemColor:
          const Color.fromARGB(255, 70, 38, 0), // สีของไอคอนที่เลือก
      unselectedItemColor: Colors.white, // สีของไอคอนที่ไม่ได้เลือก
      backgroundColor:
          const Color.fromARGB(255, 191, 124, 0), // สีที่ไม่โปร่งแสง
      elevation: 10,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.calendar_today),
          label: 'Book Service',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.pets),
          label: 'Health Log',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.lightbulb),
          label: 'Knowledge',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Profile',
        ),
      ],
    );
  }
}
