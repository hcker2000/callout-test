import 'package:flutter_riverpod/flutter_riverpod.dart';

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
}

final oneStepsProvider =
    NotifierProvider<OneSteps, OneStepsState>(() => OneSteps());
