import 'package:flutter/material.dart';
import 'package:papyrus/screens/editor_screen.dart';
import 'package:papyrus/screens/home_screen.dart';
import 'package:papyrus/screens/subject_screen.dart';
import 'package:papyrus/screens/welcome_screen.dart';
import 'package:papyrus/utilities/brain.dart';
import 'package:papyrus/utilities/note_card.dart';
import 'package:papyrus/utilities/set.dart';
import 'package:papyrus/widgets/word_card.dart';
import 'package:provider/provider.dart';

void main() {
  runApp( Papyrus());
}

class Papyrus extends StatelessWidget {
  late Brain _b;
  void init() {
    _b = Brain();
    WordSet set = WordSet('set 1');
    set.insert(NoteCard('D', 'd'));
    set.insert(NoteCard('A', 'a'));
    set.insert(NoteCard('B', 'b'));
    set.insert(NoteCard('C', 'c'));
    _b.insert(set);
    _b.select('set 1', editing: false);
  }
  @override
  Widget build(BuildContext context) {
    init();
    return ChangeNotifierProvider<Brain>(
      create: (context) => _b,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          // UI
          brightness: Brightness.light,
        ),
        routes: {
          WelcomeScreen.id: (context) => const WelcomeScreen(),
          HomeScreen.id: (context) => const HomeScreen(),
          SubjectScreen.id: (context) => const SubjectScreen(),
          EditorScreen.id: (context) => const EditorScreen(),
        },
        initialRoute: WelcomeScreen.id,
      ),
    );
  }
}
