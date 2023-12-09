import 'package:flutter/material.dart';

class NamePage extends StatelessWidget {
  final String text;
  const NamePage({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
        margin: const EdgeInsets.only(top: 45),
        width: 500,
        child: Row(
          children: [
            Container(
              child: IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.arrow_back_rounded,
                  size: 30,
                  color: Color(0xFF0079FF),
                ),
              ),
            ),
            Container(
              width: 280,
              child: Text(
                text,
                textAlign: TextAlign.center,
                style: theme.textTheme.headlineMedium
                    ?.copyWith(fontSize: 25, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              width: 15,
            ),
            Container(
              child: IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.check,
                  size: 30,
                  color: Color(0xFF0079FF),
                ),
              ),
            ),
          ],
        ));
  }
}
