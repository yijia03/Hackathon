import 'package:flutter/material.dart';
import 'package:papyrus/screens/editor_screen.dart';
import 'package:papyrus/screens/home_screen.dart';
import 'package:papyrus/screens/settings_screen.dart';
import 'package:papyrus/screens/subject_screen.dart';
import 'package:papyrus/screens/welcome_screen.dart';
import 'package:papyrus/utilities/brain.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const Papyrus());
}

class Papyrus extends StatelessWidget {
  const Papyrus({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return /*ChangeNotifierProvider<Brain>(
      create: (context) => Brain(),
      child: */MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          // UI
          brightness: Brightness.light,
        ),
        routes: {
          WelcomeScreen.id: (context) => const WelcomeScreen(),
          HomeScreen.id: (context) => const HomeScreen(),
          SettingsScreen.id: (context) => const SettingsScreen(),
          SubjectScreen.id: (context) => const SubjectScreen(),
          EditorScreen.id: (context) => const EditorScreen(),
        },
        initialRoute: WelcomeScreen.id,
      //),
    );
  }
}
