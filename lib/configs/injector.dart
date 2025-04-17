import 'package:get_it/get_it.dart';
import 'package:vocably/configs/analytics_service.dart';

class Injector {
  Injector() {
    final getIt = GetIt.instance;

    getIt.registerFactory<AnalyticsService>(() => FirebaseAnalyticsService());
  }
}
