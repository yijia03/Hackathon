import 'package:flutter/material.dart';
import 'package:papyrus/constants.dart';
import 'package:papyrus/screens/subject_screen.dart';
import 'package:papyrus/widgets/oval_button.dart';


class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);
  static const String id = 'Welcome Page';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
                'PAPYRUS',
                style: kTitleTextStyle,
            ),
            SizedBox(
              height: 30.0,
            ),
            OvalTextButton(
                buttonSizeCoefficient: 1.5,
                onTap: (){
                  Navigator.pushReplacementNamed(context, SubjectScreen.id);
                },
                text: 'Start',
                textColor: Colors.white,
                backgroundColor: Color(0xffC3FFE3),
                borderColor: Colors.white,
                elevation: 20,
            ),
          ],
        ),
      ),
    );
  }
}
