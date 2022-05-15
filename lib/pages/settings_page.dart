import 'package:flutter/material.dart';
import 'package:papyrus/constants.dart';
import 'package:papyrus/widgets/settings_switch.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _darkMode = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            SettingsSwitch(
                onSwitch: (value) {
                  setState(() {
                    _darkMode = value;
                  });
                  if (_darkMode) {
                    kBackgroundColor = Colors.black;
                  } else {
                    kBackgroundColor = Colors.white;
                  }
                },
                text: 'Dark Mode',
                value: _darkMode,
                color: Color(0xff77E1FF),
                textStyle: kDarkModeButtonTextStyle)
          ],
        ),
      ),
    );
  }
}
