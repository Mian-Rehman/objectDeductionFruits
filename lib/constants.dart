import 'dart:ui';

import 'package:flutter/material.dart';

const Color kWhiteColor=Colors.white;
const Color kBlackColor=Colors.black;
Color kLightBlackColor=Color(0xFF929292);
const Color kyellowColor=Colors.yellow;
const Color kBlueColor=Colors.blue;
const Color kGreenColor= Colors.green;
const Color kOrangeColor= Color(0xfff0750f);
const Color kRedColor= Colors.red;
const Color kBackgoundColor=Color(0xFF1C6F94);
const Color kInActiveCardColor=Color(0xFF9BAEBC70);
const Color kActiveCardColor=Color(0xFF64A9D170);

Text largerText(String text,{Color color=kWhiteColor,double size=32,FontWeight fontWeight=FontWeight.w600,TextOverflow textOverflow=TextOverflow.ellipsis }){
  return Text(text,style: TextStyle(color: color,fontSize: size,fontWeight: fontWeight,),overflow: textOverflow,maxLines: 100,);
}
Text mediumText(String text,{Color color=kWhiteColor,double size=18,FontWeight fontWeight=FontWeight.w600,TextDecoration textDecoration=TextDecoration.none,TextOverflow textOverflow=TextOverflow.ellipsis,int maxLines=100,bool softWrap=false}){
  return Text(text,style: TextStyle(color: color,fontSize: size,fontWeight: fontWeight,decoration: textDecoration,decorationColor: kOrangeColor),overflow: textOverflow,maxLines: maxLines,softWrap: softWrap,);
}
Text smallText(String text,{Color color=kWhiteColor,double size=14,FontWeight fontWeight=FontWeight.w600,TextOverflow textOverflow=TextOverflow.ellipsis}){
  return Text(text,style: TextStyle(color: color,fontSize: size,fontWeight: fontWeight),overflow: textOverflow,);
}
Text textWithoutLines(String text,{Color color=kWhiteColor,double size=18,FontWeight fontWeight=FontWeight.w600}){
  return Text(text,style: TextStyle(color: color,fontSize: size,fontWeight: fontWeight));
}
Text mediumTextWithFont(String text,{Color color=kWhiteColor,double size=18,FontWeight fontWeight=FontWeight.w600,TextDecoration textDecoration=TextDecoration.none,String fontFamily="Raleway-VariableFont_wght",TextOverflow textOverflow=TextOverflow.ellipsis,int maxLines=1,bool softWrap=false}){
  return Text(text,style: TextStyle(color: color,fontSize: size,fontWeight: fontWeight,decoration: textDecoration,decorationColor: kOrangeColor,fontFamily: fontFamily),overflow: textOverflow,maxLines: maxLines,softWrap: softWrap,);
}


void showSnackbar(BuildContext context,String text,Color color) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(text),
      duration: Duration(seconds: 3),
      backgroundColor: color,
    ),
  );
}