

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:object_detection/screen/dashboard_screen.dart';
import '../constants.dart';
import '../mycustombutton.dart';
import '../signup_screen.dart';
import '../texthelper.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

class UploadFruitsScreen extends StatefulWidget {
  const UploadFruitsScreen({Key? key}) : super(key: key);

  @override
  State<UploadFruitsScreen> createState() => _UploadFruitsScreenState();
}

class _UploadFruitsScreenState extends State<UploadFruitsScreen> {

  final ValueNotifier<bool> _obscurePassword = ValueNotifier<bool>(true);

  var fruitsNameController = TextEditingController();
  var fruitsPriceController = TextEditingController();
  var contactNumberController = TextEditingController();
  UploadTask? uploadTask;
  var fsdConColor = kBackgoundColor;
  var lhrConColor = Colors.white;
  var khrConColor = Colors.white;
  var selectedCity = "Faisalabad";



  File? _image;
  ImagePicker picker = ImagePicker();
  String? imageUrl;
  var urlDownload;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kBackgoundColor,
        title: Container(
            margin: const EdgeInsets.only(right: 30),
            child: const Center(child: Text("Upload Fruits"))),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          FloatingActionButton(
            heroTag: "Fltbtn2",
            child: Icon(Icons.camera_alt),
            onPressed: getImageFromCamera,
          ),
          SizedBox(width: 10,),
          FloatingActionButton(
            heroTag: "Fltbtn1",
            child: Icon(Icons.photo),
            onPressed: getImageFromGallery,
          ),
          SizedBox(width: 10,),

        ],
      ),
      body: SafeArea(
        child: Column(
          children: [

            Expanded(
                flex: 1,
                child: Container(
                  margin: EdgeInsets.only(top: 20),
                  child: Stack(
                    children: [
                      Align(
                        alignment: Alignment.topCenter,
                        child: TextHelper().mytext("Reads the fields very carefully before uploading fruits", 12, FontWeight.bold, kBackgoundColor
                        ),
                      ),

                    ],
                  ),
                )
            ),

            Expanded(
                flex: 9,
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    margin: EdgeInsets.only(top: 30),
                    child: Column(
                      children: [
                        
                        Container(
                          width: 100,
                          height: 100,
                          child: _image == null ? Image.asset("assets/upload.png") : Image.file(_image!),
                        ),
                        
                        TextHelper().mInputFields(fruitsNameController,
                            "Fruits Name", "Enter Fruits Name",
                            MediaQuery.of(context).size.width,
                            50.0, 30.0, 30.0, 10.0),

                        TextHelper().mInputFields(fruitsPriceController,
                            "Fruits Price", "Enter Fruits Price",
                            MediaQuery.of(context).size.width,
                            50.0, 30.0, 30.0, 10.0),

                        TextHelper().mInputFields(contactNumberController,
                            "Contact Number", "Enter Contact Number",
                            MediaQuery.of(context).size.width,
                            50.0, 30.0, 30.0, 10.0),


                        Row(
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
                        ),




                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Container(
                              height: 50,
                              margin: EdgeInsets.only(
                                  right: 30, left: 30, bottom: 20, top: 50),
                              width: MediaQuery.of(context).size.width,
                              child: RoundButton(
                                  textColor: Colors.white,
                                  backgroundColor: kBackgoundColor,
                                  borderColor: kBackgoundColor,
                                  text: "Save Fruits",
                                  shadowColor: Colors.black,
                                  onClick: () {
                                    uploadImage();
                                    showDialog(context: context,
                                      builder: (context){
                                        return Center(child: CircularProgressIndicator());
                                      },
                                    );
                                  },
                                  height: 50,
                                  width: MediaQuery.of(context).size.width,
                                  radius: 10)),
                        ),



                      ],
                    ),
                  ),
                )
            ),


          ],
        ),
      ),
    );
  }
  Future getImageFromCamera() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);

    setState(() {
      if(pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print("No image Selected");
      }
    });
    // runObjectDetection(_image!);
  }
  // gets image from gallery and runs detectObject
  Future getImageFromGallery() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      if(pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print("No image Selected");
      }
    });
    // runObjectDetection(_image!);
  }


  Future<void> uploadImage() async {

    String currentTimeMiles  = DateTime.now().millisecondsSinceEpoch.toString();

    final path = "files/$currentTimeMiles";
    final file = File(_image!.path);


    final ref = FirebaseStorage.instance.ref().child(path);
    uploadTask = ref.putFile(file);
    final snapShot = await uploadTask!.whenComplete(() {

    });

    final urlDownload = await snapShot.ref.getDownloadURL();

    saveRealTimeData(urlDownload.toString());
  }

  void saveRealTimeData(urlDownload) async{

    String? id = FirebaseFirestore.instance.collection("fruits").doc().id.toString();

    FirebaseFirestore.instance.collection("fruits")
        .doc(id)
        .set({
      "fruitImage":urlDownload,
      "fruitName":fruitsNameController.text.toString(),
      "fruitPrice":fruitsPriceController.text.toString(),
      "contactNumber":contactNumberController.text.toString(),
      "cityName":selectedCity.toString().toLowerCase(),
      "fruitID":id.toString(),

    }).whenComplete(() {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Food save completed"),
      ));
     Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> DashBoardScreen()));
    });

  }
}
