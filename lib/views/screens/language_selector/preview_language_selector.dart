// import 'package:flutter/material.dart';
// import 'package:projet_wordlink/viewmodels/game_view_model.dart';
// import 'package:projet_wordlink/views/screens/language_selector/language_selector.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Language Selector Demo',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: const LanguageSelectorDemo(),
//     );
//   }
// }

// class LanguageSelectorDemo extends StatelessWidget {
//   const LanguageSelectorDemo({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Language Selector Demo'),
//       ),
//       body: Center(
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: LanguageSelectorScreen(
//             onLanguageSelected: (language) {
//               print('Selected language: $language');
//             }, viewModel: GameViewModel(_dictionaryRepository, _timerService),
//           ),
//         ),
//       ),
//     );
//   }
// }