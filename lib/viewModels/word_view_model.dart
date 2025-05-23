import 'package:flutter/material.dart';
import 'package:vocably/data/repository/interfaces/word_repository_interface.dart';
import 'package:vocably/domain/entites/word.dart';
import 'package:vocably/domain/entites/word_list_entity.dart';

class WordViewModel extends ChangeNotifier {
  WordViewModel(this._iWordListRepository);
  final IWordListRepository _iWordListRepository;

  List<WordList> wordsList = [];
  List<Word> words = [];

  var error = false;
  var loading = false;

  void _changeLoadingState(bool value) {
    loading = value;
    notifyListeners();
  }

  void _changeErrorState(bool value) {
    loading = false;
    error = value;
    notifyListeners();
  }

  void createList(String listName) async {
    _changeLoadingState(true);
    final result = await _iWordListRepository.createList(listName);
    result.fold((success) {
      _changeLoadingState(false);
      _changeErrorState(false);
      getList();
    }, (failure) {
      _changeErrorState(false);
    });
  }

  void getList() async {
    _changeLoadingState(true);
    final result = await _iWordListRepository.getLists();
    result.fold((success) {
      _changeLoadingState(false);
      _changeErrorState(false);
      wordsList = [];
      final listResult = result.getOrDefault([]);
      wordsList = listResult;
    }, (failure) {
      _changeErrorState(false);
    });
  }

  void getWordList(int id) async {
    _changeLoadingState(true);
    final result = await _iWordListRepository.getWords(id);
    result.fold((success) {
      _changeLoadingState(false);
      _changeErrorState(false);
      words = [];
      words = result.getOrDefault([]);
      notifyListeners();
    }, (failure) {
      _changeErrorState(true);
    });
  }

  void addWord(Word word, int listId) async {
    await _iWordListRepository.addWord(word, listId, word.meaning);
    getWordList(listId);
  }
}
