import 'package:learn_english/view/play_game/features/slide_party/widgets/buttons/models/slideparty_button_params.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'playboard_config.freezed.dart';

@freezed
class PlayboardConfig with _$PlayboardConfig {
  const factory PlayboardConfig.none() = NonePlayboardConfig;
  const factory PlayboardConfig.blind(ButtonColors color) = BlindPlayboardConfig;
  const factory PlayboardConfig.number(ButtonColors color) = NumberPlayboardConfig;
  const factory PlayboardConfig.multiple(Map<String, PlayboardConfig> configs) = MultiplePlayboardConfig;
}

extension EditMultipleConfig on MultiplePlayboardConfig {
  MultiplePlayboardConfig changeConfig(String id, PlayboardConfig config) =>
      MultiplePlayboardConfig({...configs}..[id] = config);
}
