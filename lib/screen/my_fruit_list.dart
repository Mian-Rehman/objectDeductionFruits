import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:object_detection/screen/details_screen.dart';

import '../constants.dart';

class MyFruitListScreen extends StatefulWidget {
  const MyFruitListScreen({Key? key}) : super(key: key);

  @override
  State<MyFruitListScreen> createState() => _FruitListScreenState();
}

class _FruitListScreenState extends State<MyFruitListScreen> {

  var fsdConColor = kBackgoundColor;
  var lhrConColor = Colors.white;
  var khrConColor = Colors.white;
  var selectedCity = "Faisalabad";

  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
   return Scaffold(
     appBar: AppBar(
       backgroundColor: kBackgoundColor,
       title: Container(
           margin: const EdgeInsets.only(right: 30),
           child: const Center(child: Text("My Fruits"))),
     ),
     body:  Column(
       children: [
        Expanded(
          flex: 1,
          child:  Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [

            InkWell(
              onTap: (){
                setState(() {
                  fsdConColor = kBackgoundColor;
                  lhrConColor = Colors.white;
                  khrConColor = Colors.white;
                  selectedCity = "Faisalabad";
                });
              },
              child: Container(
                  margin: EdgeInsets.only(top: 10),
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: fsdConColor,
                      borderRadius: BorderRadius.circular(10)
                  ),
                  child: Text("Faisalabad")
              ),
            ),

            InkWell(
              onTap: (){
                setState(() {
                  fsdConColor = Colors.white;
                  lhrConColor = kBackgoundColor;
                  khrConColor = Colors.white;
                  selectedCity = "Lahore";
                });
              },
              child: Container(
                  margin: EdgeInsets.only(top: 10,left: 5),
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: lhrConColor,
                      borderRadius: BorderRadius.circular(10)
                  ),
                  child: Text("Lahore")
              ),
            ),

            InkWell(
              onTap: (){
                setState(() {
                  fsdConColor = Colors.white;
                  lhrConColor = Colors.white;
                  khrConColor = kBackgoundColor;
                  selectedCity = "Karachi";
                });
              },
              child: Container(
                  margin: EdgeInsets.only(top: 10,left: 5),
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: khrConColor,
                      borderRadius: BorderRadius.circular(10)
                  ),
                  child: Text("Karachi")
              ),
            )

          ],
        ),),

       Expanded(
           flex: 9,
           child: Visibility(
         visible: true,
         child: Container(
             height: MediaQuery.sizeOf(context).height,
             padding: EdgeInsets.all(10.0),
             child: StreamBuilder<QuerySnapshot>(
                 stream: FirebaseFirestore.instance
                     .collection('fruits')
                      .where("cityName",isEqualTo: selectedCity.toLowerCase())
                      .where("fruitStatus",isEqualTo:"active")
                      .where("userUID",isEqualTo: auth.currentUser!.uid.toString())
                     .snapshots(),
                 builder: (context, snapshots) {
                   return (snapshots.connectionState ==
                       ConnectionState.waiting)
                       ? Center()
                       : ListView.builder(
                       itemCount:
                       snapshots.data!.docs.length,
                       itemBuilder: (context, index) {
                         var data = snapshots
                             .data!.docs[index]
                             .data()
                         as Map<String, dynamic>;
                         return Container(
                           margin: EdgeInsets.all(5),
                           decoration: const BoxDecoration(
                             color: kBackgoundColor,
                             borderRadius: BorderRadius.all(Radius.circular(10)),
                           ),
                           child:  Container(
                             decoration: BoxDecoration(
                               borderRadius: BorderRadius.circular(10),
                               color: kBackgoundColor,
                             ),
                             child: Row(
                               mainAxisAlignment: MainAxisAlignment.start,
                               crossAxisAlignment: CrossAxisAlignment.start,
                               children: [
                                 Container(
                                   width: 100,
                                   child: Image.network('${data['fruitImage']}',fit: BoxFit.fill,
                                     width: 100,height: 100,),
                                 ),
                                 Container(
                                   padding: EdgeInsets.all(10),
                                   child: Column(
                                     mainAxisAlignment: MainAxisAlignment.start,
                                     crossAxisAlignment: CrossAxisAlignment.start,
                                     children: [
                                       Text(
                                         "${data['fruitName']}",
                                         maxLines: 1,
                                         overflow: TextOverflow.ellipsis,
                                         style: TextStyle(
                                           color: Colors.white,
                                           fontSize: 20,
                                           fontWeight: FontWeight.bold,
                                         ),
                                       ),

                                       SizedBox(height: 10,),
                                       Text(
                                         "PKR: ${data['fruitPrice']}",
                                         maxLines: 1,
                                         overflow: TextOverflow.ellipsis,
                                         style: TextStyle(
                                           color: Colors.white,
                                           fontSize: 14,
                                           fontWeight: FontWeight.w500,
                                         ),
                                       ),

                                       SizedBox(height: 10,),
                                       Text(
                                         "Contact: ${data['contactNumber']}",
                                         maxLines: 1,
                                         overflow: TextOverflow.ellipsis,
                                         style: TextStyle(
                                           color: Colors.white,
                                           fontSize: 14,
                                           fontWeight: FontWeight.w500,
                                         ),
                                       ),

                                       SizedBox(height: 10,),
                                       Text(
                                         "City: ${data['cityName']}",
                                         maxLines: 1,
                                         overflow: TextOverflow.ellipsis,
                                         style: TextStyle(
                                           color: Colors.white,
                                           fontSize: 14,
                                           fontWeight: FontWeight.w500,
                                         ),
                                       ),

                                       SizedBox(height: 10,),
                                       Row(
                                         children: [
                                           ElevatedButton(onPressed: (){
                                             Navigator.push(context,
                                                 MaterialPageRoute(builder: (context)=>FruistDetailsScreen(
                                                   "${data['fruitImage']}",
                                                   "${data['fruitName']}",
                                                   "${data['fruitPrice']}",
                                                   "${data['contactNumber']}",
                                                   "${data['cityName']}",
                                                 )
                                                 )
                                             );


                                           }, child: Text("Open Details")
                                           ),

                                           SizedBox(width: 5,),

                                           ElevatedButton(onPressed: (){
                                             deleteFruits(data['fruitID']);
                                           }, child: Text("Delete")
                                           ),
                                         ],
                                       )
                                     ],
                                   ),
                                 ),
                                 SizedBox(
                                   width: 30,
                                 ),

                               ],
                             ),
                           ),
                         );
                       });
                 })),
       ))
       ],
     ),

   );
  }

  void deleteFruits(data) {

    FirebaseFirestore.instance.collection("fruits")
        .doc(data)
        .update({
        "fruitStatus":"delete"
    }).whenComplete(() {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Food Delete completed"),
      ));
    });

  }
}
