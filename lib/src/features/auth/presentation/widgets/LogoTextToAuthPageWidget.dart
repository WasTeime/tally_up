import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:tally_up/src/core/theme.dart';

class LogoTextToAuthPageWidget extends StatelessWidget {
  final String labelText;

  const LogoTextToAuthPageWidget(this.labelText, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'TALLY\nUP',
          textAlign: TextAlign.center,
          style: GetIt.I<AppTheme>().currentTheme.textTheme.titleLarge,
        ),
        const SizedBox(height: 15),
        Text(
          labelText,
          style: const TextStyle(
            fontFamily: 'Raleway',
            fontSize: 18,
            color: Color(0xFF0079FF),
            fontWeight: FontWeight.w900,
          ),
        ),
      ],
    );
  }
}
