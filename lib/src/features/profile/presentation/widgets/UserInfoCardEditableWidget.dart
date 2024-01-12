import 'package:flutter/material.dart';

class UserInfoCardEditable extends StatelessWidget {
  final String? title;
  final String? value;

  const UserInfoCardEditable({
    super.key,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final controller = TextEditingController(text: value);

    return TextFormField(
      controller: controller,
      style: theme.textTheme.headlineMedium,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(color: Color(0XFF0079FF)),
        ),
        labelText: '$title',
        labelStyle: const TextStyle(color: Color(0XFF0079FF)),
        border: InputBorder.none,
        filled: true,
        fillColor: Colors.white,
      ),
    );
  }
}
