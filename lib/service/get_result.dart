import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'dart:convert';

import 'package:preparations/models/all_result.dart';

class GetResult{

  Future<List<AllResults>> getDataByModelTest(String studentId, String? modelTestId) async{

    try{

      Response res = await get(
          Uri.parse('http://165.22.196.82:8080/api/v1/mcq-exam-result-get/?model_test=$modelTestId&student_id=$studentId')
      );
      var data = await jsonDecode(res.body);
      print(data);
      List<AllResults> allResultList = [];
      data.forEach((val) {
        AllResults allResults = AllResults.fromJson(val);

        allResultList.add(allResults);
      });
      print(allResultList);
      return allResultList;
    }
    catch (e){
      print('error: $e');
    }
    return [];
  }
  Future<List<AllResults>> getDataByStudent(String studentId) async{

    try{

      Response res = await get(
          Uri.parse('http://165.22.196.82:8080/api/v1/mcq-exam-result-get/?student_id=$studentId')
      );
      List data = await jsonDecode(res.body);
      print(data);
      List<AllResults> allResultList = [];
      data.forEach((val) {
        AllResults allResults = AllResults.fromJson(val);

        allResultList.add(allResults);
      });
      print(allResultList);
      return allResultList;
    }
    catch (e){
      print('error: $e');
    }
    return [];
  }

}