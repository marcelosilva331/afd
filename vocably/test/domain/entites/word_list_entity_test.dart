import 'package:flutter_test/flutter_test.dart';
import 'package:vocably/domain/entites/word.dart';
import 'package:vocably/domain/entites/word_list_entity.dart';

void main() {
  group('testing word list entity', () {
    test('Testing to add and to remove a word from list', () {
      final wordList = WordList(title: 'test');
      expect(wordList.words.isEmpty, true);
      final addSuccessWord = wordList.addWord(const Word(text: 'test'));
      expect(addSuccessWord, true);
      expect(wordList.words.isEmpty, false);
      final addErrorWord = wordList.addWord(const Word(text: ''));
      expect(addErrorWord, false);
      expect(wordList.words.length, 1);
    });
  });
}
