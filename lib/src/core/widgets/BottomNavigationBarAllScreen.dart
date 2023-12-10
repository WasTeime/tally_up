import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:tally_up/src/features/auth/presentation/pages/ProfileScreen.dart';
import 'package:tally_up/src/features/cheque_list/presentation/pages/ChequeListInEvent.dart';
import 'package:tally_up/src/features/home/presentation/pages/HomeScreen.dart';

class BottomNavigationBarAllScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: [
        BottomNavigationBarItem(
            label: "Cheque", icon: Image.asset('assets/images/myCheque.png')),
        BottomNavigationBarItem(
            label: "Home", icon: Image.asset('assets/images/home.png')),
        BottomNavigationBarItem(
            label: "Profile", icon: Image.asset('assets/images/profile.png'))
      ],
      onTap: (int index) {
        if (index == 0) {
          context.go('/cheque');
        } else if (index == 1) {
          context.go('/');
        } else if (index == 2) {
          context.go('/profile');
        }
      },
    );
  }
}
