import 'package:flutter/foundation.dart' show immutable;
import 'package:riverpod/riverpod.dart';
import 'package:uuid/uuid.dart';

const _uuid = Uuid();

final defaultCallouts = [
  Callout(
      id: _uuid.v4(),
      title: 'Hands 1',
      description: 'Callout 1',
      category: 'Hands',
      enabled: true),
  Callout(
      id: _uuid.v4(),
      title: 'Hands 2',
      description: 'Callout 1',
      category: 'Hands',
      enabled: true),
  Callout(
      id: _uuid.v4(),
      title: 'Hands 3',
      description: 'Callout 1',
      category: 'Hands',
      enabled: true),
  Callout(
      id: _uuid.v4(),
      title: 'Hands 4',
      description: 'Callout 1',
      category: 'Hands',
      enabled: true),
  Callout(
      id: _uuid.v4(),
      title: 'Hands 5',
      description: 'Callout 1',
      category: 'Hands',
      enabled: true),
  Callout(
      id: _uuid.v4(),
      title: 'Hands 6',
      description: 'Callout 1',
      category: 'Hands',
      enabled: true),
  Callout(
      id: _uuid.v4(),
      title: 'Hands 7',
      description: 'Callout 1',
      category: 'Hands',
      enabled: true),
  Callout(
      id: _uuid.v4(),
      title: 'Hands 8',
      description: 'Callout 1',
      category: 'Hands',
      enabled: true),
  Callout(
      id: _uuid.v4(),
      title: 'Hands 9',
      description: 'Callout 1',
      category: 'Hands',
      enabled: true),
  Callout(
      id: _uuid.v4(),
      title: 'Hands 10',
      description: 'Callout 1',
      category: 'Hands',
      enabled: true),
  Callout(
      id: _uuid.v4(),
      title: 'Hands 11',
      description: 'Callout 1',
      category: 'Hands',
      enabled: true),
  Callout(
      id: _uuid.v4(),
      title: 'Hands 12',
      description: 'Callout 1',
      category: 'Hands',
      enabled: true),
  Callout(
      id: _uuid.v4(),
      title: 'Hands 13',
      description: 'Callout 1',
      category: 'Hands',
      enabled: true),
  Callout(
      id: _uuid.v4(),
      title: 'Hands 14',
      description: 'Callout 1',
      category: 'Hands',
      enabled: true),
  Callout(
      id: _uuid.v4(),
      title: 'Hands 15',
      description: 'Callout 1',
      category: 'Hands',
      enabled: true),
  Callout(
      id: _uuid.v4(),
      title: 'Hands 16',
      description: 'Callout 1',
      category: 'Hands',
      enabled: true),
  Callout(
      id: _uuid.v4(),
      title: 'Hands 17',
      description: 'Callout 1',
      category: 'Hands',
      enabled: true),
  Callout(
      id: _uuid.v4(),
      title: 'Hands 18',
      description: 'Callout 1',
      category: 'Hands',
      enabled: true),
  Callout(
      id: _uuid.v4(),
      title: 'Hands 19',
      description: 'Callout 1',
      category: 'Hands',
      enabled: true),
  Callout(
      id: _uuid.v4(),
      title: 'Hands 20',
      description: 'Callout 1',
      category: 'Hands',
      enabled: true),
  Callout(
      id: _uuid.v4(),
      title: 'test2',
      description: 'Callout 2',
      category: 'Kicks',
      enabled: true),
  Callout(
      id: _uuid.v4(),
      title: 'test3',
      description: 'Callout 3',
      category: 'Grabs',
      enabled: true),
];

/// A read-only description of a todo-item
@immutable
class Callout {
  const Callout({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.enabled,
  });

  final String id;
  final String title;
  final String description;
  final String category;
  final bool enabled;
}

/// An object that controls a list of [Callout].
class CalloutList extends Notifier<List> {
  @override
  List build() {
    return defaultCallouts;
  }

  // CalloutList([List<Callout>? initialCallouts]) : super(initialCallouts ?? []);

  int length() {
    return state.length;
  }

  // void add(String description) {
  //   state = [
  //     ...state,
  //     Callout(
  //       id: _uuid.v4(),
  //       description: description,
  //       enabled: true,
  //     ),
  //   ];
  // }

  void toggle(String id) {
    state = [
      for (final CalloutFromState in state)
        if (CalloutFromState.id == id)
          Callout(
            id: CalloutFromState.id,
            title: CalloutFromState.title,
            category: CalloutFromState.category,
            enabled: !CalloutFromState.enabled,
            description: CalloutFromState.description,
          )
        else
          CalloutFromState,
    ];
  }

  // void edit({required String id, required String description}) {
  //   state = [
  //     for (final Callout in state)
  //       if (Callout.id == id)
  //         Callout(id: Callout.id, description: description, enabled: false)
  //       else
  //         Callout,
  //   ];
  // }

  // void remove(Callout target) {
  //   state = state.where((Callout) => Callout.id != target.id).toList();
  // }
}
