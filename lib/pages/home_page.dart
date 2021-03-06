import 'package:flutter/material.dart';
import 'package:papyrus/constants.dart';
import 'package:papyrus/utilities/brain.dart';
import 'package:papyrus/utilities/note_card.dart';
import 'package:papyrus/utilities/set.dart';
import 'package:papyrus/widgets/set_card.dart';
import 'package:provider/provider.dart';
import 'package:papyrus/screens/editor_screen.dart';

import '../screens/practice_screen.dart';



class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<Brain>(builder: (context, brain, child) {
      List<SetCard> setCards = [];
      for (WordSet s in brain.getSets()) {
        setCards.add(SetCard(s.getName()));
      }
      return Scaffold(
        backgroundColor: kBackgroundColor,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  const Padding(
                    padding:  EdgeInsets.only(left: 10, top: 25),
                    child: Text(
                      'Your Sets',
                      style: kHeaderTextStyle,
                    ),
                  ),
                ],
              ),
              Container(
                width: MediaQuery.of(context).size.width - 20,
                height: 5,
                color: Colors.grey[300],
              ),
              Stack(
                alignment: AlignmentDirectional.bottomEnd,
                children: <Widget> [
                  Container(
                    height: MediaQuery.of(context).size.height-140,
                    child: ListView(
                      children: setCards,
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
                            Navigator.push(context,
                              MaterialPageRoute(
                                builder: (context) => EditorScreen(initialTitle: brain.getCurr().getName()),
                              ),
                            );
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
