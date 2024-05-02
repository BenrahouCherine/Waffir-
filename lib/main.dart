import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:waffir/app.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    if (Firebase.apps.isEmpty) {
      await Firebase.initializeApp(
        options: const FirebaseOptions(
          apiKey: "AIzaSyBEwaYAS5v1aWc_E5mhM8I57aGSsC4belg",
          authDomain: "waffir-42532.firebaseapp.com",
          projectId: "waffir-42532",
          storageBucket: "waffir-42532.appspot.com",
          messagingSenderId: "326988981936",
          appId: "1:326988981936:web:3b3387785ee6ec780d7d75",
          measurementId: "G-BWT48P0TET",
        ),
      );
    }
  } catch (e) {}

  try {
    await GetStorage.init();
  } catch (e) {}

  runApp(const App());
}
