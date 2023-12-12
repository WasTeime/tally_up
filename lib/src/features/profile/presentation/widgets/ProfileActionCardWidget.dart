import 'package:flutter/material.dart';

class ProfileActionCard extends StatelessWidget {
  final String title;
  final String value;

  ProfileActionCard({required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          // Действие при нажатии на карточку
        },
        highlightColor:
            Colors.transparent, // Делаем прозрачным выделение по контуру
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 40.0),
          padding: const EdgeInsets.all(13.0),
          decoration: BoxDecoration(
            color: const Color(0XFF0079FF), // Синий цвет фона
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(title,
                  style: theme.textTheme.headlineMedium?.copyWith(
                      color: Colors.white, fontWeight: FontWeight.bold)),
              Text(value, style: const TextStyle(color: Colors.white)),
            ],
          ),
        ),
      ),
    );
  }
}
