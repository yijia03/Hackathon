import 'package:flutter/material.dart';
import 'package:papyrus/constants.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 30, horizontal: 15),
                  child: Text(
                    'Sets',
                    style: kHeaderTextStyle,
                  ),
                ),
              ],
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(15),
                  child: ElevatedButton(
                    onPressed: () {},
                    child: Icon(Icons.add),
                    style: kAddButtonStyle,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
