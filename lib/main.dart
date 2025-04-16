import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'app.dart';
import 'flavors.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options_prd.dart' as fb_prd;
import 'firebase_options_dev.dart' as fb_dev;

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

  await Firebase.initializeApp(
      options: F.appFlavor == Flavor.prd
          ? fb_prd.DefaultFirebaseOptions.currentPlatform
          : fb_dev.DefaultFirebaseOptions.currentPlatform);

  await FirebaseFirestore.instance.collection("env").add({'env': 'PRD'});
  print(F.baseUrl);

  runApp(const App());
}
