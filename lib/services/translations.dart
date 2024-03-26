class Translations {
  final Map<String, String> translations;

  Translations({required this.translations});

  String text(String key) {
    return translations[key] ?? key;
  }
}