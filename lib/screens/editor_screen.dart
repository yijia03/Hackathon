import 'package:flutter/material.dart';
import 'package:papyrus/utilities/brain.dart';
import 'package:provider/provider.dart';
import 'package:papyrus/constants.dart';
import 'package:papyrus/widgets/word_card_editor.dart';
import 'package:papyrus/utilities/note_card.dart';
import 'package:papyrus/utilities/set.dart';


class EditorScreen extends StatefulWidget {
  final String initialTitle;

  const EditorScreen({Key? key, required this.initialTitle}) : super(key: key);
  static const String id = "Editor Screen";

  @override
  State<EditorScreen> createState() => _EditorScreenState();
}

class _EditorScreenState extends State<EditorScreen> {
  late TextEditingController _controller;
  List<WordCardEditor> cards = [];
  bool _initialLoad = true;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialTitle);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Brain brain = Provider.of<Brain>(context);
    if (_initialLoad) {
      brain.clearTempDefinitions();
      brain.clearTempTerms();
      for (NoteCard nc in brain.getCurr().getCards()) {
        brain.addTempTerms(nc.getTerm(), cards.length);
        brain.addTempDefinitions(nc.getDef(), cards.length);
        cards.add(WordCardEditor(
            initialTerm: nc.getTerm(), initialDefinition: nc.getDef(), index: cards.length));
      }
      _initialLoad = false;
    }
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              const Padding(
                padding: EdgeInsets.only(left: 10, top: 25),
                child: Text(
                  'Title: ',
                  style: kSetTextStyle,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 25),
                child: Container(
                  width: 250,
                  child: TextField(
                    style: kTitleTextFieldTextStyle,
                    autocorrect: true,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(vertical: 0),
                      isDense: true,
                      hintText: 'Enter a title',
                      hintStyle: kTitleTextFieldHintStyle,
                      enabledBorder: InputBorder.none,
                    ),
                    controller: _controller,
                    onSubmitted: (String input) {},
                  ),
                ),
              ),
            ],
          ),
          Container(
            width: MediaQuery.of(context).size.width - 20,
            height: 5,
            color: Colors.grey[300],
          ),

          Expanded(
            child: ListView(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              children: cards,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Color(0xffA0E1FF),
                ),
                onPressed: () {
                  setState(() {
                    cards.add(WordCardEditor(initialTerm: '', initialDefinition: '', index: cards.length));
                  });
                },
                child: Container(
                  width: MediaQuery.of(context).size.width/2 - 50,
                  child: Center(
                    child: Text(
                      '+ Add Notecard',
                      style: kAddButtonTextStyle,
                    ),
                  ),
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Color(0xffA0E1FF),
                ),
                onPressed: () {
                  setState(() {
                    WordSet newSet = WordSet(_controller.text);
                    int index = 0;
                    for (WordCardEditor wce in cards) {
                      newSet.insert(NoteCard(brain.getTempTerms()[index], brain.getTempDefinitions()[index]));
                      index++;
                    }
                    brain.insert(newSet);
                    Navigator.pop(context);
                  });
                },
                child: Container(
                  width: MediaQuery.of(context).size.width/2 - 50,
                  child: Center(
                    child: Text(
                      'Save',
                      style: kAddButtonTextStyle,
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
