import 'package:flutter/material.dart';

class UserInfoCardEditable extends StatefulWidget {
  final String title;
  final String initialValue;

  const UserInfoCardEditable({
    Key? key,
    required this.title,
    required this.initialValue,
  }) : super(key: key);

  @override
  _UserInfoCardEditableState createState() => _UserInfoCardEditableState();
}

class _UserInfoCardEditableState extends State<UserInfoCardEditable> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialValue);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context); // Получаем тему из контекста
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 42.0),
      padding: const EdgeInsets.all(10.0),
      height: 50,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Center(
        // Выравниваем текст по центру
        child: TextFormField(
          textAlign: TextAlign.left,
          style: theme
              .textTheme.headlineMedium, // Используем стиль из текущей темы
          decoration: InputDecoration(
            hintText: 'Enter your ${widget.title}',
            border: InputBorder.none,
          ),
          controller: _controller,
          onChanged: (value) {
            // Handle user input changes
          },
        ),
      ),
    );
  }
}
