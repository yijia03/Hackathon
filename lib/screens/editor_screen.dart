import 'package:flutter/material.dart';
import 'package:papyrus/utilities/brain.dart';
import 'package:provider/provider.dart';
import 'package:papyrus/constants.dart';

class EditorScreen extends StatefulWidget {
  const EditorScreen({Key? key}) : super(key: key);
  static const String id = "Editor Screen";

  @override
  State<EditorScreen> createState() => _EditorScreenState();
}

class _EditorScreenState extends State<EditorScreen> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<Brain>(builder: (context, brain, child) {
      return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 30, horizontal: 10),
                  child: Text(
                    'Title: ',
                    style: kSetTextStyle,
                  ),
                ),
                Container(
                  width: 250,
                  child: TextField(
                    style: kTextFieldTextStyle,
                    autocorrect: true,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(vertical: 0),
                      isDense: true,
                      hintText: 'Enter a title',
                      hintStyle: kTextFieldHintStyle,
                      enabledBorder: InputBorder.none,
                    ),
                    controller: _controller,
                    onSubmitted: (String input) {
                      brain.getCurr().setName(input);
                      print(brain.getCurr().toString());
                    },
                  ),
                ),
              ],
            ),

            Stack(
              alignment: AlignmentDirectional.bottomEnd,
              children: <Widget>[
                Container(
                  height: MediaQuery.of(context).size.height - 275,
                  child: ListView(),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all(15),
                      child: ElevatedButton(
                        onPressed: () {
                          brain.create();
                          Navigator.pushReplacementNamed(
                              context, EditorScreen.id);
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
      );
    });
  }
}
