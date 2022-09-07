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
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    if (this.questions != null) {
      data['questions'] = this.questions!.map((v) => v.toJson()).toList();
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
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['question'] = this.question;
    data['exercise_id'] = this.exerciseId;
    if (this.answers != null) {
      data['answers'] = this.answers!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Answers {
  String? answerKey;
  String? answerValue;
  bool? correctAnswer;
  int? questionId;

  Answers({this.answerKey, this.answerValue, this.correctAnswer, this.questionId});

  Answers.fromJson(Map<String, dynamic> json) {
    answerKey = json['answer_key'];
    answerValue = json['answer_value'];
    correctAnswer = json['correct_answer'];
    questionId = json['question_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['answer_key'] = this.answerKey;
    data['answer_value'] = this.answerValue;
    data['correct_answer'] = this.correctAnswer;
    data['question_id'] = this.questionId;
    return data;
  }
}
