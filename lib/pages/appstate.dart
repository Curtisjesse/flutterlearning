import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';

class MyAppState extends ChangeNotifier {
  var current = WordPair.random();
  var words = <WordPair>[];
  void getNext() {
    words.insert(0, current);
    current = WordPair.random();
    notifyListeners();
  }

  int index = 0;
  void previuos() {
    current = words[index];
    if (index < words.length - 1) {
      index++;
    } else {
      index = words.length - 1;
    }
    if (index >= words.length - 1) {
      index = words.length - 1;
    }
    notifyListeners();
  }

  var favorites = <WordPair>[];

  void toggleFavorite() {
    if (favorites.contains(current)) {
      favorites.remove(current);
    } else {
      favorites.add(current);
    }
    notifyListeners();
  }
}