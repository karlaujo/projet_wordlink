// import 'package:flutter/material.dart';
// import 'package:projet_wordlink/views/screens/dictionary_selector/dictionary_selector.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Dictionary Selector Demo',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: const DictionarySelectorDemo(),
//     );
//   }
// }

// class DictionarySelectorDemo extends StatelessWidget {
//   const DictionarySelectorDemo({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Dictionary Selector Demo'),
//       ),
//       body: Center(
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: DictionarySelector(
//             onDictionarySelected: (dictionarySource) {
//               // Handle the selected dictionary source
//               print('Selected dictionary source: $dictionarySource');
//             },
//           ),
//         ),
//       ),
//     );
//   }
// }