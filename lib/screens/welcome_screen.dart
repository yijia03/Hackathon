import 'package:flutter/material.dart';
import 'package:papyrus/constants.dart';
import 'package:papyrus/screens/home_screen.dart';
import 'package:papyrus/widgets/oval_button.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);
  static const String id = 'Welcome Page';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget> [
            Text(
              'PAPYRUS',
              style: kTitleTextStyle,
            ),
            SizedBox(
              height: 120.0,
            ),
            OvalTextButton(
              height: 50,
              width: 265,
              fontSize: 20,
              onTap: () {
                Navigator.pushReplacementNamed(context, HomeScreen.id);
              },
              text: 'Start',
              textColor: kButtonTextColor,
              backgroundColor: kStartButtonColor,
              borderColor: kButtonBorderColor,
              elevation: 20,
            ),
          ],
        ),
      ),
    );
  }
}
