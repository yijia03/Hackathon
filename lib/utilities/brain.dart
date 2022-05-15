import 'package:flutter/material.dart';
import 'package:papyrus/exceptions.dart';
import 'package:papyrus/utilities/json_manager.dart';
import 'package:papyrus/utilities/note_card.dart';
import 'package:papyrus/utilities/set.dart';
import 'package:papyrus/widgets/word_card.dart';

///A collection of all the sets the user has created, in alphabetical order by name
class Brain extends ChangeNotifier {
   ///Collections of the sets
   final List<WordSet> _sets = [];
   ///The set that is currently being edited
   WordSet? _current;
   ///Default Constructor
   Brain();
   ///Creates a collection from a JSON file
   Brain.fromJSON(dynamic json) {
      List sets = json;
      for (int i = 0; i < sets.length; i++) {
         WordSet s = WordSet(sets[i][0].toString());
         List cards = sets[i][1];
         for (int j = 0; j < cards.length; j++) {
            NoteCard c = NoteCard(cards[j][0].toString(), cards[j][1].toString());
            s.insert(c);
         }
         _sets.add(s);
      }
   }
   ///Creates an empty set with no name and sets it to be the current set
   void create() {
      _current = WordSet('');
      notifyListeners();
   }
   WordSet getCurr() => _current!;
   List<WordSet> getSets() => _sets;
   ///Inserts a preexisting set to the list
   void insert(WordSet set) {
      int i;
      for (i = 0; i < _sets.length; i++) {
         int diff = set.getName().toUpperCase().compareTo(_sets[i].getName().toUpperCase());
         if (diff < 0){
            i = i > 0 ? i - 1 : 0;
            break;
         } else if (diff == 0) {
            throw NameException();
         }
      }
      _sets.insert(i, set);
      JSONManager.save(this);
      notifyListeners();
   }

   @override
   ///String representation of the collection
   String toString() => 'sets: $_sets, current: $_current';
   ///Returns a JSON of the Brain
   String toJSON() {
      String json = '[';
      for (int i = 0; i < _sets.length - 1; i++) {
         json += _sets[i].toString() + ',';
      }
      try {
         json += _sets.last.toJSON() + ']';
      } catch (e) {
         return '{}';
      }
      return json;
   }
   ///Finds the position of a set using its name. Returns -1 if the set isn't part of the collection
   int _getIndex(String setName) {
      int min = 0;
      int max = _sets.length;
      int index = (max - min) ~/ 2;
      while (max >= min) {
         int diff = setName.toUpperCase().compareTo(_sets[index].getName().toUpperCase());
         if (diff == 0) {
            return index;
         } else if (diff < 0) {
            max = index;
         } else {
            min = index;
         }
         index = (max - min) ~/ 2;
      }
      return -1;
   }
   ///Deletes a set in the collection and returns it. Throws NotFoundException when trying to delete a set not in the collection
   WordSet delete(String setName, {bool save=true}) {
      int index = _getIndex(setName);
      if (index == -1){
         throw NotFoundException();
      }
      WordSet set = _sets[index];
      _sets.removeAt(index);
      if (save) {
         JSONManager.save(this);
      }
      notifyListeners();
      return set;
   }
   ///Selects a set with the cursor and removes it from the collection. Throws NotFoundException if setName doesn't match any sets in the collection
   void select(String setName) {
      _current = delete(setName, save: false);
   }
}