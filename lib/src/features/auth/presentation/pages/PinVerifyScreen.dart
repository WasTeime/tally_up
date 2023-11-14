import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:tally_up/src/core/widgets/ColumnGapWidget.dart';
import 'package:tally_up/src/core/widgets/TextButtonWidget.dart';
import 'package:tally_up/src/features/auth/presentation/widgets/BackgroundCircleWidget.dart';
import 'package:tally_up/src/features/auth/presentation/widgets/LogoTextToAuthPageWidget.dart';

class PinVerifyScreen extends StatefulWidget {
  const PinVerifyScreen({super.key});

  @override
  State<PinVerifyScreen> createState() => _PinVerifyScreenState();
}

class PinPut extends StatelessWidget {
  const PinPut({super.key});

  Widget repeat() {
    final int minutes = 0;
    final int seconds = 30;
    int totalMilliseconds = (minutes * 60 + seconds) * 1000;
    int endTime = DateTime.now().millisecondsSinceEpoch + totalMilliseconds;
    // DateTime timer = DateFormat('mm:ss').format(DateTime.now());
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Повторить попытку",
          style: TextStyle(
              fontSize: 13,
              color: Color(0xFF0079FF).withOpacity(0.8),
              fontFamily: 'Rubik'),
        ),
        CountdownTimer(
          endTime: endTime,
          onEnd: () {},
          textStyle: TextStyle(
              fontSize: 13,
              color: Color(0xFF0079FF).withOpacity(0.8),
              fontFamily: 'Rubik'),
          endWidget: Text('Все'),
        ),
        TextButton(
          style: ButtonStyle(
            foregroundColor:
                MaterialStateProperty.all<Color>(Color(0xFF0079FF)),
          ),
          onPressed: () {},
          child: const Text(
            'повторить',
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

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: Pinput(
        length: 6,
        onCompleted: (pin) => print(pin),
      ),
    );
  }
}

class _PinVerifyScreenState extends State<PinVerifyScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        const BackgroundCircleWidget(),
        Padding(
          padding: const EdgeInsets.only(top: 300, left: 20, right: 20),
          child: Column(
            children: <Widget>[
              const LogoTextToAuthPageWidget('Введите код'),
              const ColumnGapWidget(),
              const PinPut(),
              const ColumnGapWidget(),
              TextButtonWidget(() => {}, "Отправить"),
              const PinPut().repeat(),
            ],
          ),
        )
      ]),
    );
  }
}
