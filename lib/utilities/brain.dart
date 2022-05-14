//import 'package:flutter/material.dart';
import 'package:papyrus/exceptions.dart';
import 'package:papyrus/utilities/set.dart';

///A collection of all the sets the user has created, in alphabetical order by name.
class Brain /*extends ChangeNotifier*/ {
   final List<WordSet> _sets = [];
   ///Creates an empty set with the given setName and adds it to the list.
   void create(String setName) {
      int i;
      for (i = 0; i < _sets.length; i++) {
         int diff = setName.toUpperCase().compareTo(_sets[i].getName().toUpperCase());
         if (diff > 0){
            i--;
            break;
         } else if (diff == 0) {
            throw NameException();
         }
      }
      _sets.insert(i, WordSet(setName));
   }
   ///Inserts a preexisting set to the list.
   void insert(WordSet set) {
      int i;
      for (i = 0; i < _sets.length; i++) {
         int diff = set.getName().toUpperCase().compareTo(_sets[i].getName().toUpperCase());
         if (diff > 0){
            i--;
            break;
         } else if (diff == 0) {
            throw NameException();
         }
      }
      _sets.insert(i, set);
   }

   @override
   ///String representation of the collection.
   String toString() => _sets.toString();
   ///Finds the position of a set using its name. Returns -1 if the set isn't part of the collection.
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
   ///Deletes a set in the collection and returns it. Throws NotFoundException when trying to delete a set not in the collection.
   WordSet delete(String setName) {
      int index = _getIndex(setName);
      if (index == -1){
         throw NotFoundException();
      }
      WordSet set = _sets[index];
      _sets.removeAt(index);
      return set;
   }
   ///Changes the name of an existing set by deleting it and then reinserting it. Throws NotFoundException when trying to rename a set not in the collection.
   void changeName(String setName, String newName) {
      WordSet set = delete(setName);
      set.setName(newName);
      insert(set);
   }
}