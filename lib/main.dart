import 'package:flutter/material.dart';
import 'package:projet_wordlink/repositories/dictionary_repository.dart';
import 'package:projet_wordlink/services/dictionary_service.dart';
import 'package:projet_wordlink/services/timer_service.dart';
import 'package:projet_wordlink/viewmodels/game_view_model.dart';
import 'package:projet_wordlink/views/screens/game_screen/game_screen.dart';
import 'package:projet_wordlink/generated/app_localizations.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => GameViewModel(
        DictionaryRepositoryImpl(RemoteDictionaryService()),
        TimerService(),
      ),
      child: Consumer<GameViewModel>(
        builder: (context, viewModel, child) {
          return MaterialApp(
            title: 'WordLink',
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            locale: Locale(viewModel.selectedLanguage),
            home: GameScreen(viewModel: viewModel, language: viewModel.selectedLanguage),
          );
        },
      ),
    );
  }
}


