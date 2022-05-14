//import 'package:flutter/material.dart';
import 'package:papyrus/exceptions.dart';
import 'package:papyrus/utilities/set.dart';

class Brain /*extends ChangeNotifier*/ {
   List<WordSet?> _sets = List<WordSet?>.filled(10, null);
   int _size = 0;
   void create(String setName) {
      if (_getIndex(setName) != -1) {
         throw NameException();
      }
      int index = 0;
      try {
         while (_sets[index] != null) {
            if (setName.compareTo(_sets[index]!.getName()) < 0){
               index = _left(index);
            } else {
               index = _right(index);
            }
         }
         _sets[index] = WordSet(setName);
         _size++;
      } catch (e) {
         _expand();
         create(setName);
      }
   }

   void _expand() {
      List<WordSet?> newLst = List<WordSet?>.filled(_sets.length * 2, null);
      for (int i = 0; i < _sets.length; i++) {
         newLst[i] = _sets[i];
      }
      _sets = newLst;
   }

   int _left(int index) => 2 * index + 1;
   int _right(int index) => 2 * index + 2;
   int _parent(int index) => (index - 1) ~/ 2;
   @override
   String toString() => _sets.toString();
   int _getIndex(String setName) {
      int index = 0;
      try {
         while (setName != _sets[index]!.getName()) {
            if (setName.compareTo(_sets[index]!.getName()) < 0){
               index = _left(index);
            } else {
               index = _right(index);
            }
         }
         return index;
      } catch (e) {
         return -1;
      }
   }

   void
}