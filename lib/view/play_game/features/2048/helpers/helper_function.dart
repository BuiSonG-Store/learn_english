

import 'package:learn_english/view/play_game/features/2048/model/individual_cell.dart';
import 'package:learn_english/view/play_game/features/2048/provider/matrix_provider.dart';

import '../../../plugin/locator.dart';
import '../../../plugin/navigator.dart';
import '../model/merge_pos.dart';

class HelperFunction {
  static NavigationService _navigationService = locator<NavigationService>();

  /// Flatten a list
  static List<T> flatten<T>(Iterable<Iterable<T>> list) => [for (var sublist in list) ...sublist];

  static List<IndividualCell> filter(List<IndividualCell> row) => row.where((element) => element.value != 0).toList();

  static List<IndividualCell> slide(List<IndividualCell> row) =>
      List<IndividualCell>.filled(4 - row.length, IndividualCell()) + row;

  static List<IndividualCell> reduce(List<IndividualCell> row) {
    for (var i = 4 - 1; i >= 1; i--) {
      final _value = row[i].value;
      final _element = row[i - 1].value;
      if (_value == _element) {
        if (_value != 0) {
          int x = MatrixProvider.of(_navigationService.getContext()).copyGrid.indexOf(row);
          int y = i;
          MatrixProvider.of(_navigationService.getContext()).mergeList.add(MergePos(x: x, y: y));
          MatrixProvider.of(_navigationService.getContext()).temp_score += _value * 2;
        }
        row[i].value = _value + _element;
        row[i - 1].value = 0;
      }
    }
    return row;
  }
}
