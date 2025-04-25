import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:integration_test/integration_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:vocably/configs/remote_config/remote_config_strings.dart';
import 'package:vocably/configs/remote_config/remove_config_service.dart';
import 'package:vocably/configs/theme/theme_controller.dart';
import 'package:vocably/flavors.dart';
import 'integration_main.dart' as app;

class RemoteConfigServiceMock extends Mock implements RemoteConfigService {}

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  late ThemeController themeController;
  late RemoteConfigService remoteConfigService;
  setUp(() {
    themeController = ThemeController();
    remoteConfigService = RemoteConfigServiceMock();

    GetIt.instance.registerSingleton<ThemeController>(themeController);
    GetIt.instance
        .registerFactory<RemoteConfigService>((() => remoteConfigService));

    when(() => remoteConfigService
            .getToogleValue(RemoteConfigStrings.testShowContainer))
        .thenAnswer((invocation) => Future.value(true));
  });

  group('description', () {
    testWidgets('Testa widget com GetIt', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();
      expect(find.text('Vocably'), findsOneWidget);
      await tester.pumpAndSettle();
      await Future.delayed(const Duration(seconds: 2));
      await tester.tap(find.byKey(const Key('theme')).first);
      await tester.pump();
      await Future.delayed(const Duration(seconds: 3));
    });
  });
}
