import 'package:flutter/material.dart';
import 'package:projet_wordlink/models/word.dart';

class WordInputField extends StatelessWidget {
  final Function(String) onWordSubmitted;

  const WordInputField({super.key, required this.onWordSubmitted, required Word word});

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: const InputDecoration(
        labelText: 'Enter Word',
        border: OutlineInputBorder(),
      ),
      onSubmitted: onWordSubmitted, // When the user submits the word
    );
  }
}