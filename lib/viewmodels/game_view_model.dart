import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:projet_wordlink/repositories/dictionary_repository.dart';
import 'package:projet_wordlink/services/timer_service.dart';

class GameViewModel extends ChangeNotifier {
  final DictionaryRepository _dictionaryRepository;
  final TimerService _timerService;
  TimerService get timerService => _timerService;
  Timer? _gameTimer;
  String _startWord = '';
  String _targetWord = '';
  List<String> _wordChain = [];
  List<String> get wordChain => _wordChain;
  bool _isGameRunning = false;
  int _remainingSeconds = 120;
  String _dictionaryUrl = 'lib/ressources/assets/dictionary.json'; // Default dictionary path
  bool _gameStarted = false;
  bool get gameStarted => _gameStarted;
  List<String> _emptyBubbles = [];
  List<String> get emptyBubbles => _emptyBubbles;

  GameViewModel(this._dictionaryRepository, this._timerService);

  //Translation of the app
  String _selectedLanguage = 'fr';
  String _language = 'fr';
  String get language => _language;
  Map<String, dynamic>? _translations;

  String get selectedLanguage => _selectedLanguage;

  set selectedLanguage(String language) {
    _selectedLanguage = language;
    loadTranslations().then((_) {
      notifyListeners();
    });
  }

  void setLanguage(String lang){
    _language = lang;
    notifyListeners();
  }

  Future<void> loadTranslations() async {
    String translations;
    if (_selectedLanguage == 'en') {
      translations = await rootBundle.loadString('lib/ressources/assets/en.json');
    } else {
      translations = await rootBundle.loadString('lib/ressources/assets/fr.json');
    }

    _translations = jsonDecode(translations);
  }

  String translate(String key) {
    return _translations?[key] ?? key;
  }


  // Method to update the dictionary URL
  void updateDictionaryUrl(String newUrl) {
    _dictionaryUrl = newUrl;
    notifyListeners();
  }

  Future<bool> validateWord(String previousWord, String newWord, String endWord) async {
  if (_wordChain.isEmpty) {
    // Si la chaîne de mots est vide, cela signifie que nous validons le mot de départ
    final existsInDictionary = await _dictionaryRepository.wordExists(newWord, _dictionaryUrl);
    return existsInDictionary;
  } if (newWord == endWord) {
    // Si le nouveau mot est le mot cible, nous le validons
    final isLongerByAtLeastTwo = newWord.length >= previousWord.length + 2;
    final containsAllLetters = previousWord.split('').every((char) => newWord.contains(char));
    final existsInDictionary = await _dictionaryRepository.wordExists(newWord, _dictionaryUrl);
    return isLongerByAtLeastTwo && containsAllLetters && existsInDictionary;
  }
  // Pour les mots intermédiaires, nous utilisons les règles de validation existantes
  final isLongerByOne = newWord.length == previousWord.length + 1;
  final containsAllLetters = previousWord.split('').every((char) => newWord.contains(char));
  final lettersInEndWord = newWord.split('').every((char) => endWord.contains(char));
  final existsInDictionary = await _dictionaryRepository.wordExists(newWord, _dictionaryUrl);
  return isLongerByOne && containsAllLetters && existsInDictionary && lettersInEndWord;
  
}

Future<bool> validateWordInChain(String previousWord, String newWord, String endWord) async {
    // For subsequent words, use the existing validation logic
    final isLongerByOne = newWord.length == previousWord.length + 1;
    final containsAllLetters = previousWord.split('').every((char) => newWord.contains(char));
    final lettersInEndWord = newWord.split('').every((char) => endWord.contains(char));
    final existsInDictionary = await _dictionaryRepository.wordExists(newWord, _dictionaryUrl);
    return isLongerByOne && containsAllLetters && existsInDictionary && lettersInEndWord;
  
}

  void startGame(String startWord, String targetWord) {
  _startWord = startWord;
  _targetWord = targetWord;
  _wordChain = [_startWord];
  _isGameRunning = true;
  _remainingSeconds = 120; // Reset remaining seconds if needed
  _timerService.start(); // Start the timer
  int numberOfBubbles = _targetWord.length - _startWord.length - 1;
  _emptyBubbles = List<String>.filled(numberOfBubbles, "");
  _gameStarted = true;
  notifyListeners();
}

void restartGame() {
  _wordChain.clear();
  _emptyBubbles.clear();
  _gameStarted = false;
  _isGameRunning = false;
  _timerService.stop(); // Stop the timer
  notifyListeners();
}

void _endGame({bool success = false}) {
  _isGameRunning = false;
  _timerService.stop(); // Stop the timer
  notifyListeners();
}

void _onTimerTick() {
  _remainingSeconds = _timerService.remainingSeconds; // Update remaining seconds from TimerService
  notifyListeners(); // Notify listeners to update UI or other components
}


  Future<void> addWord(String newWord) async {
    _wordChain.add(newWord);
    // if (newWord == _targetWord) {
    //   _endGame(success: true);
    // }
    notifyListeners();
  }

  @override
  void dispose() {
    _gameTimer?.cancel();
    super.dispose();
  }

  void isValidWord(String newWord, String prevWord, String endWord) {
    
  }

  void removeWord(String value) {
    _wordChain.remove(value);
    // if (newWord == _targetWord) {
    //   _endGame(success: true);
    // }
    notifyListeners();
  }
}