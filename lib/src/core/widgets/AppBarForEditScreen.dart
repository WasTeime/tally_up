import 'package:flutter/material.dart';

class AppBarForEditScreen extends StatelessWidget
    implements PreferredSizeWidget {
  final Color color;
  final String name;

  const AppBarForEditScreen({required this.color, required this.name});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AppBar(
      backgroundColor: Color(0xFFF1F7FF),
      title: Center(
        child: Text(
          name,
          style: theme.textTheme.headlineMedium
              ?.copyWith(fontSize: 23, fontWeight: FontWeight.bold),
        ),
      ),
      leading: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: const Icon(
          Icons.arrow_back_rounded,
          size: 30,
          color: Color(0xFF0079FF),
        ),
      ),
      actions: [
        IconButton(
          onPressed: () {
            Navigator.pop(context, true);
          },
          icon: const Icon(
            Icons.check,
            size: 30,
            color: Color(0xFF0079FF),
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(
      kToolbarHeight); // Implementing the preferredSize property
}
