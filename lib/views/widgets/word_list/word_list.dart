import 'package:flutter/material.dart';
import 'word_list_item.dart';

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
    return ListView.builder(
      itemCount: widget.words.length,
      itemBuilder: (context, index) {
        return WordListItem(
          word: widget.words[index],
          isSelected: index == _selectedIndex,
          onTap: () => _handleWordTap(index),
        );
      },
    );
  }
}