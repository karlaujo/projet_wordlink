// import 'package:flutter/material.dart';
// import 'package:projet_wordlink/views/widgets/timer_widget/timer_widget.dart';
// import 'package:provider/provider.dart';
// import 'package:projet_wordlink/services/timer_service.dart';
// bool timerStarted = true;

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Timer Widget Demo',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: Provider<TimerService>(
//         create: (_) => TimerService()..start(), // Start the timer service
//         child: const TimerWidgetDemo(),
//       ),
//     );
//   }
// }

// class TimerWidgetDemo extends StatelessWidget {
//   const TimerWidgetDemo({super.key});
  

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Timer Widget Demo'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             const TimerWidget(),
//             const SizedBox(height: 16.0),
//             ElevatedButton(
//               onPressed: () {
//                 if(timerStarted){
//                   context.read<TimerService>().stop();
//                   timerStarted = false;
//                 } else {
//                   context.read<TimerService>().start();
//                   timerStarted = true;
//                 }
//               },
//               child: const Text('Restart'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }