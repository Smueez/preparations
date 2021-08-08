import 'package:http/http.dart';
import 'dart:convert';

import 'package:preparations/models/model_test.dart';
class ModelTestRequestClass {

  Future<List<ModelTestModelClass>> getData() async{
    try{
      Response res = await get(Uri.parse('http://165.22.196.82:8080/api/v1/mcq-model-test/'));
      var data = jsonDecode(res.body);

      List<ModelTestModelClass> modelTestList = [];
      print(data);
      data.forEach((val) {
        ModelTestModelClass modelTestModelClass = ModelTestModelClass.fromJson(val);

        modelTestList.add(modelTestModelClass);
      });

      return modelTestList;
    }
    catch (e){
      print('error: $e');
    }
    return [];
  }

}