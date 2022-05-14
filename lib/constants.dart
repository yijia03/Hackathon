import 'package:flutter/material.dart';

//welcome_screen
const kTitleTextStyle = TextStyle(
    fontFamily: 'Roboto',
    fontSize: 60.0,
    fontStyle: FontStyle.italic,
    color: Color(0xffA0E1FF));
const kButtonTextColor = Colors.white;
const kButtonBorderColor = Colors.white;
const kStartButtonColor = Color(0xffA0E1FF);

//home_screen
const kBottomNavBarColor = Color(0xffA0E1FF);
const kBottomNavBarTextColor = Colors.white;

//home_page
const kHeaderTextStyle = TextStyle(
    fontFamily: 'Roboto',
    fontSize: 50.0,
    color: Color(0xffA0E1FF));
var kAddButtonStyle = ButtonStyle(
  padding: MaterialStateProperty.all(EdgeInsets.all(15)),
  shape: MaterialStateProperty.all(CircleBorder()),
  backgroundColor: MaterialStateProperty.all(Color(0xffA0E1FF)), // button color
  overlayColor: MaterialStateProperty.resolveWith<Color?>((states) {
    if (states.contains(MaterialState.pressed))
      return Color(0xff71EFF); // splash color
  }),
);

