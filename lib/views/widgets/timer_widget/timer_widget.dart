import 'package:flutter/material.dart';
import 'package:projet_wordlink/services/timer_service.dart';
import 'package:provider/provider.dart';

class TimerWidget extends StatelessWidget {
  const TimerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<int>(
      stream: context.read<TimerService>().timeStream,
      builder: (context, snapshot) {
        final remainingSeconds = snapshot.data ?? 120;
        final minutes = remainingSeconds ~/ 60;
        final seconds = remainingSeconds % 60;

        return Container(
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Colors.grey.withOpacity(0.3),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Text(
            '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}',
            style: const TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        );
      },
    );
  }
}