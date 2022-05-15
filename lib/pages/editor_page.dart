import 'package:flutter/material.dart';
import 'package:papyrus/utilities/brain.dart';
import 'package:provider/provider.dart';
import 'package:papyrus/constants.dart';
import 'package:papyrus/widgets/word_card_editor.dart';
import 'package:papyrus/utilities/note_card.dart';
import 'package:papyrus/utilities/set.dart';

class EditorPage extends StatefulWidget {
  final String initialTitle;

  const EditorPage({Key? key, required this.initialTitle}) : super(key: key);

  @override
  State<EditorPage> createState() => _EditorPageState();
}

class _EditorPageState extends State<EditorPage> {
  late TextEditingController _controller;
  bool _initialLoad = true;
  late Brain brain;
  List<String> terms = [];
  List<String> defs = [];
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

  List<Widget> cardBuilder(BuildContext context) {
    List<Widget> lst = [];
    for (int i = 0; i < terms.length; i++) {
      lst.add(
        Padding(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: Container(
            color: Colors.grey[100],
            child: Row(
              children: [
                SizedBox(width: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(height: 10),
                    Container(
                      width: 150,
                      child: TextFormField(
                        style: kTextFieldTextStyle,
                        autocorrect: true,
                        decoration: InputDecoration(
                          contentPadding:
                              const EdgeInsets.symmetric(vertical: 0),
                          isDense: true,
                          hintText: 'Enter Term',
                          hintStyle: kTextFieldHintStyle,
                          enabledBorder: InputBorder.none,
                        ),
                        initialValue: terms[i],
                        onChanged: (value) {
                          setState(() {
                            terms[i] = value;
                          });
                        },
                      ),
                    ),
                    Text('Term', style: kSmallTextStyle),
                    SizedBox(height: 10),
                  ],
                ),
                SizedBox(width: MediaQuery.of(context).size.width - 340),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(height: 10),
                    Container(
                      width: 150,
                      child: TextFormField(
                        style: kTextFieldTextStyle,
                        autocorrect: true,
                        decoration: InputDecoration(
                          contentPadding:
                              const EdgeInsets.symmetric(vertical: 0),
                          isDense: true,
                          hintText: 'Enter Definition',
                          hintStyle: kTextFieldHintStyle,
                          enabledBorder: InputBorder.none,
                        ),
                        initialValue: defs[i],
                        onChanged: (value) {
                          setState(() {
                            defs[i] = value;
                          });
                        },
                      ),
                    ),
                    Text('Definition', style: kSmallTextStyle),
                    SizedBox(height: 10),
                  ],
                ),
                SizedBox(width: 20),
              ],
            ),
          ),
        ),
      );
    }
    return lst;
  }

  @override
  Widget build(BuildContext context) {
    brain = Provider.of<Brain>(context);
    if (_initialLoad) {
      for (NoteCard c in brain.getCurr().getCards()) {
        terms.add(c.getTerm());
        defs.add(c.getDef());
      }
      _initialLoad = false;
    }
    return Column(
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
            children: cardBuilder(context),
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
                  terms.add('');
                  defs.add('');
                });
              },
              child: Container(
                width: MediaQuery.of(context).size.width / 2 - 50,
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
                  for (int i = 0; i < terms.length; i++) {
                    if (terms[i] != '' && defs[i] != '') {
                      newSet.insert(NoteCard(terms[i], defs[i]));
                    }
                  }
                  brain.insert(newSet);
                  Navigator.pop(context);
                });
              },
              child: Container(
                width: MediaQuery.of(context).size.width / 2 - 50,
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
    );
  }
}
