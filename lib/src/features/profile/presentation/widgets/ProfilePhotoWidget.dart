import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProfilePhotoWidget extends StatelessWidget {
  const ProfilePhotoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 75,
      child: SvgPicture.asset(
        'assets/images/avatar.svg',
        width: 150,
      ),
    );
  }
}
