import 'package:flutter/material.dart';

class SetCard extends StatelessWidget {
  String _name;
  SetCard(this._name);

  @override
  Widget build(BuildContext context) {
    return Container(child: Text(_name), color: Colors.red,);
  }
}
