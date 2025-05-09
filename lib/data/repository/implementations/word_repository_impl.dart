// ignore: depend_on_referenced_packages
import 'package:path/path.dart';
import 'package:result_dart/result_dart.dart';
import 'package:sqflite/sqflite.dart';
import 'package:vocably/data/repository/interfaces/word_repository_interface.dart';

import 'package:vocably/domain/entites/word.dart';
import 'package:vocably/domain/entites/word_list_entity.dart';

class WordListRepositoryImpl implements IWordListRepository {
  // Get the database
  Future<Database> get database async {
    return _initDatabase();
  }

  // Initialize the database
  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'word_lists3.db');
    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  // Create tables
  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE wordLists(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT NOT NULL UNIQUE
      )
    ''');

    await db.execute('''
      CREATE TABLE words(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        text TEXT NOT NULL,
        meaning TEXT NOT NULL,
        list_id INTEGER,
        FOREIGN KEY(list_id) REFERENCES wordList(id)
      )
    ''');
  }

  // Create a new list
  @override
  AsyncResult createList(String title) async {
    final db = await database;
    final resultInsert = await db.insert('wordLists', {'title': title},
        conflictAlgorithm: ConflictAlgorithm.replace);

    return Success(resultInsert);
  }

  // Add a word to a list
  @override
  AsyncResult addWord(Word word, int listId, String meaning) async {
    final db = await database;
    final resultInsert = await db.insert(
        'words', {'text': word.text, 'list_id': listId, 'meaning': meaning});
    if (resultInsert == 1) {
      return Success(resultInsert);
    }
    return Failure(Exception());
  }

  // Get all lists
  @override
  AsyncResult<List<WordList>> getLists() async {
    try {
      final db = await database;
      final list = await db.rawQuery('SELECT * FROM wordLists');
      final wordsList = list
          .map((e) => WordList(
              title: e['title'].toString(), id: int.parse(e['id'].toString())))
          .toList();
      return Success(wordsList);
    } catch (_) {
      return Failure(Exception());
    }
  }

  // Get words by list id
  @override
  AsyncResult<List<Word>> getWords(int listId) async {
    try {
      final db = await database;
      final result =
          await db.query('words', where: 'list_id = ?', whereArgs: [listId]);

      return Success(result
          .map((map) => Word(
              id: int.parse(map['id'].toString()),
              text: map['text'].toString(),
              meaning: map['meaning'].toString()))
          .toList());
    } catch (e) {
      return Failure(Exception());
    }
  }

  // Remove a word by id
  @override
  AsyncResult deleteWord(int id) async {
    final db = await database;
    final result = await db.delete('words', where: 'id = ?', whereArgs: [id]);
    if (result == 1) {
      return Success(result);
    }
    return Failure(Exception());
  }

  // Remove a list and all its words
  @override
  AsyncResult deleteList(int id) async {
    final db = await database;
    await db.delete('words', where: 'list_id = ?', whereArgs: [id]);
    final result =
        await db.delete('wordLists', where: 'id = ?', whereArgs: [id]);
    if (result == 1) {
      return Success(result);
    }
    return Failure(Exception());
  }
}
