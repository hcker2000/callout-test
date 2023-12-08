import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../states/one_steps_state.dart';
import '../states/one_steps_form_state.dart';

List<num> convertStringToIntArray(String? string) {
  // Create an empty list to store the converted integers.
  List<num> intList = [];

  if (string != null && string != '') {
    // Split the string into a list of strings, using the comma as a delimiter.
    List<String> stringList = string.split(',');

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
  }

  // Return the list of converted integers.
  return intList;
}

String? validateInputString(String? string) {
  // Check if the string is empty.
  if (string == null || string.isEmpty) {
    // return 'The string must not be empty.';
    return null;
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

final _formKey = GlobalKey<FormState>();

class CalloutFormWidget extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final oneStepFormState = ref.watch(oneStepsFormProvider);
    final oneStepState = ref.watch(oneStepsProvider);
    final oneStepHandsLength = oneStepState[MartialArtsMove.hand]?.length ?? 0;
    final oneStepKicksLength = oneStepState[MartialArtsMove.kick]?.length ?? 0;
    final oneStepGrabsLength = oneStepState[MartialArtsMove.grab]?.length ?? 0;

    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
              ],
              initialValue: oneStepFormState.delay,
              validator: validateInputString,
              onSaved: (String? value) {
                value ??= '';
                ref.read(oneStepsFormProvider.notifier).setDelay(value);
              },
              decoration: InputDecoration(
                labelText: 'Count Down Length',
              ),
            ),
            TextFormField(
              initialValue: oneStepFormState.moves[MartialArtsMove.hand] ?? '',
              validator: validateInputString,
              onSaved: (String? value) {
                value ??= '';

                ref.read(oneStepsProvider.notifier).setMove(
                    MartialArtsMove.hand, convertStringToIntArray(value));
                ref
                    .read(oneStepsFormProvider.notifier)
                    .setMove(MartialArtsMove.hand, value);
              },
              decoration: InputDecoration(
                labelText: 'Hands ($oneStepHandsLength)',
              ),
            ),
            TextFormField(
              initialValue: oneStepFormState.moves[MartialArtsMove.kick] ?? '',
              validator: validateInputString,
              onSaved: (String? value) {
                value ??= '';

                ref.read(oneStepsProvider.notifier).setMove(
                    MartialArtsMove.kick, convertStringToIntArray(value));
                ref
                    .read(oneStepsFormProvider.notifier)
                    .setMove(MartialArtsMove.kick, value);
              },
              decoration: InputDecoration(
                labelText: 'Kicks ($oneStepKicksLength)',
              ),
            ),
            TextFormField(
              initialValue: oneStepFormState.moves[MartialArtsMove.grab] ?? '',
              validator: validateInputString,
              onSaved: (String? value) {
                value ??= '';

                ref.read(oneStepsProvider.notifier).setMove(
                    MartialArtsMove.grab, convertStringToIntArray(value));
                ref
                    .read(oneStepsFormProvider.notifier)
                    .setMove(MartialArtsMove.grab, value);
              },
              decoration: InputDecoration(
                labelText: 'Grabs ($oneStepGrabsLength)',
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 15, horizontal: 0),
              child: Text(
                  'You can set each field in the following way. For example setting Hands to 1,5,10-12 would result in a call out for Hands 1, Hands 5, Hands 10, Hands 11 and Hands 12. The maximum is 30 and leaving them blank will disable that section of call outs.',
                  style: TextStyle(
                      fontSize: 12,
                      color: Theme.of(context).colorScheme.secondary)),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 15, horizontal: 0),
              child: ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // The form is valid.
                    _formKey.currentState!.save();
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
    );
  }
}
