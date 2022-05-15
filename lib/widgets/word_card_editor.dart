/*
import 'package:flutter/material.dart';
import 'package:papyrus/constants.dart';
import 'package:papyrus/utilities/brain.dart';
import 'package:provider/provider.dart';

class WordCardEditor extends StatefulWidget {
  final String initialTerm;
  final String initialDefinition;
  final int index;

  const WordCardEditor({Key? key, required this.initialTerm, required this.initialDefinition, required this.index}) : super(key: key);

  @override
  State<WordCardEditor> createState() => _WordCardEditorState();
}

class _WordCardEditorState extends State<WordCardEditor> {
@override
  Widget build(BuildContext context) {
    Brain brain = Provider.of<Brain>(context);
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Container(
        color: Colors.grey[100],
        child: Row(
          children: [
            SizedBox(
              width: 20,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: 10,
                ),
                Container(
                  width: 150,
                  child: TextFormField(
                    style: kTextFieldTextStyle,
                    autocorrect: true,
                    decoration: InputDecoration(
                      contentPadding:
                      const EdgeInsets.symmetric(
                          vertical: 0),
                      isDense: true,
                      hintText: 'Enter Term',
                      hintStyle: kTextFieldHintStyle,
                      enabledBorder: InputBorder.none,
                    ),
                    controller: _controller1,
                    onSaved: (String? input) {
                      brain.addTempTerms(input!, widget.index);
                      brain.removeTempTerms(widget.index+1);
                    },
                  ),
                ),
                Text(
                  'Term',
                  style: kSmallTextStyle,
                ),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width-340,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: 10,
                ),
                Container(
                  width: 150,
                  child: TextFormField(
                    style: kTextFieldTextStyle,
                    autocorrect: true,
                    decoration: InputDecoration(
                      contentPadding:
                      const EdgeInsets.symmetric(
                          vertical: 0),
                      isDense: true,
                      hintText: 'Enter Definition',
                      hintStyle: kTextFieldHintStyle,
                      enabledBorder: InputBorder.none,
                    ),
                    controller: _controller2,
                    onSaved: (String? input) {
                      brain.addTempDefinitions(input!, widget.index);
                      brain.removeTempDefinitions(widget.index+1);
                    },
                  ),
                ),
                Text(
                  'Definition',
                  style: kSmallTextStyle,
                ),
                SizedBox(
                  height: 10,
                ),
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
*/