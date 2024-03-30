import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:projet_wordlink/viewmodels/game_view_model.dart';
import 'package:projet_wordlink/views/screens/game_screen/game_screen.dart';
import 'package:projet_wordlink/generated/app_localizations.dart';

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
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              AppLocalizations.of(context)!.selectLanguage,
              style: GoogleFonts.roboto(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 20),
            Row(
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
                    shape: const StadiumBorder(),
                    backgroundColor: _selectedLanguage == 'fr' ? const Color(0xFF9CCC65) : Colors.white,
                    elevation: 4,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                    child: Text(
                      'Français',
                      style: TextStyle(
                        color: _selectedLanguage == 'fr' ? Colors.white : Colors.black,
                      ),
                    ),
                  ),
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
                    shape: const StadiumBorder(),
                    backgroundColor: _selectedLanguage == 'en' ? const Color(0xFF9CCC65) : Colors.white,
                    elevation: 4,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                    child: Text(
                      'English',
                      style: TextStyle(
                        color: _selectedLanguage == 'en' ? Colors.white : Colors.black,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
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
              style: ElevatedButton.styleFrom(
                shape: const StadiumBorder(),
                backgroundColor: const Color(0xFF9CCC65),
                elevation: 4,
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Text(
                  AppLocalizations.of(context)!.ok,
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}