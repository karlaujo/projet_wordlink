import 'dart:async';

class TimerService {
  Timer? _timer;
  int _remainingSeconds = 120;
  final StreamController<int> _timeController = StreamController<int>.broadcast();
  Stream<int> get timeStream => _timeController.stream;

  void start() {
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      _remainingSeconds--;
      _timeController.sink.add(_remainingSeconds); // Emit the remaining seconds through the stream
      if (_remainingSeconds <= 0) {
        stop();
      }
    });
  }

  void stop() {
    _timer?.cancel();
    _timer = null;
    _remainingSeconds = 120;
    _timeController.sink.add(_remainingSeconds); // Emit the reset value through the stream
  }

  void dispose() {
    _timer?.cancel();
    _timeController.close(); // Close the stream controller when disposing the service
  }

  int get remainingSeconds => _remainingSeconds;
}