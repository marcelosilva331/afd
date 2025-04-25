// ignore_for_file: unreachable_switch_case

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:vocably/configs/analytics_service.dart';
import 'package:vocably/configs/injector.dart';
import 'package:vocably/configs/theme/custom_theme.dart';
import 'app.dart';
import 'flavors.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options_prd.dart' as fb_prd;
import 'firebase_options_dev.dart' as fb_dev;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await _initializeApp();

  runApp(MaterialApp(
      title: 'Custom Theme App',
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: ThemeMode.system,
      home: const App()));
}

Future<void> _initializeApp() async {
  _setupDependencies();
  _setFlavor();
  await _initializeFirebase();
  await _loadEnvironmentVariables();
  await _logAnalyticsStartupEvent();
  await _performEnvironmentSpecificActions();
}

void _setupDependencies() {
  Injector();
}

void _setFlavor() {
  F.appFlavor = Flavor.values.firstWhere(
    (element) => element.name == appFlavor,
  );
}

Future<void> _initializeFirebase() async {
  await Firebase.initializeApp(
    options: F.appFlavor == Flavor.prd
        ? fb_prd.DefaultFirebaseOptions.currentPlatform
        : fb_dev.DefaultFirebaseOptions.currentPlatform,
  );
}

Future<void> _loadEnvironmentVariables() async {
  if (F.appFlavor == Flavor.dev) {
    await dotenv.load(fileName: ".dev.env");
  } else if (F.appFlavor == Flavor.prd) {
    await dotenv.load(fileName: ".prod.env");
  }
}

Future<void> _logAnalyticsStartupEvent() async {
  final AnalyticsService analytics = GetIt.I.get();

  final eventName = switch (F.appFlavor) {
    Flavor.dev => 'inicialize_dev_app',
    Flavor.prd => 'inicialize_prd_app',
    _ => null,
  };

  if (eventName != null) {
    await analytics.logEvent(eventName);
  }
}

Future<void> _performEnvironmentSpecificActions() async {
  if (F.appFlavor == Flavor.dev) {
    await FirebaseFirestore.instance
        .collection("testeToogle")
        .add({'env': 'PRD'});
  }
}
