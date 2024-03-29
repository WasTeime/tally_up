import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class BottomNavigationBarWidget extends StatelessWidget {
  const BottomNavigationBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    const double iconSize = 32;

    return BottomNavigationBar(
      selectedItemColor: const Color(0xff0079FF),
      currentIndex: 1,
      backgroundColor: const Color(0xFFF1F7FF),
      // backgroundColor: Color.fromARGB(255, 218, 235, 255),
      items: const [
        BottomNavigationBarItem(
          label: "",
          icon: Icon(Icons.description, size: iconSize),
        ),
        BottomNavigationBarItem(
          label: "",
          icon: Icon(Icons.home, size: iconSize),
        ),
        BottomNavigationBarItem(
          label: "",
          icon: Icon(Icons.person, size: iconSize),
        ),
      ],
      onTap: (int index) {
        switch (index) {
          case 0:
            context.go('/');
          case 1:
            context.go('/');
          case 2:
            context.go('/profile');
        }
      },
    );
  }
}
