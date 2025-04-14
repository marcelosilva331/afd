import 'package:vocably/domain/entites/word.dart';

class WordList {
  final int? id;
  final String title;
  final List<Word> _words = [];
  List<Word> get words => _words;

  WordList({this.id, required this.title});

  bool addWord(Word word) {
    if (word.notEmpty()) {
      _words.add(word);
      return true;
    }
    return false;
  }

  bool remove(Word word) {
    if (word.notEmpty()) {
      _words.remove(word);
      return true;
    }
    return false;
  }
}
