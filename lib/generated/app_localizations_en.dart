import 'app_localizations.dart';

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get dictionary => 'Dictionary';

  @override
  String get language => 'Language';

  @override
  String get startGame => 'Start Game';

  @override
  String get selectLevel => 'Select Level';

  @override
  String get easy => 'Easy';

  @override
  String get medium => 'Medium';

  @override
  String get hard => 'Hard';

  @override
  String get validChain => 'Good Answer :)';
  
  @override
  // TODO: implement enterWord
  String get enterWord => 'Enter Word';
  
  @override
  // TODO: implement invalidChain
  String get invalidChain => 'Wrong answer :(';
  
  @override
  // TODO: implement invalidChainMessage
  String get invalidChainMessage => 'Try again !';
  
  @override
  // TODO: implement isValidWord
  String get isValidWord => 'Valid';
  
  @override
  // TODO: implement validChainMessage
  String get validChainMessage => 'Good Job !';
  
  @override
  // TODO: implement verify
  String get verify => 'Verify';
  

}
