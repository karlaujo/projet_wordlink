import 'package:flutter/material.dart';
import 'package:projet_wordlink/repositories/dictionary_repository.dart';
import 'package:projet_wordlink/services/dictionary_service.dart';
import 'package:projet_wordlink/services/timer_service.dart';
import 'package:projet_wordlink/viewmodels/game_view_model.dart';
import 'package:provider/provider.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  late GameViewModel _viewModel;
  final TextEditingController _startWordController = TextEditingController();
  final TextEditingController _targetWordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _viewModel = GameViewModel(DictionaryRepositoryImpl(LocalDictionaryService()), TimerService());
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: _viewModel,
      child: Scaffold(
        appBar: AppBar(title: const Text('WordLink')),
        body: Column(
          children: [
            TextField(
              controller: _startWordController,
              decoration: const InputDecoration(
                labelText: 'Start Word',
              ),
            ),
            TextField(
              controller: _targetWordController,
              decoration: const InputDecoration(
                labelText: 'Target Word',
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                final startWord = _startWordController.text.trim();
                final targetWord = _targetWordController.text.trim();
                
                if (_viewModel.wordChain.isEmpty) {
                  final isStartWordValid = await _viewModel.validateWord(startWord);
                  if (isStartWordValid) {
                    _viewModel.addWord(startWord);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('The start word is not valid.')),
                    );
                  }
                } else if (_viewModel.wordChain.length == 1) {
                  final isTargetWordValid = await _viewModel.validateWord(targetWord);
                  if (isTargetWordValid) {
                    _viewModel.addWord(targetWord);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('The target word is not valid.')),
                    );
                  }
                }
              },
              child: const Text('Submit'),
            ),
            StreamBuilder<int>(
              stream: _viewModel.timerService.timeStream,
              builder: (context, snapshot) {
                final remainingTime = snapshot.data ?? 120;
                return Text(
                  'Time remaining: $remainingTime seconds',
                  style: const TextStyle(fontSize: 18),
                );
              },
            ),
            if (_viewModel.wordChain.isNotEmpty && !_viewModel.gameStarted)
              Chip(
                label: Text(_viewModel.wordChain.first),
              ),
            if (_viewModel.wordChain.length > 1 && !_viewModel.gameStarted)
              Chip(
                label: Text(_viewModel.wordChain[1]),
              ),
            const SizedBox(height: 20),
            if (_viewModel.gameStarted)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Chip(
                    label: Text(_viewModel.wordChain.first),
                  ),
                  ..._viewModel.emptyBubbles.map((word) => Chip(
                    label: Text(word.isEmpty ? "" : word),
                  )).toList(),
                  if (_viewModel.wordChain.length > 1)
                    Chip(
                      label: Text(_viewModel.wordChain[1]),
                    ),
                ],
              ),
            if (!_viewModel.gameStarted && _viewModel.wordChain.length == 2)
              ElevatedButton(
                onPressed: () {
                  _viewModel.startGame(_startWordController.text.trim(), _targetWordController.text.trim());
                },
                child: const Text('Start'),
              ),
            if (_viewModel.gameStarted)
              ElevatedButton(
                onPressed: () {
                  _viewModel.restartGame();
                },
                child: const Text('Restart'),
              ),
          ],
        ),
      ),
    );
  }
}