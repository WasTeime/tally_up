import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tally_up/src/features/auth/presentation/bloc/sign_in/sign_in_bloc.dart';
import 'package:tally_up/src/features/auth/presentation/widgets/TimerWidget.dart';

class ResendCodeWidget extends StatefulWidget {
  const ResendCodeWidget({
    super.key,
  });

  @override
  State<ResendCodeWidget> createState() => _ResendCodeWidgetState();
}

class _ResendCodeWidgetState extends State<ResendCodeWidget> {
  bool timerIsStop = true; //?почему true, а не false
  bool restart = false;
  int secondsBeforeRestart = 30;

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
            fontSize: 13,
            color: Color(0xFF0079FF),
            fontFamily: 'Rubik',
          ),
        ),
        const SizedBox(width: 10),
        TimerWidget(
          secondsBeforeRestart,
          restartTimer: restart,
          timerIsStop: (value) {
            timerIsStop = value;
          },
        ),
        TextButton(
          style: ButtonStyle(
            foregroundColor:
                MaterialStateProperty.all<Color>(const Color(0xFF0079FF)),
          ),
          onPressed: () {
            if (timerIsStop) {
              context.read<SignInBloc>().add(SendSmsCode());
              restartTimer();
            }
          },
          //todo кнопка повторить остаётся всегда одного цвета
          child: Text(
            "повторить",
            style: TextStyle(
              fontSize: 15,
              fontFamily: 'Rubik',
              decoration: TextDecoration.underline,
              decorationColor:
                  timerIsStop ? const Color(0xFF0079FF) : Colors.amber,
              decorationThickness: 1,
            ),
          ),
        )
      ],
    );
  }
}
