import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);
  static const String id = 'Welcome Page';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [const Text('APP ICON HERE'), ],),
    );
  }
}
