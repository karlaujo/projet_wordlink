import 'package:flutter/material.dart';
import 'package:projet_wordlink/views/widgets/word_list/word_list_item.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Word List Demo',
      home: Scaffold(
        body: Center(
          child: WordList(
            words: ['House', 'Mouse', 'Louse'],  
          ),
        ),
      ),
    );
  }
}

class WordList extends StatefulWidget {

  final List<String> words;
  
  const WordList({Key? key, required this.words}) : super(key: key);

  @override 
  _WordListState createState() => _WordListState();
}

class _WordListState extends State<WordList> {

  int _selectedIndex = -1;

  void _handleWordTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

@override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          constraints: BoxConstraints(maxWidth: 200),
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: widget.words.length,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  WordListItem(
                  word: widget.words[index],
                  isSelected: index == _selectedIndex,
                  onTap: () => _handleWordTap(index), 
                  ),
                  SizedBox(height: 12),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}