import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'dart:async';
import "dart:math";
import 'one_steps_state.dart';

enum TextToSpeechStateEnum { running, stopped }

class TextToSpeechState {
  TextToSpeechState({required this.timerState, required this.counter});

  final TextToSpeechStateEnum timerState;
  final num counter;

  TextToSpeechState copyWith(
      {TextToSpeechStateEnum? timerState, num? counter}) {
    return TextToSpeechState(
        timerState: timerState ?? this.timerState,
        counter: counter ?? this.counter);
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
        timerState: TextToSpeechStateEnum.stopped, counter: 0);
  }

  void setCounter(num value) {
    state = state.copyWith(counter: value);
  }

  void decrementCounter() {
    var newValue = state.counter - 1;

    if (newValue < 0) {
      newValue = 0;
    }

    state = state.copyWith(counter: newValue);
  }

  void toggleState() {
    var newValue = TextToSpeechStateEnum.running;
    if (state.timerState == TextToSpeechStateEnum.running) {
      newValue = TextToSpeechStateEnum.stopped;
    }

    state = state.copyWith(timerState: newValue);
  }
}

final textToSpeechProvider =
    NotifierProvider<TextToSpeechNotifier, TextToSpeechState>(
        () => TextToSpeechNotifier());
