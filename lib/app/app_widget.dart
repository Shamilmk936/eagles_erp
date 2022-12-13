import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smile_erp/Login/login.dart';
import 'package:smile_erp/app/tabs/Branch/SelectBranches.dart';
import 'package:smile_erp/auth/firebase_user_provider.dart';

User currentUserModel;
String currentbranchId='';
String currentbranchName='';
String currentbranchAddress='';
String currentbranchShortName='';
String currentbranchphoneNumber='';
String currentbranchEmail='';
class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  double currentSize = 0;
  LeadzFirebaseUser initialUser;

  Stream<LeadzFirebaseUser> userStream;

  getData() async {
    final SharedPreferences userDatas= await SharedPreferences.getInstance();
    print(userDatas.getString('email'));
    currentUserUid=userDatas.getString('id');
    currentUserName=userDatas.getString('name');
    currentUserRole=userDatas.getString('role');
    currentUserEmail=userDatas.getString('userEmail');
    currentUserUserName=userDatas.getString('userName');

  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();

    userStream = leadzFirebaseUserStream()
      ..listen((user) => initialUser ?? setState(() => initialUser = user));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        backgroundColor: Colors.blueGrey[900],
        brightness: Brightness.light,
        canvasColor: Colors.transparent,
        // primarySwatch: Colors.blueGrey[900],
        fontFamily: "Montserrat",
      ),
      debugShowCheckedModeBanner: false,
      title: 'SMILE ERP',
      home:SplashScreen()

    );
  }
}



class SplashScreen extends StatefulWidget {
  const SplashScreen({Key key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    Timer(Duration(seconds: 2),(){
      if(currentUserUid!=null){
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>BranchesWidget()), (route) => false);
      }else{
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>LoginPageWidget()), (route) => false);
      }
    }

    );
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

    );
  }
}
