import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:projet_wordlink/repositories/dictionary_repository.dart';
import 'package:projet_wordlink/services/dictionary_service.dart';
import 'package:projet_wordlink/services/translations.dart';
import 'package:projet_wordlink/services/timer_service.dart';
import 'package:projet_wordlink/viewmodels/game_view_model.dart';
import 'package:projet_wordlink/views/screens/dictionary_selector/dictionary_selector.dart';
import 'package:projet_wordlink/views/screens/language_selector/language_selector.dart';
import 'package:projet_wordlink/views/screens/start_game_screen.dart';
import 'package:projet_wordlink/generated/app_localizations.dart';
import 'package:provider/provider.dart';


class GameScreen extends StatefulWidget {
  final String language;
  final GameViewModel viewModel;
  const GameScreen({super.key, required this.viewModel, required this.language, localizationsDelegates= AppLocalizations.localizationsDelegates,
  supportedLocales= AppLocalizations.supportedLocales,});

  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  int _selectedLevel = 0;
  late GameViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = widget.viewModel;
    _viewModel.selectedLanguage = (widget.language);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: _viewModel,
      child: Consumer<GameViewModel>(
      builder: (context, viewModel, child) {
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
                  'WordLink',
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DictionarySelectorScreen(
                              onDictionarySelected: (dictionaryUrl) {
                                _viewModel.updateDictionaryUrl(dictionaryUrl);
                              },
                            ),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        shape: const StadiumBorder(), backgroundColor: const Color(0xFF9CCC65),
                        elevation: 4,
                      ),
                      child:  Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                        child: Text(AppLocalizations.of(context)!.dictionary),
                      ),
                    ),
                    ElevatedButton(
                      // GameScreen 
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LanguageSelectorScreen(
                              onLanguageSelected: (language) {
                                _viewModel.setLanguage(language);
                                print('Selected language: $language');
                                
                              }, 
                              viewModel: _viewModel,
                            ),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        shape: const StadiumBorder(), backgroundColor: const Color(0xFF9CCC65),
                        elevation: 4,
                      ),
                      child:  Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                        child: Text(AppLocalizations.of(context)!.language),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        // Handle start game
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => StartGameScreen(language: widget.language, selectedLevel: _selectedLevel, viewModel: _viewModel)
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        shape: const StadiumBorder(), backgroundColor: const Color(0xFF9CCC65),
                        elevation: 4,
                      ),
                      child:  Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                        child: Text(AppLocalizations.of(context)!.startGame),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 40),
                Text(
                  AppLocalizations.of(context)!.selectLevel,
                  textAlign: TextAlign.center,
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
                    Radio(
                      value: 0,
                      groupValue: _selectedLevel,
                      onChanged: (value) {
                        setState(() {
                          _selectedLevel = value as int;
                        });
                      },
                      activeColor: const Color(0xFF9CCC65),
                    ),
                    Text(AppLocalizations.of(context)!.easy),
                    const SizedBox(width: 20),
                    Radio(
                      value: 1,
                      groupValue: _selectedLevel,
                      onChanged: (value) {
                        setState(() {
                          _selectedLevel = value as int;
                        });
                      },
                      activeColor: const Color(0xFF9CCC65),
                    ),
                    Text(AppLocalizations.of(context)!.medium),
                    const SizedBox(width: 20),
                    Radio(
                      value: 2,
                      groupValue: _selectedLevel,
                      onChanged: (value) {
                        setState(() {
                          _selectedLevel = value as int;
                        });
                      },
                      activeColor: const Color(0xFF9CCC65),
                    ),
                    Text(AppLocalizations.of(context)!.hard),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
                