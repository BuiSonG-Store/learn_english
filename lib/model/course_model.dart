class CourseModel {
  List<ListCourse>? content;
  Pageable? pageable;
  int? totalPages;
  int? totalElements;
  bool? last;
  bool? first;
  Sort? sort;
  int? numberOfElements;
  int? size;
  int? number;
  bool? empty;

  CourseModel.fromJson(Map<String, dynamic> json) {
    if (json['content'] != null) {
      content = <ListCourse>[];
      json['content'].forEach((v) {
        content!.add(ListCourse.fromJson(v));
      });
    }
    pageable = json['pageable'] != null ? Pageable.fromJson(json['pageable']) : null;
    totalPages = json['totalPages'];
    totalElements = json['totalElements'];
    last = json['last'];
    first = json['first'];
    sort = json['sort'] != null ? Sort.fromJson(json['sort']) : null;
    numberOfElements = json['numberOfElements'];
    size = json['size'];
    number = json['number'];
    empty = json['empty'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (content != null) {
      data['content'] = content!.map((v) => v.toJson()).toList();
    }
    if (pageable != null) {
      data['pageable'] = pageable!.toJson();
    }
    data['totalPages'] = totalPages;
    data['totalElements'] = totalElements;
    data['last'] = last;
    data['first'] = first;
    if (sort != null) {
      data['sort'] = sort!.toJson();
    }
    data['numberOfElements'] = numberOfElements;
    data['size'] = size;
    data['number'] = number;
    data['empty'] = empty;
    return data;
  }
}

class ListCourse {
  int? id;
  String? title;
  String? detail;
  String? image;
  int? participantAge;
  double? qualification;
  int? numberOfParticipants;
  double? percentageComplete;
  List<Exercises>? exercises;

  ListCourse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    detail = json['detail'];
    image = json['image'];
    participantAge = json['participantAge'];
    qualification = json['qualification'];
    numberOfParticipants = json['number_of_participants'];
    percentageComplete = double.parse(json['percentageComplete'].toString());
    if (json['exercises'] != null) {
      exercises = <Exercises>[];
      json['exercises'].forEach((v) {
        exercises!.add(Exercises.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['detail'] = detail;
    data['image'] = image;
    data['participantAge'] = participantAge;
    data['qualification'] = qualification;
    data['number_of_participants'] = numberOfParticipants;
    data['percentageComplete'] = percentageComplete;
    if (exercises != null) {
      data['exercises'] = exercises!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Exercises {
  String? name;
  String? description;
  int? courseId;
  List<Questions>? questions;

  Exercises.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    description = json['description'];
    courseId = json['course_id'];
    if (json['questions'] != null) {
      questions = <Questions>[];
      json['questions'].forEach((v) {
        questions!.add(Questions.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['description'] = description;
    data['course_id'] = courseId;
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
  Questions(this.question, this.exerciseId, this.answers);
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
  Answers(this.answerKey, this.answerValue, this.correctAnswer, this.questionId);
  Answers.fromJson(Map<String, dynamic> json) {
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

class Pageable {
  Sort? sort;
  int? pageNumber;
  int? pageSize;
  int? offset;
  bool? paged;
  bool? unpaged;

  Pageable.fromJson(Map<String, dynamic> json) {
    sort = json['sort'] != null ? Sort.fromJson(json['sort']) : null;
    pageNumber = json['pageNumber'];
    pageSize = json['pageSize'];
    offset = json['offset'];
    paged = json['paged'];
    unpaged = json['unpaged'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (sort != null) {
      data['sort'] = sort!.toJson();
    }
    data['pageNumber'] = pageNumber;
    data['pageSize'] = pageSize;
    data['offset'] = offset;
    data['paged'] = paged;
    data['unpaged'] = unpaged;
    return data;
  }
}

class Sort {
  bool? sorted;
  bool? unsorted;
  bool? empty;

  Sort.fromJson(Map<String, dynamic> json) {
    sorted = json['sorted'];
    unsorted = json['unsorted'];
    empty = json['empty'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['sorted'] = sorted;
    data['unsorted'] = unsorted;
    data['empty'] = empty;
    return data;
  }
}
