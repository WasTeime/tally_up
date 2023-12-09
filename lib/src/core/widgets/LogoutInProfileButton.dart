import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class LogoutInProfileButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      children: [
        InkWell(
          onTap: () {
            // Действие при нажатии на текст
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('Выход',
                style: theme.textTheme.headlineMedium?.copyWith(
                    color: const Color(0XFF0079FF),
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.underline)),
          ),
        ),
      ],
    );
  }
}
