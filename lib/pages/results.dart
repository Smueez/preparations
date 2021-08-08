import 'package:flutter/material.dart';
import 'package:preparations/service/post_result.dart';
import 'package:preparations/service/global.dart' as global;

class ResultPage extends StatefulWidget {
  const ResultPage({Key? key}) : super(key: key);

  @override
  _ResultPageState createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {

  Map<String, dynamic> resultData = {};
  Map data = {};
  bool isProcessFinished = false;
  void getDataFromAPI() async{

    try{

      PostResult postResult = new PostResult();
      data = await postResult.getData(resultData);
      print(data);

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
    return Scaffold(
      appBar: global.defaultAppBar,
      body: isProcessFinished?
          Center(
            child: ListView(
              shrinkWrap: true,
              children: [
                data['pass_fail'] == 'P'?
                    Center(
                      child: Text(
                        'P',
                        style: TextStyle(
                          fontSize: 120,
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
                            fontSize: 120,
                            fontWeight: FontWeight.bold,
                            color: Colors.red
                        ),
                      ),
                    ),
                Center(
                  child: Text(
                    'Name: ${data['student_full_name']}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
                Center(
                  child: Text(
                    'Student Id: ${data['student_id']}'
                  ),
                ),
                Center(
                  child: Text(
                      'Total Marks: ${data['total_marks']}'
                  ),
                ),
                Center(
                  child: ElevatedButton(
                    onPressed: (){
                      Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
                    },
                    child: Text('Go Back to Home Page'),
                  ),
                )
              ],
            ),
          )
          :
      Center(child: CircularProgressIndicator())
      );

  }
}
