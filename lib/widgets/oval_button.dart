import 'package:flutter/material.dart';

class OvalTextButton extends StatelessWidget {
  final Function() onTap;
  final String text;
  final Color primaryColor; //text color
  final Color backgroundColor; //background color
  final Color borderColor; //border color
  final double buttonSizeCoefficient;
  final double elevation;

  const OvalTextButton({
    Key? key,
    required this.buttonSizeCoefficient,
    required this.onTap,
    required this.text,
    required this.primaryColor,
    required this.backgroundColor,
    required this.borderColor,
    required this.elevation,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      child: Text(
        text,
        style: TextStyle(
          fontSize: 15 * buttonSizeCoefficient,
        ),
      ),
      style: TextButton.styleFrom(
        primary: primaryColor,
        backgroundColor: backgroundColor,
        side: BorderSide(color: borderColor, width: 1),
        elevation: elevation,
        minimumSize:
        Size(120 * buttonSizeCoefficient, 50 * buttonSizeCoefficient),
        //shadowColor: Colors.grey,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30 * buttonSizeCoefficient)),
      ),
      onPressed: onTap,
    );
  }
}
