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

  static String utf8convert(String? text) {
    if(text == null){
      return '';
    }
    List<int> bytes = text.toString().codeUnits;
    return utf8.decode(bytes);
  }
  AllQuestionModelClass.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    question = utf8convert(json['question']);
    option1 =  utf8convert(json['option_1']);
    option2 =  utf8convert(json['option_2']);
    option3 =  utf8convert(json['option_3']);
    option4 =  utf8convert(json['option_4']);
    option5 =  utf8convert(json['option_5']);
    correctAnswer =  utf8convert(json['correct_answer']);
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