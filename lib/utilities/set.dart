import 'package:papyrus/exceptions.dart';
import 'package:papyrus/utilities/note_card.dart';

class WordSet {
  //Always ordered in alphabetical order
  final List<NoteCard> _lst = [];
  String _name;
  WordSet(this._name);

  List<NoteCard> getCards() => _lst;
  String getName() => _name;
  void setName(String name) => _name = name;
  @override
  String toString() => '$_name: $_lst';
  void insert(NoteCard card){
    int i;
    for (i = 0; i < _lst.length; i++) {
      int diff = card.getTerm().toUpperCase().compareTo(_lst[i].getTerm().toUpperCase());
      if (diff> 0){
        i--;
        break;
      } else if (diff == 0) {
        throw NameException();
      }
    }
    _lst.insert(i, card);
  }
  void delete(NoteCard card) {
    _lst.remove(card);
  }
}