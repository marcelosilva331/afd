import 'package:result_dart/result_dart.dart';
import 'package:vocably/domain/entites/word.dart';
import 'package:vocably/domain/entites/word_list_entity.dart';

abstract interface class IWordListRepository {
  AsyncResult createList(String title);
  AsyncResult deleteList(int listId);
  AsyncResult<List<WordList>> getLists();
  AsyncResult addWord(Word word, int listId);
  AsyncResult deleteWord(int wordId);
  AsyncResult<List<Word>> getWords(int listId);
}
