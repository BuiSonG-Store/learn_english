import 'dart:math';
import 'package:flutter/material.dart';
import 'package:learn_english/view/play_game/features/2048/helpers/helper_function.dart';
import 'package:learn_english/view/play_game/features/2048/model/individual_cell.dart';
import 'package:learn_english/view/play_game/features/2048/model/merge_pos.dart';
import 'package:learn_english/view/play_game/features/2048/provider/score_provider.dart';
import 'package:learn_english/view/play_game/features/2048/screen/end_game_message/game_over_message.dart';
import 'package:learn_english/view/play_game/features/shared_preference_service.dart';
import 'package:learn_english/view/play_game/plugin/locator.dart';
import 'package:learn_english/view/play_game/plugin/navigator.dart';
import 'package:provider/provider.dart';

class MatrixProvider with ChangeNotifier {
  late List<List<IndividualCell>> _grid;

  int matrixSize = 4;
  bool gameOver = false;
  bool gameWin = false;

  List<List<IndividualCell>> get curGrid {
    return _grid;
  }

  static MatrixProvider of(BuildContext context) {
    return Provider.of<MatrixProvider>(context, listen: false);
  }

  List<List<List<IndividualCell>>> history = [<List<IndividualCell>>[]];
  var mergeList = <MergePos>[];
  var copyGrid = [<IndividualCell>[]];
  var _currentGrid = [<IndividualCell>[]];
  var _previousGrid = [<IndividualCell>[]];
  var _flatList = <IndividualCell>[];
  var _randomCell = -1;
  int temp_score = 0;
  late IndividualCell _cellData;
  bool isGenerating = false;
  static NavigationService _navigationService = locator<NavigationService>();
  int undoLeft = 5;

  void initializeGrid() {
    _initialize();
  }

  Future<void> _initialize() async {
    List<List<IndividualCell>> matrix = await SharedPreferenceService.getMatrix();
    var scoreProvider = ScoreProvider.of(_navigationService.getContext());
    scoreProvider.getHighScore();
    scoreProvider.getCurScore();
    gameOver = false;
    if (matrix.isNotEmpty) {
      undoLeft = await SharedPreferenceService.getUndo();
      setCurGrid(matrix);
      history.clear();
      mergeList.clear();
    } else {
      resetUndoLeft();
      _generateGrid(isHardRefresh: true);
      history.clear();
      mergeList.clear();
      _initGenerateNumbers();
      _initGenerateNumbers();
    }
    _previousGrid = _currentGrid;
    _grid = _currentGrid;
    notifyListeners();
  }

  void resetUndoLeft() {
    SharedPreferenceService.setUndo(5);
    undoLeft = 5;
    notifyListeners();
  }

  void setCurGrid(List<List<IndividualCell>> grid) {
    _currentGrid = grid.map((a) => (a).toList()).toList();
    notifyListeners();
  }

  void _flipGrid() {
    _currentGrid = _currentGrid.map((row) => row.reversed.toList()).toList();
  }

  bool checkMerge() {
    for (int i = 0; i < _currentGrid.length; i++) {
      for (int j = 0; j < _currentGrid[i].length; j++) {
        if (_currentGrid[i][j].isMerge == true) {
          return true;
        }
      }
    }
    return false;
  }

  bool checkLatest() {
    for (int i = 0; i < _currentGrid.length; i++) {
      for (int j = 0; j < _currentGrid[i].length; j++) {
        if (_currentGrid[i][j].isLastest == true) {
          return true;
        }
      }
    }
    return false;
  }

  void _transposeGrid(List<List<IndividualCell>> grid) {
    _generateGrid(isHardRefresh: true);
    for (var i = 0; i < matrixSize; i++) {
      for (var j = 0; j < matrixSize; j++) {
        _currentGrid[i][j] = grid[j][i];
      }
    }
  }

  void _gameAlgorithm() {
    _currentGrid = _currentGrid.map(HelperFunction.filter).toList().map(HelperFunction.slide).toList();

    copyGrid = _currentGrid;

    _currentGrid = _currentGrid
        .map(HelperFunction.reduce)
        .toList()
        .map(HelperFunction.filter)
        .toList()
        .map(HelperFunction.slide)
        .toList();
    _generateGrid();
  }

  void checkMergeCell() {
    if (mergeList.length > 0) {
      for (int i = 0; i < mergeList.length; i++) {
        if (mergeList[i].x >= 0 && mergeList[i].x <= 4 && mergeList[i].y >= 0 && mergeList[i].y <= 4) {
          _currentGrid[mergeList[i].x][mergeList[i].y].isMerge = true;
          notifyListeners();
        }
      }
      mergeList.clear();
    }
  }

  ///on left swipe
  void onLeft() {
    if (gameOver == false) {
      _addGridHistory();
      _previousGrid = _currentGrid.map((e) => e.map((a) => IndividualCell.clone(a)).toList()).toList();
      _gameAlgorithm();
      _generateNewNumber();
      checkMergeCell();
      _grid = _currentGrid;
      SharedPreferenceService.saveMatrix(_currentGrid);
      notifyListeners();
    }
  }

  ///on right swipe
  void onRight() {
    if (gameOver == false) {
      _addGridHistory();
      _flipGrid();
      _previousGrid = _currentGrid.map((e) => e.map((a) => IndividualCell.clone(a)).toList()).toList();
      _gameAlgorithm();
      _generateNewNumber();
      checkMergeCell();
      _flipGrid();
      _grid = _currentGrid;
      SharedPreferenceService.saveMatrix(_currentGrid);
      notifyListeners();
    }
  }

  ///on up swipe
  void onUp() {
    if (gameOver == false) {
      _addGridHistory();
      _transposeGrid(_currentGrid);
      _flipGrid();
      _previousGrid = _currentGrid.map((e) => e.map((a) => IndividualCell.clone(a)).toList()).toList();
      _gameAlgorithm();
      _generateNewNumber();
      checkMergeCell();
      _flipGrid();
      _transposeGrid(_currentGrid);
      _grid = _currentGrid;
      SharedPreferenceService.saveMatrix(_currentGrid);
      notifyListeners();
    }
  }

  ///on down swipe
  void onDown() {
    if (gameOver == false) {
      _addGridHistory();
      _transposeGrid(_currentGrid);
      _previousGrid = _currentGrid.map((e) => e.map((a) => IndividualCell.clone(a)).toList()).toList();
      _gameAlgorithm();
      _generateNewNumber();
      checkMergeCell();
      _transposeGrid(_currentGrid);
      _grid = _currentGrid;
      SharedPreferenceService.saveMatrix(_currentGrid);
      notifyListeners();
    }
  }

  void _initGenerateNumbers() {
    _flattenList();
    _randomCell = Random().nextInt(_flatList.length);
    _cellData = _flatList[_randomCell];
    final r = Random().nextInt(2);
    _currentGrid[_cellData.x][_cellData.y].value = r.isEven ? 4 : 2;
  }

  void _generateNewNumber() {
    _flattenList();
    if (_flatList.isNotEmpty) {
      _generateCellData();
    }
  }

  void _isGameOver() {
    for (var i = 0; i < 4; i++) {
      for (var j = 0; j < 4; j++) {
        if (_currentGrid[i][j].value == 0) {
          return;
        }
        if (i != 3 && _currentGrid[i][j].value == _currentGrid[i + 1][j].value) {
          return;
        }
        if (j != 3 && _currentGrid[i][j].value == _currentGrid[i][j + 1].value) {
          return;
        }
      }
    }
    gameOver = true;
    showDialog(
      context: _navigationService.getContext(),
      builder: (BuildContext context) {
        return Column(
          children: const [
            SizedBox(height: 50),
            GameOverMessage(),
          ],
        );
      },
    );
  }

  void _isGameWon() {
    for (var i = 0; i < 4; i++) {
      for (var j = 0; j < 4; j++) {
        if (_currentGrid[i][j].value == 32) {
          showDialog(
            context: _navigationService.getContext(),
            builder: (BuildContext context) {
              return Column(
                children: const [
                  SizedBox(height: 50),
                  GameOverMessage(),
                ],
              );
            },
          );
        }
      }
    }
  }

  void _generateGrid({bool isHardRefresh = false}) => _currentGrid = List.generate(
        matrixSize,
        (i) => List.generate(
          matrixSize,
          (j) => IndividualCell(
            x: i,
            y: j,
            value: isHardRefresh
                ? 0
                : _currentGrid.length > 1
                    ? _currentGrid[i][j].value
                    : 0,
          ),
        ),
      );

  void _flattenList() => _flatList =
      HelperFunction.flatten(_currentGrid).map((e) => e.value == 0 ? e : null).whereType<IndividualCell>().toList();

  bool compare(List<List<IndividualCell>> list1, List<List<IndividualCell>> list2) {
    bool result = true;
    for (int i = 0; i < list1.length; i++) {
      for (int j = 0; j < list1[i].length; j++) {
        if (list1[i][j].value != list2[i][j].value) {
          result = false;
        }
      }
    }
    return result;
  }

  void _addGridHistory() async {
    if (undoLeft > 0) {
      List<List<IndividualCell>> _currentGridCopy =
          _currentGrid.map((e) => e.map((a) => IndividualCell.clone(a)).toList()).toList();
      if (history.length > 5) {
        history.removeAt(0);
      }
      if (history.length > 0) {
        if (compare(_currentGridCopy, history.last) == false) {
          history.add(_currentGridCopy);
        }
      } else {
        history.add(_currentGridCopy);
      }
    }
  }

  void resetCell() {
    for (List<IndividualCell> subList in _currentGrid) {
      for (IndividualCell curCell in subList) {
        curCell.isLastest = false;
        curCell.isMerge = false;
      }
    }
  }

  void _generateCellData() {
    bool check;
    if (history.length > 1) {
      check = compare(_currentGrid, _previousGrid);
    } else {
      check = false;
    }
    if (check == false) {
      ScoreProvider.of(_navigationService.getContext()).gainScoreAmount(temp_score);
      temp_score = 0;
      resetCell();
      _randomCell = Random().nextInt(_flatList.length);
      _cellData = _flatList[_randomCell];
      final r = Random().nextInt(2);
      _currentGrid[_cellData.x][_cellData.y].value = r.isEven ? 2 : 4;
      _currentGrid[_cellData.x][_cellData.y].isLastest = true;
      _isGameOver();
    } else if (history.length != 0) {
      history.removeLast();
    }
  }

  void undo() {
    if (history.length > 0 && gameOver == false && undoLeft > 0) {
      mergeList.clear();
      for (int i = 0; i < _currentGrid.length; i++) {
        for (int j = 0; j < _currentGrid[i].length; j++) {
          _currentGrid[i][j].value = history.last[i][j].value;
        }
      }
      _previousGrid = _currentGrid.map((e) => e.map((a) => IndividualCell.clone(a)).toList()).toList();
      resetCell();
      SharedPreferenceService.saveMatrix(_previousGrid);
      history.removeLast();
      undoLeft--;
      notifyListeners();
    }
  }
}
