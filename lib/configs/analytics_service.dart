import 'package:firebase_analytics/firebase_analytics.dart';

abstract interface class AnalyticsService {
  Future<void> logEvent(String name, {Map<String, Object>? parameters});
}

class FirebaseAnalyticsService implements AnalyticsService {
  final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;

  @override
  Future<void> logEvent(String name, {Map<String, Object>? parameters}) async {
    await _analytics.logEvent(name: name, parameters: parameters);
  }
}
