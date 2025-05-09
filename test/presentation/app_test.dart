import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';
import 'package:vocably/app.dart';
import 'package:vocably/configs/remote_config/remote_config_strings.dart';
import 'package:vocably/configs/remote_config/remove_config_service.dart';
import 'package:vocably/configs/theme/theme_controller.dart';
import 'package:vocably/viewModels/word_view_model.dart'; // Altere para o local correto do seu serviço

class ThemeMock extends Mock implements ThemeController {}

class RemoteConfigServiceMock extends Mock implements RemoteConfigService {}

class WordViewModelMock extends Mock implements WordViewModel {}

void main() {
  late ThemeController themeController;
  late RemoteConfigService remoteConfigService;
  setUp(() {
    themeController = ThemeMock();
    remoteConfigService = RemoteConfigServiceMock();

    GetIt.instance.registerSingleton<ThemeController>(themeController);
    GetIt.instance.registerSingleton<WordViewModel>(WordViewModelMock());
    GetIt.instance.unregister<ThemeController>();

    GetIt.instance.registerSingleton<ThemeController>(themeController);

    GetIt.instance
        .registerFactory<RemoteConfigService>((() => remoteConfigService));

    when(() => themeController.themeMode).thenReturn(ThemeMode.system);
    when(() => remoteConfigService
            .getToogleValue(RemoteConfigStrings.testShowContainer))
        .thenAnswer((invocation) => Future.value(true));
  });

  tearDown(() {
    GetIt.instance.reset();
  });

  testWidgets('Testa widget com GetIt', (WidgetTester tester) async {});
}
