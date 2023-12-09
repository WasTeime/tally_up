import 'package:flutter/material.dart';

class UserInfoCard extends StatelessWidget {
  final String userName;
  final String phoneNumber;
  final String email;

  UserInfoCard(
      {required this.userName, required this.phoneNumber, required this.email});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 42.0),
      padding: const EdgeInsets.all(13.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            userName,
            style: theme.textTheme.headlineMedium
                ?.copyWith(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          const SizedBox(height: 4.0),
          Text(phoneNumber,
              style: theme.textTheme.headlineMedium?.copyWith(
                  color: const Color(0XFF0079FF),
                  fontSize: 15,
                  decoration: TextDecoration.underline)),
          const SizedBox(height: 4.0),
          Text(email,
              style: theme.textTheme.headlineMedium?.copyWith(
                color: const Color(0XFF0079FF),
                fontSize: 15,
              )),
        ],
      ),
    );
  }
}
