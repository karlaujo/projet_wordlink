import 'dart:convert';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:projet_wordlink/services/dictionary_service.dart';

abstract class DictionaryRepository {
  Future<bool> wordExists(String word, String dictionaryUrl);
}

class DictionaryRepositoryImpl implements DictionaryRepository {
  final RemoteDictionaryService _dictionaryService;

  DictionaryRepositoryImpl(this._dictionaryService);

  @override
  Future<bool> wordExists(String word, String dictionaryUrl) async {
    if (dictionaryUrl.startsWith('http')) {
      // Handle remote dictionary
      try {
        final response = await _dictionaryService.loadWords(dictionaryUrl);
        if (response.statusCode == 200) {
          final jsonString = response.body;
          // Convert the JSON string to plain text
          final plainText = jsonToText(jsonString);
          return plainText.contains(word);
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
        // Convert the JSON string to plain text
        final plainText = jsonToText(jsonString);
        return plainText.contains(word);
      } catch (e) {
        print(e.toString());
        // Handle error or throw a custom exception
        return false;
      }
    }
  }

  String jsonToText(String jsonString) {
    // Parse the JSON string into a Dart object
    final jsonData = jsonDecode(jsonString);
    // Convert the JSON data to a plain text string
    return jsonData.toString();
  }
}