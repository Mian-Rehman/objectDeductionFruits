import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:object_detection/HomeScreen.dart';
import 'package:object_detection/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {


  move() async{
    Timer(Duration(seconds: 3),() {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
    },);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
   move();
  }
  @override
  Widget build(BuildContext context) {
    var size=MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/bg.png",),
              fit: BoxFit.fill
            )
          ),
          child: Container(
            padding: EdgeInsets.only(top: 20,left: 10,right: 10),
            decoration: BoxDecoration(
              color: Colors.white,
                image: DecorationImage(
                    image: AssetImage("assets/bg.png",),
                    fit: BoxFit.cover
                )
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Container(
                          padding: EdgeInsets.only(top: 15,bottom: 15),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20)
                          ),
                          child: Text("Grading Method For Fruit Freshness Based On Deep Learning",
                            style: TextStyle(
                            fontSize:25,
                            fontWeight:
                              FontWeight.bold,
                              color: Colors.black,
                          ),
                          textAlign: TextAlign.center,
                          ),
                        ),
                      )
                    ],
                  ),
                  Container(
                    child: CircularProgressIndicator(
                      color: Colors.black,
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
