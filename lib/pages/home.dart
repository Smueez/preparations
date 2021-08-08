import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        title: Text('প্রিপারেশন'),
        backgroundColor: Colors.orangeAccent,
      ),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: SizedBox(
              height: 150,
              child: Row(
                children: [
                  Expanded(
                    child: Card(

                      child: InkWell(
                        onTap: (){
                          Navigator.pushNamed(context,'/all_question');
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.6),
                            image: DecorationImage(
                                image: AssetImage(
                                    'assets/Question-Bank.png'
                                ),
                                fit: BoxFit.cover
                            ),
                            backgroundBlendMode: BlendMode.darken,
                          ),
                          child: Container(
                            color: Colors.black.withOpacity(0.6),
                            child: Center(

                              child: Text(
                                'প্রশ্ন ব্যাংক',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

                  Expanded(
                    child: Card(

                      child: InkWell(
                        onTap: (){
                          Navigator.pushNamed(context,'/model_test');
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.6),
                            image: DecorationImage(
                                image: AssetImage(
                                    'assets/model_test.jpg'
                                ),
                                fit: BoxFit.cover
                            ),
                            backgroundBlendMode: BlendMode.darken,
                          ),
                          child: Container(
                            color: Colors.black.withOpacity(0.6),
                            child: Center(

                              child: Text(
                                'মডেল টেস্ট',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

                ],
              ),
            ),
          ),
          SizedBox(
            height: 75,
            child: Card(
              child: InkWell(
                onTap: (){
                  Navigator.pushNamed(context,'/all_result',arguments: {
                    'student_id': 12345,
                  });
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.6),
                    image: DecorationImage(
                        image: AssetImage(
                            'assets/page.jpg'
                        ),
                        fit: BoxFit.cover
                    ),
                    backgroundBlendMode: BlendMode.darken,
                  ),
                  child: Container(
                    color: Colors.black.withOpacity(0.6),
                    child: Center(

                      child: Text(
                        'রেজাল্ট',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),

          ),
        ],
      ),
    );
  }
}
