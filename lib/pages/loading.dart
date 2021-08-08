import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter/material.dart';
import 'package:connectivity/connectivity.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:preparations/pages/home.dart';

class LoadingPage extends StatefulWidget {
  const LoadingPage({Key? key}) : super(key: key);

  @override
  _LoadingPageState createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {

  void checkConnectivity() async{
    try {
      var connectivityResult = await (Connectivity().checkConnectivity());
      if (connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi) {
        Navigator.pushAndRemoveUntil(context,MaterialPageRoute(builder: (context) => HomePage()),(Route<dynamic> route) => false,);
      }
      else {
        Fluttertoast.showToast(
          msg: "Please turn on internet connection!",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 3,
        );
        checkConnectivity();
      }
    }catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();

    checkConnectivity();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SpinKitFadingCube(
            color: Colors.orangeAccent,
            size: 50.0,
            duration: const Duration(milliseconds: 1200),
          )
      ),
    );
  }
}
