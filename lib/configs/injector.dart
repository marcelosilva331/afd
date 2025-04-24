import 'package:get_it/get_it.dart';
import 'package:vocably/configs/analytics_service.dart';
import 'package:vocably/configs/remote_config/remove_config_service.dart';
import 'package:vocably/configs/theme/theme_controller.dart';

class Injector {
  Injector() {
    final getIt = GetIt.instance;

    getIt.registerFactory<AnalyticsService>(() => FirebaseAnalyticsService());

    getIt.registerFactory<RemoteConfigService>(() => RemoteConfigServiceImpl());

    getIt.registerLazySingleton<ThemeController>(() => ThemeController());
  }
}
