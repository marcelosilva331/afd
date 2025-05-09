import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:vocably/domain/entites/word.dart';
import 'package:vocably/domain/entites/word_list_entity.dart';
import 'package:vocably/viewModels/word_view_model.dart';

class WordPage extends StatefulWidget {
  const WordPage({required this.wordList, super.key});
  final WordList wordList;
  @override
  State<WordPage> createState() => _WordPageState();
}

class _WordPageState extends State<WordPage> {
  final WordViewModel _wordViewModel = GetIt.I.get();

  @override
  void initState() {
    _wordViewModel.addListener(() {
      setState(() {});
    });
    _wordViewModel.getWordList(widget.wordList.id!);
    super.initState();
  }

  final titleWord = TextEditingController();
  final meaningWord = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (_) {
                return AlertDialog(
                  title: const Text("Adicionar palavra"),
                  content: SizedBox(
                    width: 200,
                    height: 200,
                    child: Column(
                      children: [
                        TextField(
                          controller: titleWord,
                          decoration:
                              const InputDecoration(label: Text("Palavra")),
                        ),
                        TextField(
                          controller: meaningWord,
                          decoration:
                              const InputDecoration(label: Text("Significado")),
                        )
                      ],
                    ),
                  ),
                  actions: [
                    TextButton(
                        onPressed: () {
                          _wordViewModel.addWord(
                              Word(
                                  text: titleWord.text,
                                  meaning: meaningWord.text),
                              widget.wordList.id!);
                          Navigator.pop(context);
                        },
                        child: const Text("Add"))
                  ],
                );
              });
        },
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        title: Text(widget.wordList.title),
      ),
      body: SizedBox.expand(
        child: Builder(builder: (_) {
          if (_wordViewModel.words.isEmpty) {
            return const Center(
              child: Text("Nenhuma palavra adicionada"),
            );
          }
          return ListView.builder(
              itemCount: _wordViewModel.words.length,
              itemBuilder: (_, index) {
                final word = _wordViewModel.words[index];
                return ListTile(
                  title: Text(word.text),
                  subtitle: Text(word.meaning),
                );
              });
        }),
      ),
    );
  }
}
