import 'package:flutter_riverpod/flutter_riverpod.dart';
import "dart:math";

enum MartialArtsMove {
  hand,
  kick,
  grab;
}

typedef OneStepsState = Map<MartialArtsMove, List<num>>;

class OneSteps extends Notifier<OneStepsState> {
  @override
  Map<MartialArtsMove, List<num>> build() =>
      {for (final k in MartialArtsMove.values) k: <num>[]};

  void setMove(MartialArtsMove martialArtsMove, List<num> items) {
    state[martialArtsMove] = items;
    ref.notifyListeners();
  }

  void clearAll() {
    for (final martialArtsMove in MartialArtsMove.values) {
      state[martialArtsMove]!.clear();
    }
    ref.notifyListeners();
  }

  String getRandomValueString() {
    // 1. Filter the map entries.
    final filteredMap =
        state.entries.where((entry) => entry.value.isNotEmpty).toList();

    // 2. Check for non-empty entries.
    if (filteredMap.isEmpty) return "";

    // 3. Get a random entry.
    final randomEntry = filteredMap[Random().nextInt(filteredMap.length)];

    // 4. Get a random value and convert it to string.
    final randomValueString = randomEntry
        .value[Random().nextInt(randomEntry.value.length)]
        .toString();

    // 5. Combine move and value into a string.
    return "${randomEntry.key.name} $randomValueString";
  }
}

final oneStepsProvider =
    NotifierProvider<OneSteps, OneStepsState>(() => OneSteps());
