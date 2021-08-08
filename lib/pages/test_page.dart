import 'dart:async';

import 'package:flutter/material.dart';
import 'package:preparations/models/all_question.dart';
import 'package:preparations/service/all_question.dart';
import 'package:preparations/service/global.dart' as global;
import 'package:fluttertoast/fluttertoast.dart';

class TestPage extends StatefulWidget {
  const TestPage({Key? key}) : super(key: key);

  @override
  _TestPageState createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {

  Map modelTestData = {};
  List<AllQuestionModelClass> data = [];
  bool isProcessFinished = false;
  int hour = 0;
  int min = 0;
  int sec = 0;
  late Timer timer;
  Color clockColor = Colors.green;
  List<String> ansCheckList = [];
  List<String?> selectedValues = [];
  bool isNotStarted = true;
  void getDataFromAPI() async{

    try{

      print(modelTestData);
      AllQuestionRequestClass allQuestionRequestClass = new AllQuestionRequestClass();
      data = await allQuestionRequestClass.getData('?model_test=${modelTestData['id']}');
      print(data[0].toJson());

      setState(() {
        print('data updated');
        data = data;
        isProcessFinished = true;
      });
      ansCheckListBuilder(data.length);
    }catch(e){
      print('error $e');
    }
  }

  void timerCountDown(int examTimeInSec){
    var oneSec = Duration(seconds: 1);
    timer = new Timer.periodic(
        oneSec,
        (timer) {
          if(examTimeInSec == 0){
            Fluttertoast.showToast(
              msg: "Time's up!",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
            );
            timer.cancel();
            submitExamResult();
          }
          else {
            examTimeInSec--;
            getExamTime(examTimeInSec);
          }
          if(examTimeInSec <= modelTestData['exam_time']~/4){
            clockColor = Colors.red;
          }
        }
      );
  }

  void getExamTime(int examTimeInSec){
    setState(() {
      hour = examTimeInSec~/36000;
      min = examTimeInSec~/60;
      sec = examTimeInSec%60;
    });
  }

  void ansCheckListBuilder(int length){
    for(int i = 0 ; i < length; i++){
      selectedValues.add('');
      ansCheckList.add('n');
    }
  }

  void submitExamResult(){
    int correct = 0, incorrect = 0, totalAns = 0;
    ansCheckList.forEach((element) {
      if(element == 'y'){
        correct++;
        totalAns++;
      }
      else if(element == 'w'){
        incorrect++;
        totalAns++;
      }
    });
    double totalMarks = (correct.toDouble() - (incorrect.toDouble()/modelTestData['negative_marks']));
    String result =
      totalMarks <= modelTestData['pass_marks']? 'F' : 'P';
    Fluttertoast.showToast(
      msg: "Model Test is submitted.",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
    );
    Navigator.pushReplacementNamed(context,'/result',arguments: {
      'student_full_name': 'Mueez',
      'student_id': 12345,
      'model_test' : modelTestData['id'],
      'total_question_attended' : totalAns,
      'total_right_answer' : correct,
      'total_wrong_answer' : incorrect,
      'total_negative_marks' : (modelTestData['negative_marks'] * incorrect.toDouble()),
      'total_marks': totalMarks,
      'pass_fail': result,
      'duration':modelTestData['exam_time']
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    modelTestData = ModalRoute.of(context)!.settings.arguments as Map;
    getDataFromAPI();
    getExamTime(modelTestData['exam_time']);
  }

  @override
  void dispose() {
    super.dispose();
    timer.cancel();
  }
  @override
  Widget build(BuildContext context) {
    double totalScreenHeight = MediaQuery. of(context).size.height;
    double appbarheight = global.defaultAppBar.preferredSize.height;
    double topHeight = MediaQuery.of(context).padding.top;
    return Scaffold(
      appBar: global.defaultAppBar,
      body:Stack(
        children: [
          SingleChildScrollView(

            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                SizedBox(height: 10,),
                Container(
                  height: 60,
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                              color: Colors.orangeAccent,
                              width: 1
                          )
                      )
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        flex:3,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Center(
                              child: Text(
                                modelTestData['title'],
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Center(
                              child: Text(
                                'Pass Mark: ${modelTestData['pass_marks']}',
                              ),
                            ),
                            Center(
                              child: Text(
                                'Neg. Mark: ${modelTestData['negative_marks']}',
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Center(
                          child: Text(
                            '$hour : $min : $sec',
                            style: TextStyle(
                              color: clockColor,
                              fontSize: 20,
                              fontWeight: FontWeight.bold
                            ),
                          ),
                        )
                      )
                    ],
                  ),
                ),
                isProcessFinished?
                data.length != 0?
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 0.0,horizontal: 6.0),
                  child: SizedBox(
                    height: (totalScreenHeight - (topHeight + appbarheight) - 120),
                    child: ListView.builder(
                        itemCount: data.length,
                        itemBuilder: (context, index){

                          Map<String, dynamic> quesData = data[index].toJson();
                          String correctAns = quesData['correct_answer'];
                          //String selectedVal = quesData['option_4'];
                          return Card(
                            child: ListTile(
                              title: Text(
                                  quesData['question'],
                                  style: TextStyle(fontWeight: FontWeight.bold)
                              ),
                              subtitle: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  RadioListTile<String>(
                                    value: quesData['option_1'],
                                    title: Text(quesData['option_1']),
                                    groupValue: selectedValues[index],
                                    onChanged: (val){
                                      setState(() {
                                        selectedValues[index] = val;
                                        print(val);
                                        print(selectedValues[index]);
                                        if(val == correctAns){
                                          ansCheckList[index] = 'y';
                                        }
                                        else {
                                          ansCheckList[index] = 'w';
                                        }
                                      });
                                    },
                                  ),
                                  RadioListTile<String>(
                                    value: quesData['option_2'],
                                    title: Text(quesData['option_2']),
                                    groupValue: selectedValues[index],
                                    onChanged: (val){
                                      setState(() {
                                        selectedValues[index] = val;

                                        if(val == correctAns){
                                          ansCheckList[index] = 'y';
                                        }
                                        else {
                                          ansCheckList[index] = 'w';
                                        }
                                      });
                                    },
                                  ),
                                  RadioListTile<String>(
                                    value: quesData['option_3'],
                                    title: Text(quesData['option_3']),
                                    groupValue: selectedValues[index],
                                    onChanged: (val){
                                      setState(() {
                                        selectedValues[index] = val;

                                        if(val == correctAns){
                                          ansCheckList[index] = 'y';
                                        }
                                        else {
                                          ansCheckList[index] = 'w';
                                        }
                                      });
                                    },
                                  ),
                                  RadioListTile<String>(
                                    value: quesData['option_4'],
                                    title: Text(quesData['option_4']),
                                    groupValue: selectedValues[index],
                                    //selected: true,
                                    onChanged: (val){
                                      setState(() {
                                        selectedValues[index] = val;

                                        if(val == correctAns){
                                          ansCheckList[index] = 'y';
                                        }
                                        else {
                                          ansCheckList[index] = 'w';
                                        }
                                      });

                                    },
                                  ),
                                  quesData['option_5'] != null?
                                  RadioListTile<String>(
                                    value: quesData['option_5'],
                                    title: Text(quesData['option_5']),
                                    groupValue: selectedValues[index],
                                    onChanged: (val){
                                      setState(() {
                                        selectedValues[index] = val!;

                                        if(val == correctAns){
                                          ansCheckList[index] = 'y';
                                        }
                                        else {
                                          ansCheckList[index] = 'w';
                                        }
                                      });
                                    },
                                  ) : SizedBox(height: 0,),

                                ],
                              ),
                            ),
                          );
                        }
                    ),
                  ),
                )
                    :
                Center(child: Text('No Data!'),)

                    :
                Center(child: CircularProgressIndicator()),
                SizedBox(
                  height: 50,
                  width: double.infinity,
                  child: ElevatedButton(

                    style: ElevatedButton.styleFrom(
                      primary: Colors.green,
                    ),

                    onPressed: submitExamResult,
                    child: Text(
                      'Submit',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          Visibility(
            visible: isNotStarted,
            child: Positioned(
              left: 0,
              right: 0,
              top: 0,
              bottom: 0,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.8),
                  backgroundBlendMode: BlendMode.darken,
                ),
                child: Center(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.green
                    ),
                    onPressed: (){
                      setState(() {
                        isNotStarted = false;
                      });
                      timerCountDown(modelTestData['exam_time']);
                    },
                    child: Text('Start'),
                  ),
                ),
              )
            ),
          )
        ],
      ),
    );
  }
}
