import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../callout.dart';

final calloutStateProvider = NotifierProvider<CalloutList, List>(() {
  return CalloutList();
});

class OneStepPage extends ConsumerWidget {
  final ScrollController _firstController = ScrollController();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var calloutState = ref.watch(calloutStateProvider);
    List<Widget> widgets = [];
    List enabled = calloutState.where((callout) => callout.enabled).toList();

    for (var pair in calloutState) {
      widgets.add(CheckboxListTile(
          title: Text(pair.title),
          value: pair.enabled,
          onChanged: (value) {
            ref.read(calloutStateProvider.notifier).toggle(pair.id);
            return;
          }));
    }

    return Column(
      children: [
        Row(
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'One Steps',
                  textAlign: TextAlign.center,
                  // overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 40),
                ),
                Text(
                  'Enabled ${enabled.length}',
                  textAlign: TextAlign.center,
                  // overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontSize: 14),
                )
              ],
            )
          ],
        ),
        Expanded(
            child: Row(
          children: [
            Flexible(
                child: Scrollbar(
                    thumbVisibility: true,
                    controller: _firstController,
                    child: ListView.builder(
                        controller: _firstController,
                        itemCount: widgets.length,
                        itemBuilder: (BuildContext context, int index) {
                          return widgets[index];
                        })))
          ],
        ))
      ],
    );
  }
}
