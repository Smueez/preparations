import 'dart:convert' show utf8;
class ModelTestModelClass {
  late int id;
  late String title;
  late String shortDescription;
  late String examStartDateTime;
  late String examEndDateTime;
  late String examResultDateTime;
  late String examResultEndDateTime;
  late String coverImage;
  late double negativeMarks;
  late String subscription;
  late int examTime;
  late double passMarks;
  late String status;

  ModelTestModelClass(
      {required this.id,
        required this.title,
        required this.shortDescription,
        required this.examStartDateTime,
        required this.examEndDateTime,
        required this.examResultDateTime,
        required this.examResultEndDateTime,
        required this.coverImage,
        required this.negativeMarks,
        required this.subscription,
        required this.examTime,
        required this.passMarks,
        required this.status});

  static String utf8convert(String text) {
    List<int> bytes = text.toString().codeUnits;
    return utf8.decode(bytes);
  }
  ModelTestModelClass.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    shortDescription = utf8convert(json['short_description']);
    examStartDateTime = json['exam_start_date_time'];
    examEndDateTime = json['exam_end_date_time'];
    examResultDateTime = json['exam_result_date_time'];
    examResultEndDateTime = json['exam_result_end_date_time'];
    coverImage = json['cover_image'];
    negativeMarks = json['negative_marks'];
    subscription = json['subscription'];
    examTime = json['exam_time'];
    passMarks = json['pass_marks'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['short_description'] = this.shortDescription;
    data['exam_start_date_time'] = this.examStartDateTime;
    data['exam_end_date_time'] = this.examEndDateTime;
    data['exam_result_date_time'] = this.examResultDateTime;
    data['exam_result_end_date_time'] = this.examResultEndDateTime;
    data['cover_image'] = this.coverImage;
    data['negative_marks'] = this.negativeMarks;
    data['subscription'] = this.subscription;
    data['exam_time'] = this.examTime;
    data['pass_marks'] = this.passMarks;
    data['status'] = this.status;
    return data;
  }
}