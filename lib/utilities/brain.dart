//import 'package:flutter/material.dart';
import 'package:papyrus/exceptions.dart';
import 'package:papyrus/utilities/set.dart';

class Brain /*extends ChangeNotifier*/ {
   final List<WordSet> _sets = [];
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
   String toString() => _sets.toString();

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

   WordSet delete(String setName) {
      int index = _getIndex(setName);
      if (index == -1){
         throw NotFoundException();
      }
      WordSet set = _sets[index];
      _sets.removeAt(index);
      return set;
   }

   void changeName(String setName, String newName) {
      WordSet set = delete(setName);
      set.setName(newName);
      insert(set);
   }
}