import 'package:flutter/material.dart';

class UserInfoCard extends StatelessWidget {
  final String? username;
  final String phoneNumber;
  final String? email;

  const UserInfoCard({
    super.key,
    this.username,
    required this.phoneNumber,
    this.email,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 15),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
      ),
      child: Column(
        children: [
          Text(
            username != null ? username! : "Без имени",
            style: theme.textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            phoneNumber,
            style: theme.textTheme.headlineMedium?.copyWith(
              color: const Color(0XFF0079FF),
              fontSize: 15,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            email != null ? email! : "Нет почты",
            style: theme.textTheme.headlineMedium?.copyWith(
              color: const Color(0XFF0079FF),
              fontSize: 15,
            ),
          ),
        ],
      ),
    );
  }
}
