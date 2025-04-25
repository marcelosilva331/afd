import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:vocably/configs/remote_config/remote_config_strings.dart';
import 'package:vocably/configs/remote_config/remove_config_service.dart';
import 'package:vocably/configs/theme/custom_theme.dart';
import 'package:vocably/configs/theme/theme_controller.dart';
import 'package:vocably/viewModels/word_view_model.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  late ThemeController _themeController;
  final WordViewModel _viewModel = GetIt.I.get();
  final TextEditingController newListTitleEC = TextEditingController();

  var toogleValue = false;
  @override
  void initState() {
    super.initState();
    _themeController = GetIt.I.get();
    _themeController.addListener(() {
      setState(() {});
    });
    _viewModel.addListener(() {
      setState(() {});
    });

    _viewModel.getList();
  }

  @override
  void dispose() {
    newListTitleEC.dispose();
    _themeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: const Text("Nova lista"),
                  content: TextField(
                    controller: newListTitleEC,
                  ),
                  actions: [
                    ElevatedButton(
                        onPressed: () {
                          if (newListTitleEC.text.isEmpty) {
                            return;
                          }
                          _viewModel.createList(newListTitleEC.text);
                          Navigator.pop(context);
                        },
                        child: const Text('Criar'))
                  ],
                );
              });
        },
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        actions: [
          IconButton(
              key: const Key('theme'),
              onPressed: () {
                _themeController.changeTheme();
              },
              icon: Icon(_themeController.themeMode == ThemeMode.system
                  ? Icons.dark_mode
                  : Icons.sunny))
        ],
        title: const Text("Vocably"),
      ),
      body: SizedBox.expand(
        child: Builder(builder: (context) {
          if (_viewModel.wordsList.isEmpty) {
            return const Center(
              child: Text("Nenhuma lista criada"),
            );
          }
          if (_viewModel.loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (_viewModel.error) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Center(
                  child: Text("Erro ao buscar as listas"),
                ),
                ElevatedButton(
                    onPressed: () {
                      _viewModel.getList();
                    },
                    child: const Text("tentar novemente"))
              ],
            );
          }
          return ListView.builder(
            itemCount: _viewModel.wordsList.length,
            itemBuilder: (context, index) {
              final wordListIndex = _viewModel.wordsList[index];
              return ListTile(
                title: Text(wordListIndex.title),
                subtitle: Text(wordListIndex.words.length.toString()),
              );
            },
          );
        }),
      ),
    );
  }
}
