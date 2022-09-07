import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:learn_english/view/play_game/features/slide_party/features/playboard/models/playboard_state/playboard_state.dart';

export '../models/playboard_state.dart';

typedef PlayboardController<T extends PlayboardState> = StateNotifier<T>;

final playboardControllerProvider = StateNotifierProvider.autoDispose<PlayboardController, PlayboardState>(
    (_) => throw UnimplementedError('Need implement controller this before access in playBoard.'));
