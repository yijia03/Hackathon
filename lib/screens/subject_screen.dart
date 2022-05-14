import 'package:flutter/material.dart';
import 'package:papyrus/utilities/brain.dart';
import 'package:papyrus/utilities/note_card.dart';
import 'package:papyrus/widgets/word_card.dart';
import 'package:provider/provider.dart';
///A screen with flashcards based on the selected set
class SubjectScreen extends StatefulWidget {
  const SubjectScreen({Key? key}) : super(key: key);
  static const String id = "Subject Screen";
  @override
  State<SubjectScreen> createState() => _SubjectScreenState();
}

class _SubjectScreenState extends State<SubjectScreen> {
  @override
  Widget build(BuildContext context) {
    List<WordCard> cards = [];
    Brain b = Provider.of<Brain>(context);
    print('brain: ' + b.toString());
    for (NoteCard c in b.getCurr().getCards()) {
      cards.add(WordCard(c, true));
    }
    return Scaffold(body: Column(children: cards,),);
  }
}

