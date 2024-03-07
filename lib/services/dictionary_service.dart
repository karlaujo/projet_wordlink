import 'package:http/http.dart' as http;

abstract class DictionaryService {
  Future<http.Response> loadWords(String dictionaryUrl);
}

class LocalDictionaryService implements DictionaryService {
  @override
  Future<http.Response> loadWords(String dictionaryUrl) {
    // Not applicable for local files
    throw UnimplementedError();
  }
}

class RemoteDictionaryService implements DictionaryService {
  @override
  Future<http.Response> loadWords(String dictionaryUrl) {
    return http.get(Uri.parse(dictionaryUrl));
  }
}


// class DictionaryService{
//   final String url;
//   Set<String> _words = {};

//   DictionaryService(this.url);

//   Future<void> loadDictionary() async {
//     try {
//       final response = await http.get(Uri.parse(url));
//       if (response.statusCode == 200) {
//         var jsonResponse = json.decode(response.body);
//         List<String> words = (jsonResponse is List) as List<String>;
//         _words = words.map((word) => word.trim().toLowerCase()).toSet();
//       } else if (response.statusCode == 401 || response.statusCode == 403){
//         throw Exception('Error: API key is missing or invalid. Check if API requires key.');
//       } else {
//         throw Exception('Failed to load dictionary. Status code: ${response.statusCode}');
//       }
//     } catch(e) {
//       throw Exception('Failed to load dictionary: $e');
//     }
//   }

//   bool verifyWord(String word) {
//     return _words.contains(word.toLowerCase());
//   }
// }

