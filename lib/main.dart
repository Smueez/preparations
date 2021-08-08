import 'package:flutter/material.dart';
import 'package:preparations/pages/all_question.dart';
import 'package:preparations/pages/all_results.dart';
import 'package:preparations/pages/home.dart';
import 'package:preparations/pages/loading.dart';
import 'package:preparations/pages/model_test.dart';
import 'package:preparations/pages/results.dart';
import 'package:preparations/pages/test_page.dart';
void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/':(context) => LoadingPage(),
        '/home':(context) => HomePage(),
        '/all_question':(context) => AllQuestionPage(),
        '/model_test':(context) => ModelTestPage(),
        '/test':(context) => TestPage(),
        '/result':(context) => ResultPage(),
        '/all_result':(context) => AllResultPage()
      },

    )
  );
}

