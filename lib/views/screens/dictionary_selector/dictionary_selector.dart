import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:projet_wordlink/generated/app_localizations.dart';

class DictionarySelectorScreen extends StatefulWidget {
  final Function(String) onDictionarySelected;

  const DictionarySelectorScreen({Key? key, required this.onDictionarySelected})
      : super(key: key);

  @override
  _DictionarySelectorScreenState createState() => _DictionarySelectorScreenState();
}

class _DictionarySelectorScreenState extends State<DictionarySelectorScreen> {
  String? _dictionaryUrl;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF6B8E23),
              Color(0xFFFFFFFF),
            ],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 40),
            Text(
              AppLocalizations.of(context)!.dictionary,
              textAlign: TextAlign.center,
              style: GoogleFonts.pacifico(
                fontSize: 48,
                color: Colors.white,
                shadows: [
                  const Shadow(
                    color: Colors.black,
                    offset: Offset(2, 2),
                    blurRadius: 4,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                widget.onDictionarySelected('assets');
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                shape: const StadiumBorder(), backgroundColor: const Color(0xFF9CCC65),
                elevation: 4,
              ),
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Text('Use Default Dictionary'),
              ),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: TextField(
                onChanged: (value) {
                  setState(() {
                    _dictionaryUrl = value;
                  });
                },
                decoration: const InputDecoration(
                  hintText: 'Enter dictionary URL',
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _dictionaryUrl != null
                  ? () {
                      widget.onDictionarySelected(_dictionaryUrl!);
                      Navigator.pop(context);
                    }
                  : null,
              style: ElevatedButton.styleFrom(
                shape: const StadiumBorder(),
                backgroundColor: const Color(0xFF9CCC65),
                elevation: 4,
              ),
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Text('Use Dictionary from URL'),
              ),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  shape: const StadiumBorder(),
                  backgroundColor: const Color(0xFF9CCC65),
                  elevation: 4,
                ),
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  child: Text('Cancel'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}