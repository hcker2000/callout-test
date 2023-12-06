import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'dart:async';
import "dart:math";
import 'one_steps_state.dart';

enum TextToSpeechStateEnum { running, stopped }

void _runTimerLogic(TextToSpeechState state, TextToSpeechNotifier notifier) {
  if (state.timerState == TextToSpeechStateEnum.stopped) {
    return;
  }
  notifier.decrementCounter();
}

class TextToSpeechState {
  TextToSpeechState(
      {required this.timerState, required this.counter, required this.timer});

  final TextToSpeechStateEnum timerState;
  final num counter;
  final Timer timer;

  TextToSpeechState copyWith(
      {TextToSpeechStateEnum? timerState, num? counter, Timer? timer}) {
    return TextToSpeechState(
        timerState: timerState ?? this.timerState,
        counter: counter ?? this.counter,
        timer: timer ?? this.timer);
  }
}

class TextToSpeechNotifier extends Notifier<TextToSpeechState> {
  late FlutterTts flutterTts;
  String? language;
  String? engine;
  double volume = 1;
  double pitch = 1.0;
  double rate = 0.5;

  @override
  TextToSpeechState build() {
    ref.onDispose(() => print('TextToSpeechState.onDispose'));
    return TextToSpeechState(
        timerState: TextToSpeechStateEnum.stopped,
        counter: 0,
        timer: Timer.periodic(
            Duration(seconds: 1), (timer) => _runTimerLogic(state, this)));
  }

  void setCounter(num value) {
    state = state.copyWith(counter: value);
  }

  void decrementCounter() {
    var newValue = state.counter - 1;
    print('dec');
    if (newValue <= 0) {
      newValue = 30; // TODO: get from the state
    }

    state = state.copyWith(counter: newValue);
  }

  void toggleState() {
    var newValue = TextToSpeechStateEnum.running;
    // Cancel the existing timer before creating a new one
    state.timer.cancel();

    if (state.timerState == TextToSpeechStateEnum.running) {
      newValue = TextToSpeechStateEnum.stopped;
    } else {
      state = state.copyWith(
        timer: Timer.periodic(
          Duration(seconds: 1),
          (timer) => _runTimerLogic(state, this),
        ),
      );
    }

    state = state.copyWith(timerState: newValue);
  }
}

final textToSpeechProvider =
    NotifierProvider<TextToSpeechNotifier, TextToSpeechState>(
        () => TextToSpeechNotifier());
