import 'dart:convert';

import 'package:flutter/material.dart';

class EnterChek extends StatelessWidget {
  final String label;
  const EnterChek({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return TextFormField(
        decoration: InputDecoration(
      fillColor: Colors.white,
      labelText: label,
      labelStyle: theme.textTheme.bodyLarge,
      contentPadding: const EdgeInsets.all(9),
    ));
  }
}
