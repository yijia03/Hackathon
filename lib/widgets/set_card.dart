import 'package:flutter/material.dart';
import 'package:papyrus/screens/practice_screen.dart';
import 'package:papyrus/utilities/brain.dart';
import 'package:provider/provider.dart';

import '../screens/editor_screen.dart';

class SetCard extends StatelessWidget {
  String _name;
  SetCard(this._name);

  @override
  Widget build(BuildContext context) {
    Brain b = Provider.of<Brain>(context, listen: false);
    return Container(
      child: Row(
        children: [
          Text(_name),
          IconButton(
              onPressed: () {
                b.select(_name);
                Navigator.pushNamed(context, PracticeScreen.id);
              },
              icon: Icon(Icons.play_arrow)),
          IconButton(
              onPressed: () {
                b.select(_name);
                Navigator.pushNamed(context, EditorScreen.id);
              },
              icon: Icon(Icons.create)),
          IconButton(
              onPressed: () {
                b.delete(_name);
              },
              icon: Icon(Icons.delete)),
        ],
      ),
      color: Colors.red,
    );
  }
}
