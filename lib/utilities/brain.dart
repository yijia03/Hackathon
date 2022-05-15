import 'package:flutter/material.dart';
import 'package:papyrus/exceptions.dart';
import 'package:papyrus/utilities/set.dart';

///A collection of all the sets the user has created, in alphabetical order by name
class Brain extends ChangeNotifier {
   ///Collections of the sets
   final List<WordSet> _sets = [];
   ///The set that is currently being edited
   WordSet? _current;
   ///Creates an empty set with no name and sets it to be the current set
   void create() {
      _current = WordSet('');
      notifyListeners();
   }
   WordSet getCurr() => _current!;
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
      notifyListeners();
   }

   @override
   ///String representation of the collection
   String toString() => 'sets: $_sets, current: $_current';
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
   WordSet delete(String setName) {
      int index = _getIndex(setName);
      if (index == -1){
         throw NotFoundException();
      }
      WordSet set = _sets[index];
      _sets.removeAt(index);
      notifyListeners();
      return set;
   }
   ///Adds the currently selected set into the collection and removes it from the editing cursor. Does nothing if no set is selected
   void saveEdits([WordSet? original]) {
      if (original != null) {
         insert(original);
      } else if (_current != null) {
         insert(_current!);
      }
      _current = null;
   }
   ///Selects a set with the cursor, if editing is true, then the list is also removed from the collection. Throws NotFoundException if setName doesn't match any sets in the collection
   void select(String setName, {bool editing=false}) {
      print('setting current to $setName');
      if (editing) {
         _current = delete(setName);
      } else {
         _current = _sets[_getIndex(setName)];
      }
      print('current = $_current');
      print('brain = $this');
   }
}