import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:object_detection/login_screen.dart';
import 'package:object_detection/texthelper.dart';

import 'constants.dart';
import 'customprimarycolor.dart';
import 'mycustombutton.dart';

class SignUpScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _SignupScreenState();

}

class _SignupScreenState extends State<SignUpScreen>{

  var usernameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneNumberController = TextEditingController();
  var passwordController = TextEditingController();

  FirebaseFirestore firestoredatabase = FirebaseFirestore.instance;
  FirebaseAuth mAuth = FirebaseAuth.instance;

  final ValueNotifier<bool> _obscurePassword = ValueNotifier<bool>(true);

  var username,email,phoneNumber,password;
  String? currentDate = "", currentTime = "";


  bool? isChecked = false;


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: ListView(
        children: [
          Container(
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

                            TextHelper().mInputFields(usernameController,
                                "Username", "Username",
                                MediaQuery.of(context).size.width,
                                50.0, 30.0, 30.0, 10.0),

                            Container(
                              width: MediaQuery.of(context).size.width,
                              height: 50,
                              margin:
                              EdgeInsets.only(left: 30, right: 30, top: 10),
                              child: TextField(
                                controller: emailController,
                                decoration: InputDecoration(
                                  labelText: "Email",
                                  hintText: "Email",
                                  hintStyle: const TextStyle(
                                    fontSize: 12,
                                  ),
                                  border:
                                  OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                ),
                              ),
                            ),


                            TextHelper().mInputFields(phoneNumberController,
                                "Phone Number", "Phone Number",
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
                                      text: "Create Account",
                                      shadowColor: Colors.black,

                                      onClick: () {

                                        username = usernameController.text.toString();
                                        email = emailController.text.toString();
                                        phoneNumber = phoneNumberController.text.toString();
                                        password = passwordController.text.toString();

                                        if(isChecked!)
                                        {
                                          craeteUserAccountWithEmailPassword(email,password);
                                        }else{
                                          ScaffoldMessenger.of(context).showSnackBar(
                                              SnackBar(content: Text("Please accept Privacy policy"))
                                          );
                                        }


                                        // saveAccountData();
                                        // _sendOTP();

                                      },
                                      height: 50,
                                      width: MediaQuery.of(context).size.width,
                                      radius: 10)),
                            ),

                            TextHelper().mutipleColorTextRow(
                                "Already have an account?",
                                Colors.black,
                                14,
                                'Login',
                                kBackgoundColor,
                                14, (() {
                              //click event
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => LoginScreen(),
                                  ));
                            })),

                            // privacy >>
                            Container(
                              width: MediaQuery.of(context).size.width,
                              margin: EdgeInsets.only(left: 30, right: 30, top: 5),
                              child: Row(
                                children: [
                                  Checkbox(
                                      value: isChecked,
                                      activeColor: kBackgoundColor,
                                      tristate: true,
                                      onChanged: (newBol) {
                                        setState(() {
                                          isChecked = newBol!;
                                        });
                                      }),
                                  const Text.rich(
                                    TextSpan(
                                      children: [
                                        TextSpan(
                                          text: 'By continuing you accept our',
                                          style: TextStyle(
                                            color: Color(0xFF7B6F72),
                                            fontSize: 12,
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        TextSpan(
                                          text: ' ',
                                          style: TextStyle(
                                            color: Color(0xFFACA3A5),
                                            fontSize: 12,
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        TextSpan(
                                          text: 'Privacy Policy',
                                          style: TextStyle(
                                            color: kBackgoundColor,
                                            fontSize: 12,
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        TextSpan(
                                          text: ' ',
                                          style: TextStyle(
                                            color: kBackgoundColor,
                                            fontSize: 12,
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        TextSpan(
                                          text: 'and \n',
                                          style: TextStyle(
                                            color: kBackgoundColor,
                                            fontSize: 12,
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        TextSpan(
                                          text: 'Term of Use',
                                          style: TextStyle(
                                            color: kBackgoundColor,
                                            fontSize: 12,
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),

                          ],
                        ),
                      ),
                    )
                ),


              ],
            ),
          ),
        ],

      ),
    );
  }


  void craeteUserAccountWithEmailPassword(String? email, String? password) async{

    showDialog(context: context,
      builder: (context){
        return Center(child: CircularProgressIndicator());
      },
    );

    await mAuth.createUserWithEmailAndPassword(

        email: emailController.text.toString(), password: passwordController.text.toString())
        .then((value) {

      saveAccountData();

    }).onError((error, stackTrace) {
      print("Database Login Error");
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Password min lenth is 8 charachter of use different password")));
    });

  }

  void saveAccountData() async{



    try{
      await mAuth.currentUser!.sendEmailVerification();
    } on FirebaseException catch(e){
      // final ex = TExceptions.fr
    }


    final User? user = mAuth.currentUser;
    final uid = user?.uid;

    await firestoredatabase
        .collection("users")
        .doc(uid)
        .set({
      "userUID": uid,
      "username": username,
      "email": email,
      "phoneNumber": phoneNumber,
      "password": password,
      "accountStatus": "pending",

    }).whenComplete(() {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => LoginScreen(),
          ));

    });
  }


}