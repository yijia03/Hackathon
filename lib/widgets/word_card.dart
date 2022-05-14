import 'package:flutter/material.dart';
import 'package:papyrus/utilities/note_card.dart';

class WordCard extends StatelessWidget {
  NoteCard _card;
  bool _term = true;
  WordCard(this._card, this._term);

  @override
  Widget build(BuildContext context) {
    return Container(height: 100, width: 200, child: Text(_term ? _card.getTerm() : _card.getDef()),color: Colors.blue,);
  }
}
