import 'package:http/http.dart';
import 'dart:convert';

import 'package:preparations/models/all_question.dart';
class AllQuestionRequestClass{

  Future<List<AllQuestionModelClass>> getData(String? modelTestID) async{

    try{
      print(modelTestID);
      Response res = await get(Uri.parse('http://165.22.196.82:8080/api/v1/question-bank/$modelTestID'));
      List data = await jsonDecode(res.body);

      List<AllQuestionModelClass> allQuesList = [];
      print(data);
      data.forEach((val) {
        AllQuestionModelClass allQuesModelClass = AllQuestionModelClass.fromJson(val);

        allQuesList.add(allQuesModelClass);
      });

      return allQuesList;
    }
    catch (e){
      print('error: $e');
    }
    return [];
  }

}