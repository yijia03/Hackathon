import 'package:flutter/material.dart';
import 'package:papyrus/utilities/note_card.dart';
import 'package:papyrus/constants.dart';

class WordCard extends StatelessWidget {
  NoteCard _card;
  WordCard(this._card);

  String getDef() => _card.getDef();

  @override
  Widget build(context) {
    return Container();
  }
  Widget front(context) {
    return Container(color: kCardColor, child: Center(child: Text(_card.getTerm(), style: kCardTextStyle,)), height: 200, width: 300,key: ValueKey(true),);
  }
  Widget back(context) {
    return Container(color: kCardColor, child: Center(child: Text(_card.getDef(), style: kCardTextStyle,)), height: 200, width: 300,
    key: ValueKey(false),);
  }
}
