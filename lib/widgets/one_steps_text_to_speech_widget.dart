import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../states/text_to_speach_state.dart';

class OneStepTextToSpeechWidget extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textToSpeechState = ref.watch(textToSpeechProvider);

    return Center(
      child: Text(
        '${textToSpeechState.timerState.name} ${textToSpeechState.counter}',
        style: const TextStyle(fontSize: 24),
      ),
    );
  }
}
