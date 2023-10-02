import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'main.dart';

final calloutFormProvider =
    NotifierProvider<CalloutFormState, String>(CalloutFormState.new);

class CalloutFormState extends Notifier<String> {
  @override
  String build() {
    return '';
  }

  void set(value) {
    state = value;
  }
}

class CalloutFormWidget extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final inputController = TextEditingController();

    return Column(
      children: [
        TextFormField(
          controller: inputController,
          onChanged: (value) {
            // Update the form state when the input value changes
            ref.read(calloutFormProvider.notifier).set(value);
          },
          decoration: InputDecoration(
            border: UnderlineInputBorder(),
            labelText: 'Enter a Callout',
            suffix: IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                final inputValue = ref.read(calloutFormProvider.notifier).state;
                ref.read(calloutStateProvider.notifier).add(inputValue);
                inputController.clear();
                ref.read(calloutFormProvider.notifier).set('');
              },
            ),
          ),
        ),
        // ElevatedButton(
        //   onPressed: () {
        //     // Handle form submission
        //     final inputValue = ref.read(calloutFormProvider.notifier).state;
        //     ref.read(calloutStateProvider.notifier).add(inputValue);
        //   },
        //   child: Text('Submit'),
        // ),
      ],
    );
  }
}
