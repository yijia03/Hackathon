import 'package:flutter/material.dart';

//welcome_screen
const kTitleTextStyle = TextStyle(
    fontFamily: 'Roboto',
    fontSize: 60.0,
    fontStyle: FontStyle.italic,
    color: Color(0xff77E1FF));
const kButtonTextColor = Colors.white;
const kButtonBorderColor = Colors.white;
const kStartButtonColor = Color(0xffA0E1FF);

//home_screen
const kBottomNavBarColor = Color(0xff77E1FF);
const kBottomNavBarTextColor = Colors.white;

//home_page
const kHeaderTextStyle = TextStyle(
    fontFamily: 'Roboto',
    fontSize: 35.0,
    color: Color(0xff77E1FF));
const kHomepageSetTextStyle = TextStyle(
    fontFamily: 'Roboto',
    fontSize: 20.0,
    color: Color(0xff77E1FF));

//settingsPage
const kDarkModeButtonTextStyle = TextStyle(
  fontFamily: 'Roboto',
  fontSize: 20,
  color: Color(0xff77E1FF)
);
var kBackgroundColor = Colors.white;
var kAddButtonStyle = ButtonStyle(
  padding: MaterialStateProperty.all(EdgeInsets.all(15)),
  shape: MaterialStateProperty.all(CircleBorder()),
  backgroundColor: MaterialStateProperty.all(Color(0xffA0E1FF)), // button color
  overlayColor: MaterialStateProperty.resolveWith<Color?>((states) {
    if (states.contains(MaterialState.pressed))
      return Color(0xff71EFF); // splash color
  }),
);

//editor_screen
const kSetTextStyle = TextStyle(
    fontFamily: 'Roboto',
    fontSize: 35.0,
    color: Color(0xff77E1FF));
const kTitleTextFieldHintStyle = TextStyle(
  fontFamily: 'Roboto',
  color: Color(0xffA0E1FF),
  fontSize: 15,
  fontStyle: FontStyle.normal,
);
const kTitleTextFieldTextStyle = TextStyle(
    fontFamily: 'Roboto',
    fontSize: 35,
    color: Color(0xff77E1FF),
);
const kTextFieldTextStyle = TextStyle(
  fontFamily: 'Roboto',
  fontSize: 20,
  color: Color(0xff77E1FF),
);
const kTextFieldHintStyle = TextStyle(
  fontFamily: 'Roboto',
  color: Color(0xffA0E1FF),
  fontSize: 15,
  fontStyle: FontStyle.normal,
);
var kSmallTextStyle = TextStyle(
  fontFamily: 'Roboto',
  color: (Colors.grey[400])!,
  fontSize: 10,
  fontStyle: FontStyle.normal,
);
const kAddButtonTextStyle = TextStyle(
  fontFamily: 'Roboto',
  color: Colors.white,
  fontSize: 20,
  fontStyle: FontStyle.normal,
);



