import 'package:flutter/material.dart';

class ProfilePhoto extends StatelessWidget {
  final String photo;

  ProfilePhoto({required this.photo});

  @override
  Widget build(BuildContext context) {
    final image = AssetImage(photo);
    return Container(
      width: 150,
      height: 150,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: Colors.blue,
          width: 3.0,
        ),
      ),
      child: ClipOval(
        child: Material(
          color: Colors.transparent,
          child: Ink.image(
            image: image,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
