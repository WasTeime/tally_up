import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tally_up/src/features/auth/data/repository/authController.dart';

class LogoutInProfileButtonWidget extends StatelessWidget {
  final String name;
  const LogoutInProfileButtonWidget({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    final _authController = AuthController();
    final theme = Theme.of(context);
    return Column(
      children: [
        InkWell(
          onTap: () {
            _authController.logOut();
            context.go('/login');
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(name,
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
