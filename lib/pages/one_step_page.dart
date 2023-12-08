import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../states/text_to_speach_state.dart';
import '../widgets/one_steps_form_widget.dart';
import '../widgets/one_steps_text_to_speech_widget.dart';

class OneStepPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textToSpeechState = ref.watch(textToSpeechProvider);

    return Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Column(
                    // mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(bottom: 5, top: 5),
                        child: Text(
                          'One Steps',
                          textAlign: TextAlign.center,
                          // overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 40),
                        ),
                      ),
                      OneStepTextToSpeechWidget(),
                      CalloutFormWidget(),
                    ]),
              ],
            ),
          ),
        ),
        bottomSheet: Container(
          width: MediaQuery.of(context).size.width,
          child: ElevatedButton(
            style: ButtonStyle(
              shape: MaterialStateProperty.all(RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(0.0), // Remove any border radius
              )),
              textStyle: MaterialStateProperty.all(
                TextStyle(fontSize: 30.0),
              ),
            ),
            onPressed: () {
              if (textToSpeechState.timerState ==
                  TextToSpeechStateEnum.stopped) {
                ref
                    .read(textToSpeechProvider.notifier)
                    .setCounter(5); // TODO: get from variable
              } else {
                ref.read(textToSpeechProvider.notifier).setCounter(0);
              }
              ref.read(textToSpeechProvider.notifier).toggleState();
            },
            child: Padding(
                padding: EdgeInsets.only(bottom: 10, top: 10),
                child: (textToSpeechState.timerState ==
                        TextToSpeechStateEnum.stopped)
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [Text('Start'), Icon(Icons.play_arrow)])
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [Text('Stop'), Icon(Icons.stop)])),
          ),
        ));
  }
}
