import 'package:papyrus/exceptions.dart';
import 'package:papyrus/utilities/note_card.dart';

///A single set of words, always in alphabetical order.
class WordSet {
  //Always ordered in alphabetical order.
  final List<NoteCard> _lst = [];
  String _name;
  WordSet(this._name);

  List<NoteCard> getCards() => _lst;
  String getName() => _name;
  void setName(String name) => _name = name;
  @override
  ///String representation of the word set.
  String toString() => '$_name: $_lst';
  ///JSON representation of the word set
  String toJSON() {
    String json = '["$_name", [';
    for (int i = 0; i < _lst.length - 1; i++) {
      json += _lst[i].toJSON() + ', ';
    }
    try {
      json += _lst.last.toJSON() + ']]';
    } catch (e) {
      return '[]';
    }
    return json;
  }
  ///Inserts card into the set in alphabetical order.
  void insert(NoteCard card){
    int i;
    for (i = 0; i < _lst.length; i++) {
      int diff = card.getTerm().toUpperCase().compareTo(_lst[i].getTerm().toUpperCase());
      if (diff < 0){
        break;
      } else if (diff == 0) {
        throw NameException();
      }
    }
    _lst.insert(i, card);
  }
  ///Deletes a card from the list.
  void delete(NoteCard card) {
    _lst.remove(card);
  }
}