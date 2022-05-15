import 'package:flutter/material.dart';
import 'package:papyrus/screens/practice_screen.dart';
import 'package:papyrus/utilities/brain.dart';
import 'package:provider/provider.dart';
import 'package:papyrus/constants.dart';
import '../screens/editor_screen.dart';

class SetCard extends StatelessWidget {
  String _name;
  SetCard(this._name);

  @override
  Widget build(BuildContext context) {
    Brain b = Provider.of<Brain>(context, listen: false);
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Container(
        color: Colors.grey[300],
        child: Row(
          children: [
            SizedBox(
              width: 20,
            ),
            Text(
                _name,
                style: kHomepageSetTextStyle,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width-240,
            ),
            Row(
              children: [
                IconButton(
                    onPressed: () {
                      b.select(_name);
                      Navigator.pushNamed(context, PracticeScreen.id );
                    },
                    icon: Icon(Icons.play_arrow)),
                IconButton(
                    onPressed: () {
                      b.select(_name);
                      Navigator.push(context,
                        MaterialPageRoute(
                          builder: (context) => EditorScreen(initialTitle: b.getCurr().getName()),
                        ),
                      );
                    },
                    icon: Icon(Icons.create)),
                IconButton(
                    onPressed: () {
                      b.delete(_name);
                    },
                    icon: Icon(Icons.delete)),
              ],
            ),
            SizedBox(
              width: 20,
            ),
          ],
        ),
      ),
    );
  }
}
