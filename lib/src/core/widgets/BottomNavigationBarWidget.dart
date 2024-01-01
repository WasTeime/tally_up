import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class BottomNavigationBarWidget extends StatelessWidget {
  const BottomNavigationBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: Color.fromARGB(255, 218, 235, 255),
      items: [
        BottomNavigationBarItem(
          label: "",
          icon: Image.asset('assets/images/myCheque.png'),
        ),
        BottomNavigationBarItem(
          label: "",
          icon: Image.asset('assets/images/home.png'),
        ),
        BottomNavigationBarItem(
          label: "",
          icon: Image.asset('assets/images/profile.png'),
        )
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
