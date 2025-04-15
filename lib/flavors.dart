import 'package:flutter_dotenv/flutter_dotenv.dart';

enum Flavor {
  dev,
  prd,
}

class F {
  static late final Flavor appFlavor;

  static String get name => appFlavor.name;

  static String get title {
    switch (appFlavor) {
      case Flavor.dev:
        return 'dev';
      case Flavor.prd:
        return 'prd';
    }
  }

  static String get baseUrl {
    return dotenv.env['BASEURL'].toString();
  }
}
