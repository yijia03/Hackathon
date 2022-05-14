import 'package:flutter/material.dart';

class OvalTextButton extends StatelessWidget {
  final Function() onTap;
  final String text;
  final Color textColor; //text color
  final Color backgroundColor; //background color
  final Color borderColor; //border color
  final double elevation;
  final double height;
  final double width;
  final double fontSize;


  const OvalTextButton({
    Key? key,
    required this.onTap,
    required this.text,
    required this.textColor,
    required this.backgroundColor,
    required this.borderColor,
    required this.elevation,
    required this.height,
    required this.width,
    required this.fontSize
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      child: Text(
        text,
        style: TextStyle(
          fontSize: fontSize,
        ),
      ),
      style: TextButton.styleFrom(
        primary: textColor,
        backgroundColor: backgroundColor,
        side: BorderSide(color: borderColor, width: 1),
        elevation: elevation,
        minimumSize:
        Size(width, height),
        //shadowColor: Colors.grey,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25)),
      ),
      onPressed: onTap,
    );
  }
}
