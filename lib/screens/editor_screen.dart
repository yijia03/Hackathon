import 'package:flutter/material.dart';
import 'package:papyrus/pages/editor_page.dart';
import 'package:papyrus/utilities/brain.dart';
import 'package:provider/provider.dart';
import 'package:papyrus/constants.dart';
import 'package:papyrus/utilities/note_card.dart';
import 'package:papyrus/utilities/set.dart';

class EditorScreen extends StatelessWidget {
  final String initialTitle;

  const EditorScreen({Key? key, required this.initialTitle}) : super(key: key);
  static const String id = "Editor Screen";

  @override
  Widget build(BuildContext context) {
    Brain b = Provider.of<()
    return WillPopScope(
      onWillPop: ,
      child: Scaffold(
        backgroundColor: kBackgroundColor,
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: EditorPage(
            initialTitle: initialTitle,
          ),
        ),
      ),
    );
  }
}
