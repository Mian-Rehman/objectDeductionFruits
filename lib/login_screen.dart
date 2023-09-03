import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:object_detection/HomeScreen.dart';
import 'package:object_detection/constants.dart';
import 'package:object_detection/screen/dashboard_screen.dart';
import 'package:object_detection/signup_screen.dart';
import 'package:object_detection/texthelper.dart';


import 'mycustombutton.dart';

class LoginScreen extends StatefulWidget{

  static String userUID = "";

  static String userEmail = "";

  @override
  State<StatefulWidget> createState() => _LoginScreenState();

}

class _LoginScreenState extends State<LoginScreen>{

  var emailController = TextEditingController();
  var passwordController = TextEditingController();


  FirebaseAuth mAuth = FirebaseAuth.instance;
  FirebaseFirestore firestoredatabase = FirebaseFirestore.instance;

  bool emailVerified = false;
  final ValueNotifier<bool> _obscurePassword = ValueNotifier<bool>(true);



  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return Scaffold(
      body: SafeArea(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: Colors.white,
          child: Column(
            children: <Widget>[
              Expanded(
                  flex: 1,
                  child: Container(
                    margin: EdgeInsets.only(top: 20),
                    child: Stack(
                      children: [
                        Align(
                          alignment: Alignment.topCenter,
                          child: TextHelper().mytext("Object Detection", 24, FontWeight.bold, kBackgoundColor
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
                          TextHelper().mInputFields(emailController,
                              "Email", "Email",
                              MediaQuery.of(context).size.width,
                              50.0, 30.0, 30.0, 10.0),

                          Container(
                            width: MediaQuery.of(context).size.width,
                            height: 50,
                            margin: const EdgeInsets.only(left: 30, right: 30, top: 10),
                            child: ValueListenableBuilder(
                                valueListenable: _obscurePassword,
                                builder: (context,value,child){
                                  return TextFormField(
                                    controller: passwordController,
                                    //   focusNode: passwordFocusNode,
                                    obscureText: _obscurePassword.value, obscuringCharacter: '*',
                                    validator: (value){
                                      if(value!.isEmpty){
                                        return 'Please enter your password';
                                      }
                                      return null;
                                    },
                                    decoration:   InputDecoration(
                                      suffixIcon: InkWell(
                                          onTap: (){
                                            _obscurePassword.value = !_obscurePassword.value;
                                          } ,
                                          child: Icon(_obscurePassword.value?
                                          Icons.visibility_off
                                              : Icons.visibility)),
                                      label: const Text('Password'),
                                      hintStyle: const TextStyle(fontSize: 12),
                                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
                                      fillColor: Colors.black,
                                    ),
                                    cursorColor: Colors.black,
                                  );
                                }),
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
                                    text: "Login",
                                    shadowColor: Colors.black,
                                    onClick: () {
                                      print("clicked");
                                      loginWithEmail();
                                    },
                                    height: 50,
                                    width: MediaQuery.of(context).size.width,
                                    radius: 10)),
                          ),

                          TextHelper().mutipleColorTextRow(
                              "Don’t you have an Account?",
                              Colors.black,
                              14,
                              'Sign Up',
                              kBackgoundColor,
                              14, (() {
                            //click event
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SignUpScreen(),
                                ));
                          })),

                        ],
                      ),
                    ),
                  )
              ),


            ],
          ),
        ),
      ),
    );
  }

  void loginWithEmail() async{

    showDialog(context: context,
      builder: (context){
        return Center(child: CircularProgressIndicator());
      },
    );


    await mAuth.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text
    ).whenComplete(() {

      if(mAuth.currentUser!.emailVerified)
      {
        // Navigator.push(
        //     context,
        //     MaterialPageRoute(
        //       builder: (context) => DashBoardScreen(),
        //     ));
      }else{
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => DashBoardScreen(),
            ));
      }


    });
  }



}