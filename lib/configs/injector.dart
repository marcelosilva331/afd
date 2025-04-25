import 'package:get_it/get_it.dart';
import 'package:vocably/configs/analytics_service.dart';
import 'package:vocably/configs/remote_config/remove_config_service.dart';
import 'package:vocably/configs/theme/theme_controller.dart';
import 'package:vocably/data/repository/implementations/word_repository_impl.dart';
import 'package:vocably/data/repository/interfaces/word_repository_interface.dart';
import 'package:vocably/viewModels/word_view_model.dart';

class Injector {
  Injector() {
    final getIt = GetIt.instance;

    getIt.registerFactory<AnalyticsService>(() => FirebaseAnalyticsService());

    getIt.registerFactory<RemoteConfigService>(() => RemoteConfigServiceImpl());

    getIt.registerFactory<IWordListRepository>(() => WordListRepositoryImpl());

    getIt.registerLazySingleton<ThemeController>(() => ThemeController());

    getIt.registerFactory<WordViewModel>(() => WordViewModel(GetIt.I.get()));
  }
}
