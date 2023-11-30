import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'one_steps_state.dart';

typedef OneStepsState = Map<MartialArtsMove, String>;

class OneStepsFormState extends Notifier<OneStepsState> {
  @override
  Map<MartialArtsMove, String> build() =>
      {for (final k in MartialArtsMove.values) k: ''};

  void setMove(MartialArtsMove martialArtsMove, String value) {
    state[martialArtsMove] = value;
    ref.notifyListeners();
  }
}

final oneStepsFormProvider = NotifierProvider<OneStepsFormState, OneStepsState>(
    () => OneStepsFormState());
