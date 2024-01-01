import 'package:flutter/material.dart';

class PhotoProfile extends StatelessWidget {
  const PhotoProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: Container(
        margin: EdgeInsets.only(top: 130),
        width: 150.0,
        height: 150.0,
        decoration: BoxDecoration(
          color: Color(0xffCBE3FF),
          shape: BoxShape.circle,
          border: Border.all(
            color: Colors.blue,
            width: 2.0,
          ),
        ),
        child: Container(
            width: 50,
            height: 50,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/profile.png'),
                fit: BoxFit.scaleDown,
              ),
              shape: BoxShape.circle,
            )),
      ),
    );
  }
}
