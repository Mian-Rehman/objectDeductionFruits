import 'package:flutter/material.dart';

class RoundButton extends StatelessWidget {
  final Color textColor;
  final Color backgroundColor;
  final Color borderColor;
  Color? shadowColor;
  final String text;
  final VoidCallback onClick;
  IconData? iconData;
  double height;
  double width;
  double radius;
  bool isIcon;

  RoundButton(
      {Key? key,
      required this.text,
      required this.textColor,
      required this.backgroundColor,
      required this.borderColor,
      this.shadowColor,
      this.iconData,
      required this.height,
      required this.width,
      required this.radius,
      required this.onClick,
      this.isIcon = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return InkWell(
      onTap: () {
        return onClick();
      },
      child: Container(
        child: Center(
            child: Text(
          text,
          style: TextStyle(color: textColor),
        )),
        decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(radius),
            border: Border.all(
              color: borderColor,
              width: 1.0,
            )),
      ),
    );
  }
}
