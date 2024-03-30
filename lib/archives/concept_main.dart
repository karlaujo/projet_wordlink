// void main() {
//   runApp( WordLinkApp());
// }

// class WordLinkApp extends StatelessWidget {
//   const WordLinkApp({super.key});
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'WordLink Game',
//       theme: ThemeData(
//         // This is the theme of your application.
//         //
//         // TRY THIS: Try running your application with "flutter run". You'll see
//         // the application has a purple toolbar. Then, without quitting the app,
//         // try changing the seedColor in the colorScheme below to Colors.green
//         // and then invoke "hot reload" (save your changes or press the "hot
//         // reload" button in a Flutter-supported IDE, or press "r" if you used
//         // the command line to start the app).
//         //
//         // Notice that the counter didn't reset back to zero; the application
//         // state is not lost during the reload. To reset the state, use hot
//         // restart instead.
//         //
//         // This works for code too, not just values: Most code changes can be
//         // tested with just a hot reload.
//         colorScheme: ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 253, 14, 14)),
//         useMaterial3: true,
//         primarySwatch: Colors.blue,
//       ),
//       home: const MyGameScreen(title: 'WordLink Game'),
//     );
//   }
// }

// class MyGameScreen extends StatefulWidget {
//   const MyGameScreen({super.key, required this.title});

//   // This widget is the home page of your application. It is stateful, meaning
//   // that it has a State object (defined below) that contains fields that affect
//   // how it looks.
//   // This class is the configuration for the state. It holds the values (in this
//   // case the title) provided by the parent (in this case the App widget) and
//   // used by the build method of the State. Fields in a Widget subclass are
//   // always marked "final".

//   final String title;

//   @override
//   State<MyGameScreen> createState() => _MyGameScreenState();
// }

// class _MyGameScreenState extends State<MyGameScreen> {
//   final TextEditingController _controller = TextEditingController();
//   List<String> _wordChain = [];
//   //String default_url = 'https://www.oxfordlearnersdictionaries.com/api/v1/documentation/html#v1dictionaries';
//   //String _currentWord = '';
//   int _startTimeInSeconds = 90;
//   String _timeString = '1:30';
//   Timer? _gameTimer;
//   List<Dictionary> dictionaries = [
//     Dictionary(title: 'Default Dictionnary', url: ''),
//   ];
//   // late DictionaryService _dictionaryService;
//   Dictionary _selectedDictionary = Dictionary(title: 'Default Dictionary', url: '');
//   bool _gameStarted = false;
//   List<String> _emptyBubbles = [];

//   @override
//   void initState(){
//     super.initState();
//     // _selectedDictionary = dictionaries[0];
//     // _dictionaryService = DictionaryService(default_url);
//     // _dictionaryService.loadDictionary().then((_) {
//     //   //Success load
//     // }).catchError((error) {
//     //   //Error loading
//     // });
//     // startTimer();
//   }

//   @override
//   Widget build(BuildContext context) {
//     // This method is rerun every time setState is called, for instance as done
//     // by the _incrementCounter method above.
//     //
//     // The Flutter framework has been optimized to make rerunning build methods
//     // fast, so that you can just rebuild anything that needs updating rather
//     // than having to individually change instances of widgets.
//     return Scaffold(
//       appBar: AppBar(
//         // TRY THIS: Try changing the color here to a specific color (to
//         // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
//         // change color while the other colors stay the same.
//         backgroundColor: Theme.of(context).colorScheme.inversePrimary,
//         //Here we take the value from the MyHomePage object that was created by
//         //the App.build method, and use it to set our appbar title.
//         title: Text(widget.title),
//         actions: <Widget>[
//           PopupMenuButton<Dictionary>(
//             //onSelected: handleDictionarySelection,
//             onSelected: (Dictionary dictionary) {
//               setState(() {
//                 _selectedDictionary = dictionary;
//               });
//             },
//             itemBuilder: (BuildContext context) {
//               return dictionaries.map((Dictionary dictionary) {
//                 return PopupMenuItem<Dictionary>(
//                   value: dictionary,
//                   child: Text(dictionary.title),
//                 );
//               }).toList();
//             },
//           ),
//         ],
//       ),
//       body:  Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.start,
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: <Widget>[
//           TextField(
//             controller: _controller,
//             decoration: InputDecoration(
//               suffixIcon: IconButton(
//                 icon: Icon(Icons.restart_alt),
//                 onPressed: _wordChain.isNotEmpty ? () {
//                   setState(() {
//                     _wordChain.removeLast();
//                   });
//                 } : null,
//               ),
//               label: Text('Enter your word'),
//               border: OutlineInputBorder(),
//             ),
//           ),
//           const SizedBox(height: 20),
//           ElevatedButton(
//             onPressed: () {
//               if (_gameStarted) {
//                   final newWord = _controller.text.trim();
//                   if (_wordChain.isNotEmpty) {
//                     final firstWord = _wordChain.first;
//                     print(firstWord);
//                     final lastWord = _wordChain.last;
//                     print(lastWord);
//                     final isLongerByOne = newWord.length == firstWord.length + 1;
//                     print("Is longer by one: " + isLongerByOne.toString());
//                     final containsAllLetters = newWord.split('').every((char) => lastWord.contains(char));
//                     print("Contains all letters: " + containsAllLetters.toString());
//                     print("Checking if i can add the word: $newWord");

//                     if (isLongerByOne && containsAllLetters) {
//                       print("Adding word: $newWord");
//                       setState(() {
//                         // Find the first empty bubble and replace it with the new word
//                         final emptyBubbleIndex = _emptyBubbles.indexWhere((bubble) => bubble == "");
//                         if (emptyBubbleIndex != -1) {
//                           _emptyBubbles[emptyBubbleIndex] = newWord;
//                           _wordChain.add(newWord); // Add the new word to the word chain
//                           setState(() {
//                             checkIfGameOver();
//                           });();
//                         }
//                       });
//                     } else {
//                       // Show error if conditions are not met
//                       ScaffoldMessenger.of(context).showSnackBar(
//                         SnackBar(content: Text('Each word must be longer by one and contain all letters of the previous word.')),
//                       );
//                     }
//                   }
//                   _controller.clear();
//                 } else {
//                   // Handle game not started state or other logic
//                 }
              
//               if (!_gameStarted){
//                 final newWord = _controller.text.trim();
//                 // Check if only one word has been submitted so far
//                 if (_wordChain.length < 1) {
//                   setState(() {
//                     _wordChain.add(newWord);
//                     _controller.clear();
//                   });
//                 } else if (_wordChain.length == 1) {
//                   // Validate the second word
//                   final firstWord = _wordChain.first;
//                   final isLonger = newWord.length > firstWord.length;
//                   final containsAllLetters = firstWord.split('').every((char) => newWord.contains(char));

//                   if (isLonger && containsAllLetters) {
//                     setState(() {
//                       _wordChain.add(newWord);
//                       _controller.clear();
//                     });
//                   } else {
//                     // Show error if conditions are not met
//                     ScaffoldMessenger.of(context).showSnackBar(
//                       SnackBar(content: Text('The second word must be longer and contain all letters of the first word.')),
//                     );
//                   }
//                 } else {
//                   // Show error if more than two words are submitted
//                   ScaffoldMessenger.of(context).showSnackBar(
//                     SnackBar(content: Text('Only two words are allowed.')),
//                   );
//                 }
//               }
//             },
//             child: const Text('Submit'),
//           ),
          
//           if (!_gameStarted)Expanded( 
//             child: ListView.builder(
//               itemCount: _wordChain.length,
//               itemBuilder: (context, index) {
//                 return ListTile(
//                   title: Text(_wordChain[index]),
//                 );
//               },
//             ),
//           ),
//           if (_wordChain.isNotEmpty && !_gameStarted)
//             Chip(
//               label: Text(_wordChain.first,),
//             ),
//           if (_wordChain.length > 1 && !_gameStarted) 
//             Chip(
//               label: Text(_wordChain[1]), // Show the second word if it has been added
//             ),
//           const SizedBox(height: 20),
//           if (_gameStarted) // Show the words as bubbles when the game has started
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center, // Center the chips in the row
//               children: <Widget>[
//                 Chip(
//                   label: Text(_wordChain.first),
//                 ),
//                 // Replace empty bubbles with words as they are submitted
//                 ..._emptyBubbles.map((word) => Chip(
//                   label: Text(word.isEmpty ? "" : word),
//                 )).toList(),
//                 if (_wordChain.length > 1) // Only show the second word if it's been added
//                   Chip(
//                     label: Text(_wordChain[1]),
//                   ),
//               ],
//             ),
            
//           if (!_gameStarted && _wordChain.length >= 2) // Show the start button conditionally
//             ElevatedButton(
//               onPressed: () {
//                 startTimer();
//                 int numberOfBubbles = _wordChain[1].length - _wordChain[0].length - 1;
//                 _emptyBubbles = List<String>.filled(numberOfBubbles, "");
//                 setState(() {
//                   _gameStarted = true;
//                 });
//               },
//               child: const Text('Start'),
//             ),
//           if (_gameStarted)
//             ElevatedButton(
//                 onPressed: () {
//                   restartGame(); // Implement this function to reset the game state
//                 },
//                 child: const Text('Restart'),
//               ),
//           Text(
//             'Timer: ' + _timeString,
//             textAlign: TextAlign.center,
//             style: Theme.of(context).textTheme.headlineMedium
//           ),
//           ],
//         ),
//       ),
//     );
//   }

//   // // void _submitWord(){
//   //   /*
//   //   setState(() {
//   //     _currentWord = _controller.text;
//   //     _wordChain.add(_currentWord);
//   //     _controller.clear();
//   //   });*/

//   //   final word = _controller.text.trim().toLowerCase();
//   //   if (_wordChain.length >=2){
//   //       // ignore: unnecessary_null_comparison
//   //       if (_dictionaryService != null && _dictionaryService.verifyWord(word)){
//   //         setState(() {
//   //           _wordChain.add(word);
//   //         });
//   //       } else {
//   //         //word is not in dictionary
//   //       }
//   //   } else {
//   //     setState(() {
//   //       _wordChain.add(word);
//   //     });
//   //   }
//   //   _controller.clear();
//   // }

//   void startTimer(){
//     Duration onSec = Duration(seconds: 1);
//     _gameTimer = Timer.periodic(onSec, (Timer timer) {
//       if (_startTimeInSeconds == 0) {
//         setState(() {
//           timer.cancel();
//           _timeString = '00:00';
//         });
//       } else {
//         setState(() {
//           _startTimeInSeconds--;
//           _timeString = formatTime(_startTimeInSeconds);
//         });
//       }
//     });
//   }

//   void stopTimer() {
//     _gameTimer?.cancel();
//   }

//   void restartGame(){
//     setState(() {
//     _wordChain.clear(); // Clear the word chain
//     _emptyBubbles.clear(); // Clear empty bubbles if used in the game
//     _startTimeInSeconds = 90; // Reset timer
//     _timeString = '1:30'; // Reset timer display
//     _gameStarted = false; // Set game state to not started
//     _controller.clear(); // Clear text field
//     stopTimer(); // Stop the current timer if running
//     });
//   }


//   String formatTime(int totalSeconds){
//     int minutes = totalSeconds ~/ 60;
//     int seconds = totalSeconds % 60;
//     //generate timer assign it to string
//     return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
//   }
  
//   void checkIfGameOver() {
//     bool allWordsFound = !_emptyBubbles.any((word) => word == "");
//     if (allWordsFound) {
//       stopTimer();
//       showCompletionDialog(context, (90-_startTimeInSeconds));
//     }
//   }

//   @override
//   void dispose() {
//     _gameTimer?.cancel(); // Cancel the timer if the widget is disposed
//     super.dispose();
//   }

//   void showCompletionDialog(BuildContext context, int timeTaken) {
//   showDialog(
//     context: context,
//     builder: (BuildContext context) {
//       return AlertDialog(
//         title: Text("Congratulations!"),
//         content: Text("Wordlink achieved in $timeTaken seconds!"),
//         actions: <Widget>[
//           TextButton(
//             child: Text("Hooray!"),
//             onPressed: () {
//               Navigator.of(context).pop(); // Close the dialog
//             },
//           ),
//         ],
//       );
//     },
//   );
// }

  
//   // void handleDictionarySelection(Dictionary dictionary) {
//   //   showDialog(
//   //   context: context, 
//   //   builder: (BuildContext context) {
//   //         final titleController = TextEditingController(text: dictionary.title);
//   //         final urlController = TextEditingController(text: dictionary.url);

//   //         return AlertDialog(
//   //           title: const Text('Edit Dictionary'),
//   //           content: Column(
//   //             mainAxisSize: MainAxisSize.min,
//   //             children: [
//   //               TextFormField(
//   //                 controller: titleController,
//   //                 decoration: const InputDecoration(labelText: 'Title'),
//   //               ),
//   //               TextFormField(
//   //                 controller: urlController,
//   //                 decoration: const InputDecoration(labelText: 'URL'),
//   //               ),
//   //             ],
//   //           ),
//   //           actions: <Widget>[
//   //             TextButton(
//   //               child: const Text('Cancel'),
//   //               onPressed: () {
//   //                 Navigator.of(context).pop();
//   //               },
//   //             ),
//   //             TextButton(
//   //               child: const Text('Save'),
//   //               onPressed: () {
//   //                 setState(() {
//   //                   dictionary.title = titleController.text;
//   //                   dictionary.url = urlController.text;

//   //                   //Logic to persist changes
//   //                 });
//   //                 Navigator.of(context).pop();
//   //               },
//   //             ),
//   //           ],
//   //         );
//   //       },
//   //     );
//   //   }
// }


// class Dictionary {
//   String title;
//   String? url;

//   Dictionary({required this.title, required this.url});
// }

