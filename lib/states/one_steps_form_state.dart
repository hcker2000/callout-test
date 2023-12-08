import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'one_steps_state.dart';

typedef OneStepsState = Map<MartialArtsMove, String>;
final oneStepsFormProvider =
    NotifierProvider<OneStepsFormNotifier, OneStepsFormState>(
        () => OneStepsFormNotifier());

class OneStepsFormState {
  final OneStepsState moves;
  final String delay;

  const OneStepsFormState({required this.moves, required this.delay});

  OneStepsFormState copyWith({OneStepsState? martialArtsMove, String? delay}) {
    return OneStepsFormState(
        moves: martialArtsMove ?? this.moves, delay: delay ?? this.delay);
  }
}

class OneStepsFormNotifier extends Notifier<OneStepsFormState> {
  @override
  // Build method to create initial state
  OneStepsFormState build() {
    return OneStepsFormState(
      moves: {for (final k in MartialArtsMove.values) k: ''},
      delay: '10',
    );
  }

  void setMove(MartialArtsMove martialArtsMove, String value) {
    var tmpMap = state.moves;
    tmpMap[martialArtsMove] = value;
    state = state.copyWith(martialArtsMove: tmpMap);
  }

  void setDelay(String newDelay) {
    state = state.copyWith(delay: newDelay);
  }
}
