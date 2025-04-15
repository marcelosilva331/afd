import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'app.dart';
import 'flavors.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  F.appFlavor = Flavor.values.firstWhere(
    (element) => element.name == appFlavor,
  );

  if (F.appFlavor == Flavor.dev) {
    await dotenv.load(fileName: ".dev.env");
  }

  if (F.appFlavor == Flavor.prd) {
    await dotenv.load(fileName: ".prod.env");
  }

  print(F.baseUrl);

  runApp(const App());
}
