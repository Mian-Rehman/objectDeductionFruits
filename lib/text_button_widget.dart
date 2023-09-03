
import 'package:flutter/material.dart';
import '../constants.dart';


class TextButtonWidget extends StatelessWidget {
  TextButtonWidget({
    Key? key,
    this.bgColor=kBlueColor,
    this.textColor=kWhiteColor,
    this.iconColor=kWhiteColor,
    this.textSize=16,
    this.borderRadius=5,
    this.isIcon=false,
    this.iconData=Icons.search,
    this.iconSize=22,
    this.text="Login",
    required this.onPress,
    this.borderColor=kBlueColor,
  }) : super(key: key);

  Color bgColor;
  Color textColor;
  Color iconColor;
  Color borderColor;
  double borderRadius;
  double textSize;
  bool isIcon;
  IconData iconData;
  double iconSize;
  String text;
  VoidCallback onPress;

  @override
  Widget build(BuildContext context) {
    var size=MediaQuery.of(context).size;
    return InkWell(
      onTap: onPress,
      child: Container(
        height: 50,
        // width: size.width * 0.33,
        padding: EdgeInsets.only(left: isIcon==true ? 0 :10,right: 10,top: 10,bottom: 10),
        decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(borderRadius),
            border: Border.all(color:borderColor ,width: 1)
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            isIcon==true ? Padding(
              padding:  EdgeInsets.only(right: 10.0),
              child: Icon(iconData,color: iconColor,),
            ) : SizedBox(),
            Text("$text",style: TextStyle(
                color: textColor,
                fontSize: textSize,
                fontWeight: FontWeight.bold
            )),
          ],
        ),
      ),
    );
  }
}