import 'app_localizations.dart';

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get dictionary => 'Dictionnaire';

  @override
  String get language => 'Langue';

  @override
  String get startGame => 'Débuter Jeu';

  @override
  String get selectLevel => 'Sélectionner Niveau';

  @override
  String get easy => 'Facile';

  @override
  String get medium => 'Moyen';

  @override
  String get hard => 'Difficile';
  
  @override
  // TODO: implement enterWord
  String get enterWord => 'Entrer Mot';
  
  @override
  // TODO: implement invalidChain
  String get invalidChain => 'Mauvaise Réponse :(';
  
  @override
  // TODO: implement invalidChainMessage
  String get invalidChainMessage => 'Vas-y encore !';
  
  @override
  // TODO: implement isValidWord
  String get isValidWord => 'Valide';
  
  @override
  // TODO: implement validChain
  String get validChain => 'Bonne Réponse :)';
  
  @override
  // TODO: implement validChainMessage
  String get validChainMessage => 'Bon Travail !';
  
  @override
  // TODO: implement verify
  String get verify => 'Vérifier';
}
