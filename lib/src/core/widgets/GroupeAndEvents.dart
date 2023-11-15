import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:tally_up/src/core/theme.dart';

class GroupeAndEvents extends StatelessWidget {
  final theme = GetIt.I<AppTheme>().currentTheme;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 30, right: 30, top: 90),
      child: Row(
        children: [
          TextButton(
            style: TextButton.styleFrom(
              textStyle: const TextStyle(fontSize: 20),
            ),
            onPressed: () {
              // Обработка нажатия для "Группы"
            },
            child: Text('Группы', style: theme.textTheme.headlineMedium),
          ),
          TextButton(
            style: TextButton.styleFrom(
              textStyle: const TextStyle(fontSize: 20),
            ),
            onPressed: () {
              // Обработка нажатия для "Мероприятия"
            },
            child: Text('Мероприятия', style: theme.textTheme.headlineMedium),
          ),
        ],
      ),
    );
  }
}
