import 'package:flutter/material.dart';
import 'package:preparations/models/model_test.dart';
import 'package:preparations/service/global.dart' as global;
import 'package:preparations/service/model_test.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:intl/intl.dart';
class ModelTestPage extends StatefulWidget {
  const ModelTestPage({Key? key}) : super(key: key);

  @override
  _ModelTestPageState createState() => _ModelTestPageState();
}

class _ModelTestPageState extends State<ModelTestPage> {
  List<ModelTestModelClass> data = [];
  bool isProcessFinished = false;
  List<Widget> modelTestItem = [];

  void getDataFromAPI() async{

    try{
      ModelTestRequestClass modelTestRequestClass = new ModelTestRequestClass();
      data = await modelTestRequestClass.getData();
      print(data[0].toJson());

      modelTestItemBuilder(data);
    }catch(e){
      setState(() {
        print('error $e');
        isProcessFinished = true;
      });
    }
  }
  void modelTestItemBuilder(List<ModelTestModelClass> dataList){
    print('other method');
    print(dataList);
    dataList.forEach((element) {
      Map modelData = element.toJson();
      print(modelData);
      DateTime examStartDate = DateTime.parse(modelData['exam_start_date_time'].replaceAll('+06:00',''));
      DateTime examEndDate = DateTime.parse(modelData['exam_end_date_time'].replaceAll('+06:00',''));
      DateTime resultStartDate = DateTime.parse(modelData['exam_result_date_time'].replaceAll('+06:00',''));
      DateTime resultEndDate = DateTime.parse(modelData['exam_result_end_date_time'].replaceAll('+06:00',''));
      DateTime now = DateTime.now();
      String examTime = '${DateFormat.jm().format(DateFormat("hh:mm:ss").parse("${examStartDate.hour}:${examStartDate.minute}:00"))} (BD time) on ${examStartDate.day}/${examStartDate.month}/${examStartDate.year}';
      print(examStartDate.isBefore(now));
      print(examEndDate.isAfter(now));
      print(now);
      modelTestItem.add(
        Card(
          child: SizedBox(
            height: 300,
            child: Column(
              children: [
                SizedBox(
                  height: 250,
                  child: Stack(
                    children: [
                      CachedNetworkImage(
                        placeholder: (context, url) => Image.asset('assets/placeholder.jpg'),
                        imageUrl: modelData['cover_image'],
                        errorWidget: (context, url, error) => Image.asset('assets/placeholder.jpg'),
                        fit: BoxFit.fitHeight,
                        height: 250,
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        left: 0,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.7),
                            backgroundBlendMode: BlendMode.darken,
                          ),
                          child: Column(
                            children: [
                              Text(
                                modelData['title'],
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white
                                ),
                              ),
                              Text(
                                modelData['short_description'],
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white
                                ),
                              ),
                              Text(
                                examTime,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                examStartDate.isAfter(now)?
                  SizedBox(
                    height: 50,
                    width: double.infinity,
                    child: ElevatedButton(

                      style: ElevatedButton.styleFrom(
                        primary: Colors.blueAccent,
                      ),

                      onPressed: (){
                        /// TO DO: nothing
                      },
                      child: Text(
                        'Upcoming',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white
                        ),
                      ),
                    ),
                  )
                :
                  (examStartDate.isAtSameMomentAs(now) || (examEndDate.isAfter(now) && examStartDate.isBefore(now)))?
                    SizedBox(
                      height: 50,
                      width: double.infinity,
                      child: ElevatedButton(

                        style: ElevatedButton.styleFrom(
                            primary: Colors.greenAccent
                        ),

                        onPressed: (){
                          /// TO DO: go to model test page
                          Navigator.pushNamed(context,'/test',arguments: {
                            'id' : modelData['id'],
                            'title' : modelData['title'],
                            'negative_marks' : modelData['negative_marks'],
                            'exam_time' : modelData['exam_time'],
                            'pass_marks' : modelData['pass_marks']
                          });
                        },
                        child: Text(
                          'Take Test',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white
                          ),
                        ),
                      ),
                    )
                  :
                  (resultStartDate.isBefore(now) && resultEndDate.isAfter(now))?
                        SizedBox(
                          height: 50,
                          width: double.infinity,
                          child: ElevatedButton(

                            style: ElevatedButton.styleFrom(
                                primary: Colors.amber
                            ),

                            onPressed: (){

                              Navigator.pushNamed(context,'/all_result',arguments: {
                                'student_id': 12345,
                                'model_test_id':  modelData['id']
                              });
                            },
                            child: Text(
                              'See Results',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white
                              ),
                            ),
                          ),
                        )
                    :
                        SizedBox(
                          height: 50,
                          width: double.infinity,
                          child: ElevatedButton(

                            style: ElevatedButton.styleFrom(
                                primary: Colors.red
                            ),

                            onPressed: (){
                              /// TO DO: do nothing

                            },
                            child: Text(
                              'Archived',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white
                              ),
                            ),
                          ),
                        )
              ],
            ),
          ),
        )
      );
    });
    setState(() {
      modelTestItem = modelTestItem;
      isProcessFinished = true;
    });
  }
  @override
  void initState() {
    super.initState();
    getDataFromAPI();
    DateTime dt = DateTime.parse('2021-08-11T18:18:47+06:00');
    DateTime now = DateTime.now();
    print(dt.isAfter(now));
    print(dt.isBefore(now));
    print(dt.isAtSameMomentAs(now));
    print(now);// 2020-01-02 03:04:05.000

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
                  'মডেল টেস্ট',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25
                  ),
                ),
              ),
            ),
            SizedBox(height: 20,),
            isProcessFinished?
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 0.0,horizontal: 6.0),
                child: SizedBox(
                  height: (totalScreenHeight - (topHeight + appbarheight) - 65),
                  child: ListView.builder(
                      itemCount: modelTestItem.length,
                      itemBuilder: (context,index){
                        return modelTestItem[index];
                      }

                  ),
                ),
              )
            :
              Center(child: CircularProgressIndicator())
          ],
        ),
      )
    );
  }
}
