import 'package:flutter/material.dart';
import 'package:projet_wordlink/viewmodels/game_view_model.dart';

class GameViewModelProvider extends InheritedWidget {
  final GameViewModel viewModel;

  const GameViewModelProvider({
    super.key,
    required this.viewModel,
    required super.child,
  });

  static GameViewModelProvider of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<GameViewModelProvider>()!;
  }

  @override
  bool updateShouldNotify(covariant GameViewModelProvider oldWidget) {
    return viewModel != oldWidget.viewModel;
  }
}