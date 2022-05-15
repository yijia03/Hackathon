import 'dart:convert';
import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_signature_pad/flutter_signature_pad.dart';
import 'package:papyrus/constants.dart';
import 'package:papyrus/utilities/brain.dart';
import 'package:papyrus/utilities/note_card.dart';
import 'package:papyrus/utilities/request_handler.dart';
import 'package:papyrus/widgets/oval_button.dart';
import 'package:papyrus/widgets/word_card.dart';
import 'package:provider/provider.dart';

///A screen with flashcards based on the selected set
class PracticeScreen extends StatefulWidget {
  const PracticeScreen({Key? key}) : super(key: key);
  static const String id = "Subject Screen";
  @override
  State<PracticeScreen> createState() => _PracticeScreenState();
}

class _PracticeScreenState extends State<PracticeScreen> {
  int _flashCardID = 0;
  bool _showFrontSide = true;
  bool _initialLoad = true;
  List<WordCard> cards = [];
  final _sign = GlobalKey<SignatureState>();

  void _returnFeedback(bool feedback) {
    //TODO: implement this
  }

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
    return WillPopScope(
      onWillPop: () {
        b.insert(b.getCurr());
        return Future.value(true);
      },
      child: Scaffold(
        backgroundColor: kBackgroundColor,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 15,
            ),
            Row(
              children: [
                IconButton(
                    onPressed: () {
                      b.insert(b.getCurr());
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.arrow_back)),
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
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                    onPressed: () => setState(() {
                          _flashCardID = _flashCardID == 0
                              ? cards.length - 1
                              : _flashCardID - 1;
                        }),
                    icon: Icon(Icons.arrow_back)),
                IconButton(
                    onPressed: () => setState(() {
                          _flashCardID = _flashCardID == cards.length - 1
                              ? 0
                              : _flashCardID + 1;
                        }),
                    icon: Icon(Icons.arrow_forward)),
              ],
            ),
            Container(
              child: Signature(key: _sign, strokeWidth: 7.0),
              color: Colors.grey[400],
              height: 200,
            ),
            Row(
              children: [
                IconButton(
                    onPressed: () {
                      final sign = _sign.currentState;
                      sign!.clear();
                    },
                    icon: Icon(Icons.delete)),
              ],
            ),
            IconButton(
                onPressed: () async {
                  final sign = _sign.currentState;
                  final image = await sign!.getData();

                  var data =
                      await image.toByteData(format: ImageByteFormat.png);
                  String encoded = base64.encode(data!.buffer.asUint8List());
                  dynamic  feedback = await RequestHandler.request(encoded,
                      image.height, image.width, cards[_flashCardID].getDef());
                  print(feedback);
                  if (feedback['output'] == 1) {
                    showDialog<String>(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                        title: const Text(''),
                        content: const Text('Correct!'),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () => Navigator.pop(context, 'Cancel'),
                            child: const Text('Cancel'),
                          ),
                          TextButton(
                            onPressed: () => Navigator.pop(context, 'OK'),
                            child: const Text('OK'),
                          ),
                        ],
                      ),
                    );
                  } else {
                    showDialog<String>(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                        title: const Text(''),
                        content: Text('Incorrect!\nThe AI thinks that you wrote: ${feedback['user_estimated_answer']}'),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () => Navigator.pop(context, 'Cancel'),
                            child: const Text('Cancel'),
                          ),
                          TextButton(
                            onPressed: () => Navigator.pop(context, 'OK'),
                            child: const Text('OK'),
                          ),
                        ],
                      ),
                    );
                  }
                },
                icon: Icon(Icons.check)),
            ElevatedButton(
              onPressed: () => setState(() => cards.shuffle()),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width-290),
                child: Text(
                  'Shuffle',
                  style: kCheckTextStyle,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
