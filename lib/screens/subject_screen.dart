import 'dart:math';

import 'package:flutter/material.dart';
import 'package:papyrus/utilities/brain.dart';
import 'package:papyrus/utilities/note_card.dart';
import 'package:papyrus/widgets/oval_button.dart';
import 'package:papyrus/widgets/word_card.dart';
import 'package:provider/provider.dart';

///A screen with flashcards based on the selected set
class SubjectScreen extends StatefulWidget {
  const SubjectScreen({Key? key}) : super(key: key);
  static const String id = "Subject Screen";
  @override
  State<SubjectScreen> createState() => _SubjectScreenState();
}

class _SubjectScreenState extends State<SubjectScreen> {
  int _flashCardID = 0;
  bool _showFrontSide = true;
  bool _initialLoad = true;
  List<WordCard> cards = [];

  Widget __transitionBuilder(Widget widget, Animation<double> animation) {
    final rotateAnim = Tween(begin: pi, end: 0.0).animate(animation);
    return AnimatedBuilder(
      animation: rotateAnim,
      child: widget,
      builder: (context, widget) {
        final isUnder = (ValueKey(_showFrontSide) != widget!.key);
        var tilt = ((animation.value - 0.5).abs() - 0.5) * 0.003;
        tilt *= isUnder ? -1.0 : 1.0;
        final value =
            isUnder ? min(rotateAnim.value, pi / 2) : rotateAnim.value;
        return Transform(
          transform: Matrix4.rotationY(value)..setEntry(3, 0, tilt),
          child: widget,
          alignment: Alignment.center,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Brain b = Provider.of<Brain>(context);
    print('brain: ' + b.toString());
    if (_initialLoad) {
      for (NoteCard c in b.getCurr().getCards()) {
        cards.add(WordCard(c));
      }
      _initialLoad = false;
    }
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              Text('BUTTONS HERE'),
            ],
          ),
          GestureDetector(
            onTap: () => setState(() => _showFrontSide = !_showFrontSide),
            child: AnimatedSwitcher(
              duration: Duration(milliseconds: 600),
              transitionBuilder: __transitionBuilder,
              layoutBuilder: (widget, list) =>
                  Stack(children: [widget!, ...list]),
              child: _showFrontSide
                  ? cards[_flashCardID].front(context)
                  : cards[_flashCardID].back(context),
              switchInCurve: Curves.easeInBack,
              switchOutCurve: Curves.easeInBack.flipped,
            ),
          ),
          Row(
            children: [
              IconButton(
                  onPressed: () => setState(() {
                        _flashCardID = _flashCardID == 0
                            ? cards.length - 1
                            : _flashCardID - 1;
                      }),
                  icon: Icon(Icons.remove)),
              IconButton(
                  onPressed: () => setState(() {
                        _flashCardID = _flashCardID == cards.length - 1
                            ? 0
                            : _flashCardID + 1;
                      }),
                  icon: Icon(Icons.add)),
            ],
          ),
          OvalTextButton(onTap: () => setState(()=>cards.shuffle()), text: 'Shuffle', textColor: Colors.white, backgroundColor: Colors.amberAccent, borderColor: Colors.white, elevation: 20, height: 50, width: 100, fontSize: 20)
        ],
      ),
    );
  }
}
