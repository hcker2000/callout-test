import 'dart:ffi';

import 'package:flutter/foundation.dart' show immutable;
import 'package:riverpod/riverpod.dart';
import 'package:uuid/uuid.dart';

const _uuid = Uuid();

/// A read-only description of a todo-item
@immutable
class Callout {
  const Callout({
    required this.description,
    required this.id,
    required this.enabled,
    this.completed = false,
  });

  final String id;
  final String description;
  final bool enabled;
  final bool completed;

  @override
  String toString() {
    return 'Callout(description: $description, completed: $completed)';
  }
}

/// An object that controls a list of [Callout].
class CalloutList extends Notifier<List> {
  @override
  List build() {
    return [];
  }

  // CalloutList([List<Callout>? initialCallouts]) : super(initialCallouts ?? []);

  int length() {
    return state.length;
  }

  void add(String description) {
    state = [
      ...state,
      Callout(
        id: _uuid.v4(),
        description: description,
        enabled: true,
      ),
    ];
  }

  void toggle(String id) {
    state = [
      for (final CalloutFromState in state)
        if (CalloutFromState.id == id)
          Callout(
            id: CalloutFromState.id,
            enabled: !CalloutFromState.enabled,
            description: CalloutFromState.description,
          )
        else
          CalloutFromState,
    ];
  }

  void edit({required String id, required String description}) {
    state = [
      for (final Callout in state)
        if (Callout.id == id)
          Callout(id: Callout.id, description: description, enabled: false)
        else
          Callout,
    ];
  }

  void remove(Callout target) {
    state = state.where((Callout) => Callout.id != target.id).toList();
  }
}
