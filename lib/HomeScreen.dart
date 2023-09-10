import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/services.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_pytorch/pigeon.dart';
import 'package:flutter_pytorch/flutter_pytorch.dart';
import 'package:object_detection/LoaderState.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late ModelObjectDetection _objectModel;
  String? _imagePrediction;
  List? _prediction;
  File? _image;
  ImagePicker picker = ImagePicker();
  bool objectDetection = false;
  List<ResultObjectDetection?> objDetect = [];
  bool firststate = false;
  bool message = true;
  String? score;
  String? className,classIndex,rect;
  @override
  void initState() {
    super.initState();
    loadModel();
  }

  Future loadModel() async {
    String pathObjectDetectionModel = "assets/models/best.torchscript";
    try {
      _objectModel = await FlutterPytorch.loadObjectDetectionModel(
          pathObjectDetectionModel, 7, 640, 640,
          labelPath: "assets/labels/fruits_label.txt");
    } catch (e) {
      if (e is PlatformException) {
        print("only supported for android, Error is $e");
      } else {
        print("Error is $e");
      }
    }
  }

  void handleTimeout() {
    // callback function
    // Do some work.
    setState(() {
      firststate = true;
    });
  }

  Timer scheduleTimeout([int milliseconds = 10000]) =>
      Timer(Duration(milliseconds: milliseconds), handleTimeout);
  //running detections on image
  Future runObjectDetection(var img) async {
    setState(() {
      firststate = false;
      message = false;
    });
    //pick an image
    // final XFile? image = await picker.pickImage(source: ImageSource.camera);
    objDetect = await _objectModel.getImagePrediction(
        await File(img!.path).readAsBytes(),
        minimumScore: 0.5,
        IOUThershold: 0.3);
    objDetect.forEach((element) {

     score =  element?.score.toString();
      className =  element?.className.toString();
      classIndex =  element?.classIndex.toString();
      rect =  element?.rect.toString();
      print({
        "score": element?.score,
        "className": element?.className,
        "class": element?.classIndex,
        "rect": {
          "left": element?.rect.left,
          "top": element?.rect.top,
          "width": element?.rect.width,
          "height": element?.rect.height,
          "right": element?.rect.right,
          "bottom": element?.rect.bottom,
        },
      });
    });
    scheduleTimeout(5 * 1000);
    setState(() {
      _image = File(img.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Fruit Detection"),centerTitle: true,),
      backgroundColor: Colors.white,
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
          Visibility(
            visible: _imagePrediction != null,
            child: FloatingActionButton(
              heroTag: "Fltbtn1",
              child: Icon(Icons.upload),
              onPressed: getImageFromGallery,
            ),
          ),
        ],
      ),
      body: InkWell(
        onTap: (){
          print("$score");
        },
        child: Column(
          children: [

            Container(
              margin: EdgeInsets.all(10),
              child: Text("Result: ${className.toString()} \n Score: ${score.toString()}",style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black
              ),),
            ),

            Container(
              width: MediaQuery.sizeOf(context).width,
              height: 600,
              padding: EdgeInsets.all(10),
              child: Center(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //Image with Detections....



                  !firststate
                      ? !message ? LoaderState() : Text("Select Image")
                      : Expanded(
                          child: Container(
                              child:
                                  _objectModel.renderBoxesOnImage(_image!, objDetect,)),
                        ),

                  // !firststate
                  //     ? LoaderState()
                  //     : Expanded(
                  //         child: Container(
                  //             height: 150,
                  //             width: 300,
                  //             child: objDetect.isEmpty
                  //                 ? Text("hello")
                  //                 : _objectModel.renderBoxesOnImage(
                  //                     _image!, objDetect)),
                  //       ),
                  Center(
                    child: Visibility(
                      visible: _imagePrediction != null,
                      child: InkWell(
                        onTap: (){
                          print("click");
                        },
                        child: Container(
                            padding: EdgeInsets.all(10),
                            child: InkWell(
                                onTap: (){
                                  print("Click");
                                },
                                child: Text("$_imagePrediction"))
                        ),
                      ),
                    ),
                  ),
                  //Button to click pic
                  // ElevatedButton(
                  //   onPressed: () {
                  //     // runObjectDetection();
                  //   },
                  //   child: const Icon(Icons.camera),
                  // )
                ],
              )),
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
    runObjectDetection(_image!);
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
    runObjectDetection(_image!);
  }
}
