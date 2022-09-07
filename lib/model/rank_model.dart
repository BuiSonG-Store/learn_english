class RankModel {
  List<Top10User>? top10User;
  Top10User? currentUserScore;

  RankModel({this.top10User, this.currentUserScore});

  RankModel.fromJson(Map<String, dynamic> json) {
    if (json['top10User'] != null) {
      top10User = <Top10User>[];
      json['top10User'].forEach((v) {
        top10User!.add(Top10User.fromJson(v));
      });
    }
    currentUserScore = json['currentUserScore'] != null ? Top10User.fromJson(json['currentUserScore']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (top10User != null) {
      data['top10User'] = top10User!.map((v) => v.toJson()).toList();
    }
    if (currentUserScore != null) {
      data['currentUserScore'] = currentUserScore!.toJson();
    }
    return data;
  }
}

class Top10User {
  String? name;
  double? score;

  Top10User({this.name, this.score});

  Top10User.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    score = json['score'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['score'] = score;
    return data;
  }
}
