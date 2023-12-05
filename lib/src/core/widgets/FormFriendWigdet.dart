import 'package:flutter/material.dart';

class FormFriendWidget extends StatelessWidget {
  final String text;
  const FormFriendWidget({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: Container(
        width: 350,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              blurRadius: 20,
              offset: Offset(4, 8),
            ),
          ],
        ),
        child: TextField(
          decoration: InputDecoration(
            fillColor: Colors.white,
            contentPadding: const EdgeInsets.all(15),
            border: InputBorder.none,
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: const BorderSide(
                color: Colors.blue,
                width: 3,
              ),
            ),
            hintText: text,
            hintStyle: const TextStyle(color: Color(0xFFD3E8FF)),
          ),
        ),
      ),
    );
  }
}
