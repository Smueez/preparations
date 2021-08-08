import 'package:http/http.dart';
import 'dart:convert';

class PostResult{

  Future<Map> getData(Map<String, dynamic> bodyData) async{

    try{

      Response res = await post(
          Uri.parse('http://165.22.196.82:8080/api/v1/mcq-exam-result-post/'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(<String, String> {
            "student_full_name":bodyData['student_full_name'].toString(),
            "student_id":bodyData['student_id'].toString(),
            "model_test":bodyData['model_test'].toString(),
            "total_question_attended":bodyData['total_question_attended'].toString(),
            "total_right_answer":bodyData['total_right_answer'].toString(),
            "total_wrong_answer":bodyData['total_wrong_answer'].toString(),
            "total_negative_marks":bodyData['total_negative_marks'].toString(),
            "total_marks":bodyData['total_marks'].toString(),
            "pass_fail":bodyData['pass_fail'].toString(),
            "duration":bodyData['duration'].toString()
          })
      );
      Map data = await jsonDecode(res.body);

      return data;
    }
    catch (e){
      print('error: $e');
    }
    return {};
  }

}