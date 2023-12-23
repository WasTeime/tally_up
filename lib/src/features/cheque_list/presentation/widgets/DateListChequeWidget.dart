import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateListChequeWidget extends StatelessWidget {
  final String date;
  const DateListChequeWidget({super.key, required this.date});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      margin: EdgeInsets.only(top: 20),
      child: Column(
        children: [
          Center(
            child: Text(
              date,
              style: theme.textTheme.headlineSmall?.copyWith(
                fontSize: 24, // Размер шрифта
                fontWeight: FontWeight.bold, // Жирный шрифт
                color: Color(0xFF0079FF),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
