import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../states/one_steps_state.dart';
import '../states/text_to_speach_state.dart';
import '../widgets/one_steps_form_widget.dart';
import '../widgets/one_steps_text_to_speech_widget.dart';

class OneStepPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final oneStepState = ref.watch(oneStepsProvider);
    final textToSpeechState = ref.watch(textToSpeechProvider);
    final oneStepHandsLength = oneStepState[MartialArtsMove.hand]?.length ?? 0;
    final oneStepKicksLength = oneStepState[MartialArtsMove.kick]?.length ?? 0;
    final oneStepGrabsLength = oneStepState[MartialArtsMove.grab]?.length ?? 0;

    return Scaffold(
        body: Column(
      children: [
        Column(
            // mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: EdgeInsets.only(bottom: 15, top: 10),
                child: Text(
                  'One Steps',
                  textAlign: TextAlign.center,
                  // overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 40),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      'Hands $oneStepHandsLength',
                      textAlign: TextAlign.center,
                      // overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontSize: 14),
                    ),
                    Text(
                      'Kicks $oneStepKicksLength',
                      textAlign: TextAlign.center,
                      // overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontSize: 14),
                    ),
                    Text(
                      'Grabs $oneStepGrabsLength',
                      textAlign: TextAlign.center,
                      // overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontSize: 14),
                    ),
                  ],
                ),
              ),
              OneStepTextToSpeechWidget(),
              ElevatedButton(
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
                child: (textToSpeechState.timerState ==
                        TextToSpeechStateEnum.stopped)
                    ? Text('Start')
                    : Text('Stop'),
              ),
              ExpansionTile(
                title: const Text('Settings'),
                children: [
                  // SizedBox(
                  //   height: 200,
                  //   child: ListView.builder(
                  //       controller: _firstController,
                  //       itemCount: widgets.length,
                  //       itemBuilder: (BuildContext context, int index) {
                  //         return widgets[index];
                  //       }),
                  // )
                  Container(
                    decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.secondary),
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 0, horizontal: 20),
                      child: CalloutFormWidget(),
                    ),
                  )
                ],
              ),
            ]),
      ],
    ));
  }
}
