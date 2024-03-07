class Word {
  final String value;
  final bool isInitial;
  final bool isFinal;

  Word({
    required this.value,
    this.isInitial = false,
    this.isFinal = false,
  });

  String get text => value;
}