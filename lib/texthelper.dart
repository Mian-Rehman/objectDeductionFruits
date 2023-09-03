import 'package:flutter/material.dart';
import 'dart:ui';

class TextHelper{

  TextStyle myTextStyle(double fontSize, var fontWeight, var Color) {
    return TextStyle(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: Color,
    );
  }


  Text mytext(String title, double fontSize, var fontWeight, var Color) {
    return Text(
      title,
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: Color,
      ),
    );
  }


  Container mInputFieldsWithIcon(
      var controller,
      String labelText,
      String hintText,
      String iconPath,
      double width,
      double height,
      double marginLeft,
      double marginright,
      double marginTop) {
    return Container(
      width: width,
      height: height,
      margin:
      EdgeInsets.only(left: marginLeft, right: marginright, top: marginTop),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
            labelText: labelText,
            hintText: hintText,
            prefixIcon:
            Container(width: 15, height: 15, child: Image.asset(iconPath)),
            prefixIconColor: Colors.black,
            hintStyle: const TextStyle(
              fontSize: 12,
            ),
            border:
            OutlineInputBorder(borderRadius: BorderRadius.circular(10.0))),
      ),
    );
  }

  Container mInputFieldsWithSuffix(
      var controller,
      String labelText,
      String hintText,
      String suffixPath,
      double width,
      double height,
      double marginLeft,
      double marginright,
      double marginTop,
      VoidCallback callback) {
    return Container(
      width: width,
      height: height,
      margin:
      EdgeInsets.only(left: marginLeft, right: marginright, top: marginTop),
      child: TextField(
        decoration: InputDecoration(
            labelText: labelText,
            hintText: hintText,
            suffixIcon: Container(
                width: 15,
                height: 15,
                child: IconButton(
                  onPressed: () {
                    return callback();
                  },
                  icon: Image.asset(suffixPath),
                )),
            suffixIconColor: Colors.black,
            hintStyle: const TextStyle(
              fontSize: 12,
            ),
            border:
            OutlineInputBorder(borderRadius: BorderRadius.circular(25.0))),
      ),
    );
  }

  Container mInputFields(
      var controller,
      String labelText,
      String hintText,
      double width,
      double height,
      double marginLeft,
      double marginright,
      double marginTop) {
    return Container(
      width: width,
      height: height,
      margin:
      EdgeInsets.only(left: marginLeft, right: marginright, top: marginTop),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
            labelText: labelText,
            hintText: hintText,
            hintStyle: const TextStyle(
              fontSize: 12,
            ),
            border:
            OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
            ),
        ),
      ),
    );
  }

  Row mutipleColorTextRow(String text1, var color1, double size1, String text2,
      var color2, double size2, VoidCallback onclick) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
            alignment: Alignment.topRight,
            margin: EdgeInsets.only(right: 5),
            child: TextHelper()
                .mytext(text1, size1, FontWeight.w900, color1)),
        InkWell(
          onTap: () {
            return onclick();
          },
          child: Container(
            child:
            TextHelper().mytext(text2, size2, FontWeight.w900, color2),
          ),
        )
      ],
    );
  }

}