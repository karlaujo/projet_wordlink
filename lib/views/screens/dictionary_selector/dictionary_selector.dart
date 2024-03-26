/*import 'package:flutter/material.dart';

class DictionarySelector extends StatefulWidget {
  final List<String> dictionaries;
  final String selectedDictionary;
  final ValueChanged<String> onSelected;

  const DictionarySelector({
    Key? key, 
    required this.dictionaries,
    required this.selectedDictionary,
    required this.onSelected,
  }) : super(key: key);

  @override
  _DictionarySelectorState createState() => _DictionarySelectorState();
}

class _DictionarySelectorState extends State<DictionarySelector> {
  late String selectedDictionary;

  @override
  void initState() {
    selectedDictionary = widget.selectedDictionary;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: selectedDictionary,
      onChanged: (dictionary) {
        setState(() {
          selectedDictionary = dictionary!;
        });
        widget.onSelected(dictionary!);
      },
      items: widget.dictionaries
          .map((dictionary) => DropdownMenuItem(
                value: dictionary,
                child: Text(dictionary),
              ))
          .toList(),
    );
  }
}*/

import 'package:flutter/material.dart';

class DictionarySelector extends StatefulWidget {
  final Function(String) onDictionarySelected;

  const DictionarySelector({Key? key, required this.onDictionarySelected})
      : super(key: key);

  @override
  _DictionarySelectorState createState() => _DictionarySelectorState();
}

class _DictionarySelectorState extends State<DictionarySelector> {
  String? _dictionaryUrl;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: () {
            widget.onDictionarySelected('assets');
          },
          child: const Text('Use Default Dictionary'),
        ),
        const SizedBox(height: 16),
        TextField(
          onChanged: (value) {
            setState(() {
              _dictionaryUrl = value;
            });
          },
          decoration: const InputDecoration(
            hintText: 'Enter dictionary URL',
          ),
        ),
        const SizedBox(height: 16),
        ElevatedButton(
          onPressed: _dictionaryUrl != null
              ? () {
                  widget.onDictionarySelected(_dictionaryUrl!);
                }
              : null,
          child: const Text('Use Dictionary from URL'),
        ),
      ],
    );
  }
} 