import 'package:flutter/material.dart';
import 'package:vocably/app.dart';
import 'package:vocably/flavors.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  F.appFlavor = Flavor.dev;
  runApp(const App());
}
