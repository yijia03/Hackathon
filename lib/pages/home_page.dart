import 'package:flutter/material.dart';
import 'package:papyrus/constants.dart';
import 'package:papyrus/utilities/brain.dart';
import 'package:papyrus/utilities/note_card.dart';
import 'package:papyrus/utilities/set.dart';
import 'package:provider/provider.dart';
import 'package:papyrus/screens/editor_screen.dart';

import '../screens/subject_screen.dart';



class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<Brain>(builder: (context, brain, child) {
      return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 30, horizontal: 15),
                    child: Text(
                      'Your Sets',
                      style: kHeaderTextStyle,
                    ),
                  ),
                ],
              ),
              Stack(
                alignment: AlignmentDirectional.bottomEnd,
                children: <Widget> [
                  Container(
                    height: MediaQuery.of(context).size.height-250,
                    child: ListView(
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.all(15),
                        child: ElevatedButton(
                          onPressed: () {
                            brain.create();
                            Navigator.pushNamed(context, EditorScreen.id);
                          },
                          child: Icon(Icons.add),
                          style: kAddButtonStyle,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    });
  }
}
