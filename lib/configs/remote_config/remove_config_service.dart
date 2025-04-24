import 'package:firebase_remote_config/firebase_remote_config.dart';

abstract interface class RemoteConfigService {
  Future<bool> getToogleValue(String toogleName);
}

class RemoteConfigServiceImpl implements RemoteConfigService {
  final remoteConfig = FirebaseRemoteConfig.instance;

  @override
  Future<bool> getToogleValue(String toogleName) async {
    try {
      await remoteConfig.setConfigSettings(RemoteConfigSettings(
        fetchTimeout: const Duration(seconds: 30),
        minimumFetchInterval: const Duration(seconds: 3),
      ));
      await remoteConfig.fetchAndActivate();

      final value = remoteConfig.getBool(toogleName);
      return value;
    } catch (e) {
      return false;
    }
  }
}
