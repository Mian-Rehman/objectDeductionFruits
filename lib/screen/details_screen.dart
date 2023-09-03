
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:object_detection/constants.dart';

class FruistDetailsScreen extends StatelessWidget {
  
  var imageUrl,name,price,contatc,cityName;
   // FruistDetailsScreen({Key? key,this.imageUrl}) : super(key: key);

  FruistDetailsScreen(
      this.imageUrl,
      this.name,
      this.price,
      this.contatc,
      this.cityName,
      );
 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Fruits Details"),
      ),
      body: Column(
        children: [
          Container(
            width: MediaQuery.sizeOf(context).width,
            height: 300,
            child: Image.network(imageUrl,fit: BoxFit.fitWidth,),
          ),

          Container(
            margin: EdgeInsets.only(top: 10),
            padding: EdgeInsets.all(10),
            width: MediaQuery.sizeOf(context).width,
            child: Text(name,style: TextStyle(fontSize: 21,color: kBackgoundColor,fontWeight: FontWeight.bold),),
          ),

          Container(
            padding: EdgeInsets.all(10),
            width: MediaQuery.sizeOf(context).width,
            child: Text("PKR $price",style: TextStyle(fontSize: 16,color: kBackgoundColor,fontWeight: FontWeight.bold),),
          ),
          Container(
            padding: EdgeInsets.all(10),
            width: MediaQuery.sizeOf(context).width,
            child: Text("Contact: $contatc",style: TextStyle(fontSize: 16,color: kBackgoundColor,fontWeight: FontWeight.bold),),
          ),
          Container(
            padding: EdgeInsets.all(10),
            width: MediaQuery.sizeOf(context).width,
            child: Text("City: $cityName",style: TextStyle(fontSize: 16,color: kBackgoundColor,fontWeight: FontWeight.bold),),
          )
        ],
      ),
    );
  }
}
