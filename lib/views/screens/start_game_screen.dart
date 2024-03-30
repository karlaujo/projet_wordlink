import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:projet_wordlink/repositories/dictionary_repository.dart';
import 'package:projet_wordlink/services/dictionary_service.dart';
import 'package:projet_wordlink/services/timer_service.dart';
import 'package:projet_wordlink/viewmodels/game_view_model.dart';
import 'package:projet_wordlink/generated/app_localizations.dart';
import 'package:projet_wordlink/viewmodels/game_view_model_provider.dart';
import 'package:projet_wordlink/views/screens/game_screen/game_screen.dart';
import 'package:projet_wordlink/views/widgets/timer_widget/timer_widget.dart';
import 'package:provider/provider.dart';

class StartGameScreen extends StatefulWidget {
  final String language;
  final int selectedLevel;
  final GameViewModel viewModel;
  //GameViewModel get _viewModel => viewModel;
  //int get _selectedLevel => selectedLevel;
  const StartGameScreen({Key? key, required this.language, required this.selectedLevel, required this.viewModel}) : super(key: key);

  @override
  _StartGameScreenState createState() => _StartGameScreenState();
}

class _StartGameScreenState extends State<StartGameScreen> {
  final List<TextEditingController> _wordControllers = [];
  late final GameViewModel _viewModel;
  
  late String _startWord=''; 
  late String _endWord='';

  @override
  void initState() {
    super.initState();
    _viewModel = widget.viewModel;
    setWords();
    _wordControllers.addAll(List.generate(_endWord.length - _startWord.length - 1, (index) => TextEditingController()));
  }

  void setWords(){
    switch(widget.selectedLevel){
      case 0:
        _startWord = 'pan';
        _endWord = 'planter';
      case 1:
        _startWord = 'pan2';
        _endWord = 'planter';
      case 2:
        _startWord = 'pan3';
        _endWord = 'planter';
    }
  }

  @override
  void dispose() {
    for (final controller in _wordControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Provider<TimerService>(create: (context) => TimerService(),
    child: Scaffold(
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
             IconButton(
              icon: const Icon(Icons.arrow_back),
              color: Colors.white,
              onPressed: (){
                Navigator.pop(context);
              },
            ),
            const SizedBox(width: 10,),
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
            const SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildWordBubble(_startWord),
                _buildWordBubble(_endWord),
              ],
            ),
            const SizedBox(height: 16.0),
            ..._buildWordTextFields(),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () async {
                final words = [_startWord, ..._wordControllers.map((controller) => controller.text.trim()), _endWord];
                bool isValid = true;
                for (int i = 1; i < words.length; i++) {
                  isValid = await _viewModel.validateWordInChain(words[i - 1], words[i], _endWord);
                  if (!isValid) break;
                }
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text(isValid ? AppLocalizations.of(context)!.validChain : AppLocalizations.of(context)!.invalidChain),
                    content: Text(isValid ? AppLocalizations.of(context)!.validChainMessage : AppLocalizations.of(context)!.invalidChainMessage),
                    actions: [
                      TextButton(
                        onPressed: () { Navigator.pop(context);
                        if (isValid){
                          Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => GameScreen(viewModel: _viewModel, language: _viewModel.selectedLanguage,),
                          ),
                        );
                        }
                        },
                        child: Text('OK'),
                      ),
                    ],
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
                child: Text(AppLocalizations.of(context)!.verify),
              ),
            ),
            const Spacer(),
            // const Padding(
            //   padding: EdgeInsets.all(16.0),
            //   child: TimerWidget()
            // ),
          ],
        ),
      ),
    )
    );
  }

  Widget _buildWordBubble(String word) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            offset: const Offset(0, 2),
            blurRadius: 4,
          ),
        ],
      ),
      child: Text(
        word,
        style: const TextStyle(fontSize: 18),
      ),
    );
  }

  List<Widget> _buildWordTextFields() {
    return List.generate(_wordControllers.length, (index) {
      final controller = _wordControllers[index];
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: TextField(
          controller: controller,
          onChanged: (value) {
          if (value.isNotEmpty) {
            // Add each letter to the word chain
            _viewModel.addWord(value[value.length - 1]);
          } else {
            // Remove letters from the word chain when the word is deleted
            _viewModel.removeWord(value[value.length - 1]);
          }
        },
          decoration: InputDecoration(
            hintText: AppLocalizations.of(context)!.enterWord,
            filled: true,
            fillColor: Colors.white,
            border: const OutlineInputBorder(),
            suffixIcon: ValueListenableBuilder<TextEditingValue>(
              valueListenable: controller,
              builder: (context, value, child) {
                if (value.text.isEmpty) {
                  return const SizedBox.shrink();
                } else {
                  return FutureBuilder<bool>(
                    future: _viewModel.validateWordInChain(index == 0 ? _startWord : _wordControllers[index - 1].text.trim(), value.text.trim(), _endWord),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const CircularProgressIndicator();
                      } else if (snapshot.hasData && snapshot.data!) {
                        _viewModel.addWord(value.text.trim());
                        return const Icon(Icons.check, color: Colors.green);
                      } else {
                        return IconButton(
                          icon: const Icon(Icons.close, color: Colors.red),
                          onPressed: () => controller.clear(),
                        );
                      }
                    },
                  );
                }
              },
            ),
          ),
        ),
      );
    });
  }
}