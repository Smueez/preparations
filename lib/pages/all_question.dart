import 'package:flutter/material.dart';
import 'package:preparations/models/all_question.dart';
import 'package:preparations/service/all_question.dart';
import 'package:preparations/service/global.dart' as global;

class AllQuestionPage extends StatefulWidget {
  const AllQuestionPage({Key? key}) : super(key: key);

  @override
  _AllQuestionPageState createState() => _AllQuestionPageState();
}

class _AllQuestionPageState extends State<AllQuestionPage> {
  List<AllQuestionModelClass> data = [];
  bool isProcessFinished = false;

  void getDataFromAPI() async{

    try{
      AllQuestionRequestClass allQuestionRequestClass = new AllQuestionRequestClass();
      data = await allQuestionRequestClass.getData('');
      print(data[0].toJson());

      setState(() {
        print('data updated');
        data = data;
        isProcessFinished = true;
      });

    }catch(e){

    }
  }

  @override
  void initState() {
    super.initState();
    getDataFromAPI();
  }

  @override
  Widget build(BuildContext context) {

    double totalScreenHeight = MediaQuery. of(context).size.height;
    double appbarheight = global.defaultAppBar.preferredSize.height;
    double topHeight = MediaQuery.of(context).padding.top;
    return Scaffold(
      appBar: global.defaultAppBar,
      body: SingleChildScrollView(

        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            SizedBox(height: 20,),
            Container(
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Colors.orangeAccent,
                    width: 1
                  )
                )
              ),
              child: Center(
                child: Text(
                  'প্রশ্ন ব্যাংক',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25
                  ),
                ),
              ),
            ),
            SizedBox(height: 20,),
            isProcessFinished?
                data.length != 0?
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 0.0,horizontal: 6.0),
                    child: SizedBox(
                      height: (totalScreenHeight - (topHeight + appbarheight) - 65),
                      child: ListView.builder(
                        itemCount: data.length,
                        itemBuilder: (context, index){

                          Map<String, dynamic> quesData = data[index].toJson();
                          String correctAns = quesData['correct_answer'];
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
                                    groupValue: correctAns,
                                    onChanged: (val){

                                    },
                                  ),
                                  RadioListTile<String>(
                                    value: quesData['option_2'],
                                    title: Text(quesData['option_2']),
                                    groupValue: correctAns,
                                    onChanged: (val){

                                    },
                                  ),
                                  RadioListTile<String>(
                                    value: quesData['option_3'],
                                    title: Text(quesData['option_3']),
                                    groupValue: correctAns,
                                    onChanged: (val){

                                    },
                                  ),
                                  RadioListTile<String>(
                                    value: quesData['option_4'],
                                    title: Text(quesData['option_4']),
                                    groupValue: correctAns,
                                    onChanged: (val){

                                    },
                                  ),
                                  quesData['option_5'] != null?
                                  RadioListTile<String>(
                                    value: quesData['option_5'],
                                    title: Text(quesData['option_5']),
                                    groupValue: correctAns,
                                    onChanged: (val){

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
            Center(child: CircularProgressIndicator())
          ],
        ),
      ),
    );
  }
}
