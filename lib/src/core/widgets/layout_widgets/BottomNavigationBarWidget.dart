import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class BottomNavigationBarWidget extends StatelessWidget {
  const BottomNavigationBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: 1,
      backgroundColor: Color(0xFFF1F7FF),
      // backgroundColor: Color.fromARGB(255, 218, 235, 255),
      items: const [
        BottomNavigationBarItem(
            label: "",
            icon: Icon(
              Icons.description,
              size: 30,
            )),
        BottomNavigationBarItem(label: "", icon: Icon(Icons.home, size: 30)),
        BottomNavigationBarItem(
            label: "",
            icon: Icon(
              Icons.person,
              size: 30,
            ))
      ],
      onTap: (int index) {
        switch (index) {
          case 0:
            context.go('/cheque');
          case 1:
            context.go('/');
          case 2:
            context.go('/profile');
        }
      },
    );
  }
}
