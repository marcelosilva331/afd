import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:vocably/configs/remote_config/remote_config_strings.dart';
import 'package:vocably/configs/remote_config/remove_config_service.dart';
import 'package:vocably/configs/theme/custom_theme.dart';
import 'package:vocably/configs/theme/theme_controller.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  final RemoteConfigService _remoteConfigService = GetIt.I.get();
  late ThemeController _themeController;

  var toogleValue = false;
  @override
  void initState() {
    super.initState();
    _themeController = GetIt.I.get();
    _themeController.addListener(() {
      setState(() {});
    });
    changeToogleValue();
  }

  @override
  void dispose() {
    _themeController.dispose();
    super.dispose();
  }

  void changeToogleValue() async {
    toogleValue = await _remoteConfigService
        .getToogleValue(RemoteConfigStrings.testShowContainer);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Custom Theme App',
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: _themeController.themeMode,
      home: Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
                onPressed: () {
                  _themeController.changeTheme();
                },
                icon: Icon(_themeController.themeMode == ThemeMode.system
                    ? Icons.dark_mode
                    : Icons.sunny))
          ],
          title: const Text("Vocably"),
        ),
      ),
    );
  }
}
