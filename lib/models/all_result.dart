class AllResults {
  late int id;
  late String studentFullName;
  late String studentId;
  late int modelTest;
  late int totalQuestionAttended;
  late int totalRightAnswer;
  late int totalWrongAnswer;
  late double totalNegativeMarks;
  late double totalMarks;
  late int duration;
  late String passFail;

  AllResults(
      {required this.id,
        required this.studentFullName,
        required this.studentId,
        required this.modelTest,
        required this.totalQuestionAttended,
        required this.totalRightAnswer,
        required this.totalWrongAnswer,
        required this.totalNegativeMarks,
        required this.totalMarks,
        required this.duration,
        required this.passFail});

  AllResults.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    studentFullName = json['student_full_name'];
    studentId = json['student_id'];
    modelTest = json['model_test'];
    totalQuestionAttended = json['total_question_attended'];
    totalRightAnswer = json['total_right_answer'];
    totalWrongAnswer = json['total_wrong_answer'];
    totalNegativeMarks = json['total_negative_marks'];
    totalMarks = json['total_marks'];
    duration = json['duration'];
    passFail = json['pass_fail'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['student_full_name'] = this.studentFullName;
    data['student_id'] = this.studentId;
    data['model_test'] = this.modelTest;
    data['total_question_attended'] = this.totalQuestionAttended;
    data['total_right_answer'] = this.totalRightAnswer;
    data['total_wrong_answer'] = this.totalWrongAnswer;
    data['total_negative_marks'] = this.totalNegativeMarks;
    data['total_marks'] = this.totalMarks;
    data['duration'] = this.duration;
    data['pass_fail'] = this.passFail;
    return data;
  }
}