import 'package:flutter/material.dart';
import 'package:projet_wordlink/repositories/dictionary_repository.dart';
import 'package:projet_wordlink/services/dictionary_service.dart';
import 'package:projet_wordlink/services/timer_service.dart';
import 'package:projet_wordlink/viewmodels/game_view_model.dart';

class GameViewModelProvider extends InheritedWidget {
  final GameViewModel viewModel;

  const GameViewModelProvider({
    Key? key,
    required this.viewModel,
    required Widget child,
  }) : super(key: key, child: child);

  static GameViewModelProvider of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<GameViewModelProvider>()!;
  }

  @override
  bool updateShouldNotify(covariant GameViewModelProvider oldWidget) {
    return viewModel != oldWidget.viewModel;
  }
}