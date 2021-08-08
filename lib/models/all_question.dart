import 'dart:convert' show utf8;
class AllQuestionModelClass{
  late int id;
  late String question;
  late String option1;
  late String option2;
  late String option3;
  late String option4;
  late String? option5;
  late String correctAnswer;

  AllQuestionModelClass(
      { required this.id,
        required this.question,
        required this.option1,
        required this.option2,
        required this.option3,
        required this.option4,
        required this.option5,
        required this.correctAnswer});

  AllQuestionModelClass.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    question = json['question'];
    option1 = json['option_1'];
    option2 = json['option_2'];
    option3 = json['option_3'];
    option4 = json['option_4'];
    option5 = json['option_5'];
    correctAnswer = json['correct_answer'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['question'] = this.question;
    data['option_1'] = this.option1;
    data['option_2'] = this.option2;
    data['option_3'] = this.option3;
    data['option_4'] = this.option4;
    data['option_5'] = this.option5;
    data['correct_answer'] = this.correctAnswer;
    return data;
  }
}