// widgets/bottom_nav_bar.dart
import 'package:flutter/material.dart';

class BottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const BottomNavBar({
    Key? key,
    required this.currentIndex,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      color: Colors.yellow,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          IconButton(
            icon: Icon(
              Icons.home,
              color: currentIndex == 0
                  ? Colors.brown
                  : Colors.brown.withOpacity(0.5),
            ),
            onPressed: () => onTap(0),
          ),
          IconButton(
            icon: Icon(
              Icons.article,
              color: currentIndex == 1
                  ? Colors.brown
                  : Colors.brown.withOpacity(0.5),
            ),
            onPressed: () => onTap(1),
          ),
          IconButton(
            icon: Icon(
              Icons.pets,
              color: currentIndex == 2
                  ? Colors.brown
                  : Colors.brown.withOpacity(0.5),
            ),
            onPressed: () => onTap(2),
          ),
          IconButton(
            icon: Icon(
              Icons.lightbulb,
              color: currentIndex == 3
                  ? Colors.brown
                  : Colors.brown.withOpacity(0.5),
            ),
            onPressed: () => onTap(3),
          ),
          IconButton(
            icon: Icon(
              Icons.person,
              color: currentIndex == 4
                  ? Colors.brown
                  : Colors.brown.withOpacity(0.5),
            ),
            onPressed: () => onTap(4),
          ),
        ],
      ),
    );
  }
}
