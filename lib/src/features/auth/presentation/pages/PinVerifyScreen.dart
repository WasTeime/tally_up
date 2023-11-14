import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';

class PinVerifyScreen extends StatefulWidget {
  const PinVerifyScreen({super.key});

  @override
  State<PinVerifyScreen> createState() => _PinVerifyScreenState();
}

class _PinVerifyScreenState extends State<PinVerifyScreen> {
  @override
  Widget build(BuildContext context) {
    Widget _logo() {
      return Padding(
        padding: const EdgeInsets.only(top: 250),
        child: Container(
          child: const Align(
              child: Text(
            'Tally\nUp',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 45,
              fontWeight: FontWeight.bold,
              color: Color(0xFF0079FF),
              fontFamily: 'RubikMonoOne',
              height: 1,
            ),
          )),
        ),
      );
    }

    Widget _text() {
      return Padding(
        padding: const EdgeInsets.only(top: 34),
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 20),
          child: const Align(
              child: Text(
            'Введите код',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
              color: Color(0xFF0079FF),
              fontFamily: 'Raleway',
              height: 1,
            ),
          )),
        ),
      );
    }

    Widget _buildPinPut() {
      return Container(
        margin: EdgeInsets.symmetric(horizontal: 45),
        child: Pinput(
          length: 6,
          onCompleted: (pin) => print(pin),
        ),
      );
    }

    Widget _button() {
      return Container(
        margin: EdgeInsets.only(top: 40),
        child: ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFF0079FF),
              foregroundColor: Colors.white,
              // elevation: 7,
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 35),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(17),
              )),
          child: Text(
            'Отправить',
            style: TextStyle(
              fontSize: 17,
            ),
          ),
        ),
      );
    }

    int minutes = 1;
    int seconds = 0;
    Widget _repeat() {
      int totalMilliseconds = (minutes * 60 + seconds) * 1000;
      int endTime = DateTime.now().millisecondsSinceEpoch + totalMilliseconds;
      // DateTime timer = DateFormat('mm:ss').format(DateTime.now());
      return Container(
        margin: EdgeInsets.only(top: 5, left: 50),
        child: Row(
          children: [
            Container(
              child: Text(
                "Повторить попытку   ",
                style: TextStyle(
                    fontSize: 13,
                    color: Color(0xFF0079FF).withOpacity(0.8),
                    fontFamily: 'Rubik'),
              ),
            ),
            Container(
                child: CountdownTimer(
              endTime: endTime,
              onEnd: () {},
              textStyle: TextStyle(
                  fontSize: 13,
                  color: Color(0xFF0079FF).withOpacity(0.8),
                  fontFamily: 'Rubik'),
            )),
            Container(
              child: TextButton(
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
              ),
            )
          ],
        ),
      );
    }

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("lib/src/core/images/krug.png"),
            alignment: Alignment(0.0, -0.1),
          ),
        ),
        child: Column(
          children: <Widget>[
            _logo(),
            _text(),
            _buildPinPut(),
            _button(),
            _repeat(),
          ],
        ),
      ),
    );
  }
}
