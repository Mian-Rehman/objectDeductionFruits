import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:object_detection/HomeScreen.dart';
import 'package:object_detection/login_screen.dart';
import 'package:object_detection/screen/fruit_list_screen.dart';
import 'package:object_detection/screen/my_fruit_list.dart';
import 'package:object_detection/screen/upload_fruits_screen.dart';

import '../constants.dart';


class DashBoardScreen extends StatefulWidget {
  const DashBoardScreen({Key? key}) : super(key: key);

  @override
  State<DashBoardScreen> createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {



  @override
  Widget build(BuildContext context) {
    var MATCH_PARENT = MediaQuery.sizeOf(context).width;
   return Scaffold(
     appBar: AppBar(
       leading: IconButton(icon: Icon(Icons.logout),
       onPressed: (){
        FirebaseAuth.instance.signOut();
        Navigator.pushReplacement(context, MaterialPageRoute(builder:
        (context)=> LoginScreen()));
       },
       ),
       backgroundColor: kBackgoundColor,
       title: Container(
           margin: const EdgeInsets.only(right: 30),
           child: const Center(child: Text("Dashboard"))),
     ),
    body: Column(
      children: <Widget>[

        SizedBox(
        width: MATCH_PARENT,
        height: 180,
          child: Card(
              elevation: 10,
              child: Image.asset("assets/fruits_images.jpeg",fit: BoxFit.fitWidth,)),
        ),

        // double menu with card
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
                flex: 2,
                child: InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>UploadFruitsScreen()));
                  },
                  child: Card(
                  elevation: 10,
                  child: Container(
                    height: 100,
                    padding: EdgeInsets.all(10),
                    color: kBackgoundColor,
                    child: Column(
                      children: [
                       Container(
                         width: 50,
                         height: 50,
                         child: Image.asset("assets/upload.png"),
                       ),

                        Container(
                          margin: EdgeInsets.only(top: 5),
                          child: Text("Upload Fruits",style: TextStyle(
                              fontSize: 16,
                              color: Colors.white
                          )
                          ),
                        )
                      ],
                    ),
                  ),
                  ),
                )
            ),

            Expanded(
                flex: 2,
                child: Card(
                  elevation: 10,
                  child: InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>FruitListScreen()));
                    },
                    child: Container(
                      height: 100,
                      padding: EdgeInsets.all(10),
                      color: kBackgoundColor,
                      child: Column(
                        children: [
                          SizedBox(
                            width: 50,
                            height: 50,
                            child: Image.asset("assets/fruit_image.png"),
                          ),

                          Container(
                            margin: EdgeInsets.only(top: 5),
                            child: Text("Fruits Shop",style: TextStyle(
                                fontSize: 16,
                                color: Colors.white
                            )
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                )
            ),
          ],
        ),

        // single menu with card
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
                flex: 2,
                child: InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> MyFruitListScreen()));
                  },
                  child: Card(
                    elevation: 10,
                    child: Container(
                      height: 100,
                      padding: EdgeInsets.all(10),
                      color: kBackgoundColor,
                      child: Column(
                        children: [
                          Container(
                            width: 50,
                            height: 50,
                            child: Image.asset("assets/analyze_food.webp"),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 5),
                            child: Text("My Fruits",style: TextStyle(
                              fontSize: 16,
                              color: Colors.white
                            ),),
                          )
                        ],
                      ),
                    ),
                  ),
                )
            ),

            Expanded(
                flex: 2,
                child: InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> HomeScreen()));
                  },
                  child: Card(
                    elevation: 10,
                    child: Container(
                      height: 100,
                      padding: EdgeInsets.all(10),
                      color: kBackgoundColor,
                      child: Column(
                        children: [
                          Container(
                            width: 50,
                            height: 50,
                            child: Image.asset("assets/analyze_food.webp"),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 5),
                            child: Text("Analyze Fruits",style: TextStyle(
                                fontSize: 16,
                                color: Colors.white
                            ),),
                          )
                        ],
                      ),
                    ),
                  ),
                )
            ),

          ],
        )



      ],
    ),
   );
  }
}
