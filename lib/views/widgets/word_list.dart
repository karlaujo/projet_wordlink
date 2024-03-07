import 'package:flutter/material.dart';
import 'package:projet_wordlink/models/word.dart';
import 'package:projet_wordlink/views/widgets/word_input_field.dart';

class WordList extends StatelessWidget {
  final List<Word> words;

  const WordList({super.key, required this.words});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: words.length,
        itemBuilder: (context, index) {
          return Text(words[index].text);
        },
      ),
    );
  }
}