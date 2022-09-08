class ExerciseModel {
  int? id;
  String? name;
  String? description;
  List<Questions>? questions;

  ExerciseModel({this.id, this.name, this.description, this.questions});

  ExerciseModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    if (json['questions'] != null) {
      questions = <Questions>[];
      json['questions'].forEach((v) {
        questions!.add(Questions.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['name'] = name;
    data['description'] = description;
    if (questions != null) {
      data['questions'] = questions!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Questions {
  String? question;
  int? exerciseId;
  List<Answers>? answers;

  Questions({this.question, this.exerciseId, this.answers});

  Questions.fromJson(Map<String, dynamic> json) {
    question = json['question'];
    exerciseId = json['exercise_id'];
    if (json['answers'] != null) {
      answers = <Answers>[];
      json['answers'].forEach((v) {
        answers!.add(Answers.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['question'] = question;
    data['exercise_id'] = exerciseId;
    if (answers != null) {
      data['answers'] = answers!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Answers {
  String? answerKey;
  String? answerValue;
  bool? correctAnswer;
  int? questionId;
  bool? isSelected;

  Answers({this.answerKey, this.answerValue, this.correctAnswer, this.questionId, this.isSelected = false});

  Answers.fromJson(Map<String, dynamic> json) {
    isSelected = false;
    answerKey = json['answer_key'];
    answerValue = json['answer_value'];
    correctAnswer = json['correct_answer'];
    questionId = json['question_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['answer_key'] = answerKey;
    data['answer_value'] = answerValue;
    data['correct_answer'] = correctAnswer;
    data['question_id'] = questionId;
    return data;
  }
}
