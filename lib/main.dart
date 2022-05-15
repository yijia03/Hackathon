import 'package:flutter/material.dart';
import 'package:papyrus/screens/editor_screen.dart';
import 'package:papyrus/screens/home_screen.dart';
import 'package:papyrus/screens/practice_screen.dart';
import 'package:papyrus/screens/welcome_screen.dart';
import 'package:papyrus/utilities/brain.dart';
import 'package:papyrus/utilities/json_manager.dart';
import 'package:papyrus/utilities/note_card.dart';
import 'package:papyrus/utilities/set.dart';
import 'package:papyrus/widgets/word_card.dart';
import 'package:provider/provider.dart';

import 'constants.dart';

void main() {
  runApp( Papyrus());
}

class Papyrus extends StatelessWidget {
  late Brain _b;
  void init() async {
    try {
      _b = await JSONManager.load();
    } catch (e) {
      _b = Brain();
    }
  }
  @override
  Widget build(BuildContext context) {
    init();
    return ChangeNotifierProvider<Brain>(
      create: (context) => _b,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: {
          WelcomeScreen.id: (context) => const WelcomeScreen(),
          HomeScreen.id: (context) => const HomeScreen(),
          PracticeScreen.id: (context) => const PracticeScreen(),
        },
        initialRoute: WelcomeScreen.id,
      ),
    );
  }
}
