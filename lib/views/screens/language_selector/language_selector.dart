import 'package:flutter/material.dart';
import 'package:projet_wordlink/repositories/dictionary_repository.dart';
import 'package:projet_wordlink/services/dictionary_service.dart';
import 'package:projet_wordlink/services/timer_service.dart';
import 'package:projet_wordlink/viewmodels/game_view_model.dart';
import 'package:projet_wordlink/views/screens/game_screen/game_screen.dart';

class LanguageSelectorScreen extends StatefulWidget {
  final Function(String) onLanguageSelected;
  final GameViewModel viewModel;

  const LanguageSelectorScreen({Key? key, required this.onLanguageSelected, required this.viewModel})
      : super(key: key);

  @override
  _LanguageSelectorScreenState createState() => _LanguageSelectorScreenState();
}

class _LanguageSelectorScreenState extends State<LanguageSelectorScreen> {
  String _selectedLanguage = 'fr'; // Default language is French
  late final GameViewModel _viewModel;
  
  @override
  void initState() {
    super.initState();
    _viewModel = widget.viewModel;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Language'),
      ),
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
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  _viewModel.selectedLanguage = 'fr';
                  setState(() {
                    _selectedLanguage = 'fr';
                  });
                  widget.onLanguageSelected('fr');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: _selectedLanguage == 'fr' ? Colors.blue : Colors.grey,
                ),
                child: const Text('Français'),
              ),
              const SizedBox(width: 16),
              ElevatedButton(
                onPressed: () {
                  _viewModel.selectedLanguage = 'en';
                  setState(() {
                    _selectedLanguage = 'en';
                  });
                  widget.onLanguageSelected('en');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: _selectedLanguage == 'en' ? Colors.blue : Colors.grey,
                ),
                child: const Text('English'),
              ),
              const SizedBox(height: 20), // Add spacing
              ElevatedButton(
                onPressed: () {
                  // Use the current _selectedLanguage to navigate
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => GameScreen(viewModel: _viewModel, language: _selectedLanguage),
                    ),
                  );
                },
                child: Text('OK'),
              )
            ],
          ),
        ),
      ),
    );
  }
}