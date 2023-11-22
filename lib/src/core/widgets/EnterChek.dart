import 'dart:convert';

import 'package:flutter/material.dart';

class EnterChek extends StatelessWidget {
  final String label;
  final String hint;
  const EnterChek({super.key, required this.label, required this.hint});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: EdgeInsets.all(1),
      child: Column(children: [
        Row(
          children: [
            Text(
              label,
              style: theme.textTheme.bodyLarge,
            ),
            Expanded(
              child: Container(
                  width: 150,
                  child: TextFormField(
                    textAlign: TextAlign.right,
                    decoration: InputDecoration(
                      hintText: hint,
                      hintStyle: theme.textTheme.bodySmall,
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.transparent),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.transparent,
                        ),
                      ),
                    ),
                  )),
            )
          ],
        ),
      ]),
    );
  }
}
