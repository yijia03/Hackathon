import 'package:flutter/material.dart';
import 'package:papyrus/utilities/note_card.dart';

class WordCard extends StatelessWidget {
  NoteCard _card;
  WordCard(this._card);

  String getDef() => _card.getDef();

  @override
  Widget build(context) {
    return Container();
  }
  Widget front(context) {
    return Container(color: Colors.amberAccent, child: Center(child: Text(_card.getTerm()),), height: 200, width: 100,key: ValueKey(true),);
  }
  Widget back(context) {
    return Container(color: Colors.amberAccent, child: Center(child: Text(_card.getDef()),), height: 200, width: 100,
    key: ValueKey(false),);
  }
}
