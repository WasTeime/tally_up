import 'package:flutter/material.dart';
import 'package:tally_up/src/features/profile/presentation/widgets/view.dart';

class ProfilePhotoEditWidget extends StatelessWidget {
  const ProfilePhotoEditWidget({super.key});

  @override
  Widget build(BuildContext context) {
    const double buttonSize = 25;

    return Stack(
      children: [
        const ProfilePhotoWidget(),
        Positioned(
          bottom: 0,
          right: 5,
          child: CircleAvatar(
            radius: buttonSize + 3,
            backgroundColor: Colors.white,
            child: CircleAvatar(
              radius: buttonSize,
              backgroundColor: const Color(0XFF0079FF).withOpacity(0.75),
              child: IconButton(
                icon: const Icon(
                  Icons.edit,
                  color: Colors.white,
                  size: 21,
                ),
                onPressed: () {},
              ),
            ),
          ),
        ),
      ],
    );
  }
}
