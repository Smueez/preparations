import 'package:flutter/material.dart';
import 'package:preparations/models/all_result.dart';
import 'package:preparations/service/get_result.dart';
import 'package:preparations/service/global.dart' as global;

class AllResultPage extends StatefulWidget {
  const AllResultPage({Key? key}) : super(key: key);

  @override
  _AllResultPageState createState() => _AllResultPageState();
}

class _AllResultPageState extends State<AllResultPage> {

  Map<String, dynamic> resultData = {};
  List<AllResults> data = [];
  bool isProcessFinished = false;
  void getDataFromAPI() async{

    try{
      print('all page');
      GetResult getResult = new GetResult();
      if(resultData['model_test_id'] == null){
        data = await getResult.getDataByStudent(resultData['student_id'].toString());
      }
      else {
        data = await getResult.getDataByModelTest(resultData['student_id'].toString(), resultData['model_test_id'].toString());
      }

      print('data: ${data.length}');

      setState(() {
        data = data;
        isProcessFinished = true;
      });
    }catch(e){
      print('error $e');
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    resultData = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    getDataFromAPI();
  }
  @override
  Widget build(BuildContext context) {


    double totalScreenHeight = MediaQuery. of(context).size.height;
    double appbarheight = global.defaultAppBar.preferredSize.height;
    double topHeight = MediaQuery.of(context).padding.top;
    return Scaffold(
        appBar: global.defaultAppBar,
        body: isProcessFinished?
            SingleChildScrollView(
              child: Column(
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
                        'রেজাল্ট সমূহ',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 25
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10,),
                  data.length != 0?
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5,horizontal: 10),
                    child: SizedBox(
                      height: (totalScreenHeight - (topHeight + appbarheight) - 65),
                      child: ListView.builder(
                          itemCount: data.length,
                          itemBuilder: (context, index){
                            Map resultDataByIndex = data[index].toJson();
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 3,horizontal: 0),
                              child: Card(
                                child: ListTile(
                                  onTap: (){
                                    Navigator.pushNamed(context,'/result',arguments: {
                                      'student_full_name': 'Mueez',
                                      'student_id': 12345,
                                      'model_test' : resultDataByIndex['id'],
                                      'total_question_attended' : resultDataByIndex['total_question_attended'],
                                      'total_right_answer' : resultDataByIndex['total_right_answer'],
                                      'total_wrong_answer' : resultDataByIndex['total_wrong_answer'],
                                      'total_negative_marks' : resultDataByIndex['total_negative_marks'],
                                      'total_marks': resultDataByIndex['total_marks'],
                                      'pass_fail': resultDataByIndex['pass_fail'],
                                      'duration': resultDataByIndex['duration']
                                    });
                                  },
                                  title: resultDataByIndex['pass_fail'] == 'P'?
                                  Center(
                                    child: Text(
                                      'P',
                                      style: TextStyle(
                                          fontSize: 50,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.green
                                      ),
                                    ),
                                  )
                                      :
                                  Center(
                                    child: Text(
                                      'F',
                                      style: TextStyle(
                                          fontSize: 50,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.red
                                      ),
                                    ),
                                  ),
                                  subtitle: Column(
                                    children: [
                                      Center(
                                        child: Text(
                                          'Name: ${resultDataByIndex['student_full_name']}',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20,
                                          ),
                                        ),
                                      ),
                                      Center(
                                        child: Text(
                                            'Student Id: ${resultDataByIndex['student_id']}'
                                        ),
                                      ),
                                      Center(
                                        child: Text(
                                            'Total Marks: ${resultDataByIndex['total_marks']}'
                                        ),
                                      ),

                                    ],
                                  ),
                                ),
                              ),
                            );
                          }
                      ),
                    ),
                  )
                  :
                      Center(child: Text('Nothing to show!'),)
                ],
              ),
            )

            :
        Center(child: CircularProgressIndicator())
    );

  }
}
