import 'package:flutter/material.dart';
import 'package:tally_up/src/features/auth/presentation/widgets/TimerWidget.dart';

class ResendCodeWidget extends StatefulWidget {
  const ResendCodeWidget({super.key});

  @override
  State<ResendCodeWidget> createState() => _ResendCodeWidgetState();
}

class _ResendCodeWidgetState extends State<ResendCodeWidget> {
  bool timerIsActive = false;
  bool restart = false;

  void restartTimer() {
    setState(() {
      restart = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "Повторить попытку",
          style: TextStyle(
              fontSize: 13, color: Color(0xFF0079FF), fontFamily: 'Rubik'),
        ),
        const SizedBox(width: 10),
        TimerWidget(
          10,
          restartTimer: restart,
          timerIsActive: (value) {
            timerIsActive = value;
          },
        ),
        TextButton(
          style: ButtonStyle(
            foregroundColor:
                MaterialStateProperty.all<Color>(const Color(0xFF0079FF)),
          ),
          onPressed: () {
            if (timerIsActive) restartTimer();
          },
          child: const Text(
            "повторить",
            style: TextStyle(
                fontSize: 15,
                fontFamily: 'Rubik',
                decoration: TextDecoration.underline,
                decorationColor: Color(0xFF0079FF),
                decorationThickness: 1),
          ),
        )
      ],
    );
  }
}
