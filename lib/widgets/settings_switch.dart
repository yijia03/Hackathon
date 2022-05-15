import 'package:flutter/material.dart';
import 'package:papyrus/constants.dart';
class SettingsSwitch extends StatelessWidget {
  final Function(bool) onSwitch;
  final String text;
  final Color color; //Active color and inactive thumb color
  final bool value;
  final TextStyle textStyle;

  const SettingsSwitch({Key? key, required this.onSwitch, required this.text, required this.value, required this.color, required this.textStyle}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return ListTile(
      title: Text(text, style: textStyle),
      contentPadding: const EdgeInsets.symmetric(horizontal: 20),
      tileColor: Colors.white,
      trailing: Switch(
        activeColor: color,
        inactiveThumbColor: color,
        inactiveTrackColor: kStartButtonColor.withOpacity(0.25),
        value: value,
        onChanged: onSwitch,
      ),
    );
  }
}