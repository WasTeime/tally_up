import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:tally_up/src/core/theme.dart';

class ButtonAdd extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 650),
      child: Center(
          child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          shape: const CircleBorder(),
          padding: const EdgeInsets.all(8),
          backgroundColor: const Color(0xFF0079FF), // <-- Button color
          foregroundColor: Colors.blue, // <-- Splash color
        ),
        child: const Icon(
          Icons.add_rounded,
          color: Colors.white,
          size: 60,
        ),
      )),
    );
  }
}
