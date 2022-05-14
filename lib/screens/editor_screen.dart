import 'package:flutter/material.dart';
import 'package:papyrus/utilities/brain.dart';
import 'package:provider/provider.dart';

class EditorScreen extends StatelessWidget {
  const EditorScreen({Key? key}) : super(key: key);
  static const String id = "Editor Screen";

  @override
  Widget build(BuildContext context) {
    return Consumer<Brain>(builder: (context, brain, child) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
        ),
        body: Container(

        ),
      );
    });
  }
}
