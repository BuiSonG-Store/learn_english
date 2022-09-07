import 'package:flutter/material.dart';

class IndividualCell {
  IndividualCell({
    this.x = 0,
    this.y = 0,
    this.value = 0,
    isMerge = false,
    isLastest = false,
  });

  IndividualCell.clone(IndividualCell individualCell) : this(
    x: individualCell.x,
    y: individualCell.y,
    value: individualCell.value,
    isMerge: false,
    isLastest: false,
  );

  final int x;
  final int y;
  int value;
  bool isMerge = false;
  bool isLastest = false;

  factory IndividualCell.fromJson(Map<String, dynamic> jsonData){
    return IndividualCell(
      x: jsonData['x'] as int,
      y: jsonData['y'] as int,
      value: jsonData['value'] as int,
      isMerge: jsonData['isMerge'],
      isLastest: jsonData['isLatest'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "x": x,
      "y": y,
      "value": value,
      "isMerge": isMerge,
      "isLatest": isLastest,
    };
  }
}
