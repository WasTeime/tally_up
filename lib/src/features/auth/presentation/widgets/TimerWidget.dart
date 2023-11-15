import 'dart:async';

import 'package:flutter/material.dart';

class TimerWidget extends StatefulWidget {
  ValueChanged<bool> timerIsStop;
  bool restartTimer;
  int seconds;

  TimerWidget(this.seconds,
      {required this.timerIsStop, this.restartTimer = false, super.key});

  @override
  State<TimerWidget> createState() => _TimerWidgetState();
}

class _TimerWidgetState extends State<TimerWidget> {
  late Timer _timer;
  late int _time;

  @override
  void initState() {
    _time = widget.seconds;
    widget.timerIsStop(true);
    startTimer();
    super.initState();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant TimerWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.restartTimer) {
      _timer.cancel();
      _time = widget.seconds;
      startTimer();
    }
  }

  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_time > 0) {
        setState(() {
          _time--;
          widget.timerIsStop(false);
        });
      } else {
        setState(() {
          widget.timerIsStop(true);
          _timer.cancel();
        });
      }
    });
  }

  get getTextStyle => _time > 0
      ? TextStyle(color: const Color(0xFF0079FF).withOpacity(0.6))
      : const TextStyle(color: Color.fromARGB(255, 0, 0, 0));

  String formatTime() {
    int minutes = _time ~/ 60;
    int seconds = _time % 60;
    return "${minutes.toString().padLeft(2, '0')} : ${seconds < 10 ? seconds.toString().padLeft(2, '0') : seconds.toString()}";
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      formatTime(),
      style: getTextStyle,
    );
  }
}
