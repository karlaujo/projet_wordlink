import 'dart:convert';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:projet_wordlink/services/dictionary_service.dart';


abstract class DictionaryRepository {
  Future<bool> wordExists(String word, String dictionaryUrl);
}

class DictionaryRepositoryImpl implements DictionaryRepository {
  final DictionaryService _dictionaryService;

  DictionaryRepositoryImpl(this._dictionaryService);

  @override
  Future<bool> wordExists(String word, String dictionaryUrl) async {
    if (dictionaryUrl.startsWith('http')) {
      // Handle remote dictionary
      try {
        final response = await _dictionaryService.loadWords(dictionaryUrl);
        if (response.statusCode == 200) {
          final String jsonString = await rootBundle.loadString(dictionaryUrl);
          return jsonString.contains(word);
        } else {
          throw Exception('Failed to load words from remote URL');
        }
      } catch (e) {
        print(e.toString());
        // Handle error or throw a custom exception
        return false;
      }
    } else {
      // Handle local dictionary
      try {
        final String jsonString = await rootBundle.loadString(dictionaryUrl);
        return jsonString.contains(word);
      } catch (e) {
        print(e.toString());
        // Handle error or throw a custom exception
        return false;
      }
    }
  }
}