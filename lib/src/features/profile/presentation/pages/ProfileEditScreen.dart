import 'package:flutter/material.dart';

import 'package:flutter/material.dart';

import '../../../../core/layouts/mainLayout.dart';
import '../../../../core/widgets/view.dart';
import '../widgets/view.dart';
import 'ProfileScreen.dart';

class EditProfilePage extends StatelessWidget {
  final String userName;
  final String phoneNumber;
  final String email;

  const EditProfilePage({
    Key? key,
    required this.userName,
    required this.phoneNumber,
    required this.email,
  }) : super(key: key);

  Widget PhotoAndBox(color) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Align(
          alignment: Alignment.topCenter,
          child: Stack(
            children: [
              ProfilePhoto(photo: 'assets/images/events1.png'),
              Positioned(
                bottom: 0,
                right: 4,
                child: EditIconOnPhoto(color: color),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 40,
        ),
        UserInfoCardEditable(title: 'Name', initialValue: userName),
        UserInfoCardEditable(title: 'Phone', initialValue: phoneNumber),
        UserInfoCardEditable(title: 'Email', initialValue: email),
      ],
    );
  }

  Widget build(BuildContext context) {
    final color = Color(0xFFF1F7FF);
    return MainLayout(
      appBarWidget: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: AppBarForEditScreen(color: color, name: 'Редактировать'),
      ),
      contentWidget: PhotoAndBox(color),
    );
  }
}
