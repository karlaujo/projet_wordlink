import 'dart:async';

import 'package:flutter/material.dart';
import 'package:projet_wordlink/services/timer_service.dart';

class TimerWidget extends StatefulWidget {
  final TimerService timerService;
  final TextStyle style;

  const TimerWidget({
    Key? key,
    required this.timerService,
    required this.style,
  }) : super(key: key);

  @override
  _TimerWidgetState createState() => _TimerWidgetState();
}

class _TimerWidgetState extends State<TimerWidget> {
  late StreamSubscription<int> _subscription;

  @override
  void initState() {
    super.initState();
    _subscription = widget.timerService.timeStream.listen((remainingSeconds) {
      setState(() {});
    });
    widget.timerService.start();
  }

  @override
  void dispose() {
    _subscription.cancel();
    widget.timerService.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final remainingSeconds = widget.timerService.remainingSeconds;
    final minutes = (remainingSeconds / 60).floor();
    final seconds = remainingSeconds % 60;
    return Text(
      '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}',
      style: widget.style,
    );
  }
}