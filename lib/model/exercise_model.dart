
class Questions {
  String? question;
  List<Answers>? answers;


  Questions.fromJson(Map<String, dynamic> json) {
    question = json['question'];
    if (json['answers'] != null) {
      answers = <Answers>[];
      json['answers'].forEach((v) {
        answers!.add(Answers.fromJson(v));
      });
    }
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
