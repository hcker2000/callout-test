import 'dart:ui';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/foundation.dart';

import '../callout.dart';

final calloutStateProvider = NotifierProvider<CalloutList, List>(() {
  return CalloutList();
});

List<int> convertStringToIntArray(String string) {
  // Split the string into a list of strings, using the comma as a delimiter.
  List<String> stringList = string.split(',');

  // Create an empty list to store the converted integers.
  List<int> intList = [];

  // Iterate over the list of strings and convert each one to an integer.
  for (String string in stringList) {
    // If the string contains a hyphen, it is a range of numbers.
    if (string.contains('-')) {
      // Split the string into two parts, at the hyphen.
      List<String> rangeParts = string.split('-');

      // Convert the start and end of the range to integers.
      int start = int.parse(rangeParts[0]);
      int end = int.parse(rangeParts[1]);

      // Add all of the integers in the range to the list.
      for (int i = start; i <= end; i++) {
        intList.add(i);
      }
    } else {
      // If the string does not contain a hyphen, it is a single number.
      intList.add(int.parse(string));
    }
  }

  // Return the list of converted integers.
  return intList;
}

String? validateInputString(String? string) {
  // Check if the string is empty.
  if (string == null || string.isEmpty) {
    return 'The string must not be empty.';
  }

  // Check if the string contains any invalid characters.
  final regex = RegExp(r"[^\d,-]");
  if (regex.hasMatch(string)) {
    return 'The string must only contain numbers, commas, and hyphens.';
  }

  // Check if the string contains any ranges with invalid start or end values.
  for (final rangeString in string.split(",")) {
    if (rangeString.contains("-")) {
      final start = int.tryParse(rangeString.split("-")[0]);
      final end = int.tryParse(rangeString.split("-")[1]);
      if (start == null || end == null) {
        return 'The range must contain two valid numbers.';
      }
      if (start > end) {
        return 'The start value of the range must be less than or equal to the end value.';
      }
    }
  }

  // Check if the string contains any numbers greater than 30.
  for (final number in string.split(",")) {
    final parsedNumber = int.tryParse(number);
    if (parsedNumber != null && parsedNumber > 30) {
      return 'All numbers must be less than or equal to 30.';
    }
  }
  // The string is valid.
  return null;
}

class OneStepPage extends ConsumerWidget {
  final ScrollController _firstController = ScrollController();
  final _formKey = GlobalKey<FormState>();

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
                child: Text(
                  'Enabled ${enabled.length}',
                  textAlign: TextAlign.center,
                  // overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontSize: 14),
                ),
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
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            TextFormField(
                              validator: validateInputString,
                              decoration: InputDecoration(
                                labelText: 'Hands',
                              ),
                            ),
                            TextFormField(
                              validator: validateInputString,
                              decoration: InputDecoration(
                                labelText: 'Kicks',
                              ),
                            ),
                            TextFormField(
                              validator: validateInputString,
                              decoration: InputDecoration(
                                labelText: 'Grabs',
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 15, horizontal: 0),
                              child: Text(
                                  'You can set each field in the following way. For example setting Hands to 1,5,10-12 would result in a call out for Hands 1, Hands 5, Hands 10, Hands 11 and Hands 12. The maximum is 30 and leaving them blank will disable that section of call outs.',
                                  style: TextStyle(fontSize: 12)),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 15, horizontal: 0),
                              child: ElevatedButton(
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    // The form is valid.
                                  } else {
                                    // The form is invalid.
                                  }
                                },
                                child: Text('Save'),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ]),

        // Expanded(
        //     child: Row(
        //   children: [
        //     Flexible(
        //         child: Scrollbar(
        //             thumbVisibility: true,
        //             controller: _firstController,
        //             child: ListView.builder(
        //                 controller: _firstController,
        //                 itemCount: widgets.length,
        //                 itemBuilder: (BuildContext context, int index) {
        //                   return widgets[index];
        //                 })))
        //   ],
        // ))
      ],
    ));
  }
}
