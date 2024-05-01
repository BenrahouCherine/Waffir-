import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:waffir/features/Favoris/controllers/fav_controller.dart';
import 'package:waffir/features/Nos_Vendeurs/screens/decouvrir/nos_vendeurs/controller/discover_vendors.dart';
import 'package:waffir/features/Profil/profile_controller.dart';
import 'package:waffir/features/authentification/screens/login/login.dart';
import 'package:waffir/features/authentification/screens/onboarding/onboarding.dart';
import 'package:waffir/navigation_menu.dart';

class EntryPage extends StatefulWidget {
  const EntryPage({super.key});

  @override
  State<EntryPage> createState() => _EntryPageState();
}

class _EntryPageState extends State<EntryPage> {
  final _auth = FirebaseAuth.instance;
  final box = GetStorage();
  bool isIntroShown = false;

  @override
  void initState() {
    isIntroShown = box.read('isIntroShown') ?? false;
    Get.put(ProfileController());
    Get.put(FavController());
    Get.put(DiscoverVendorsController());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: _auth.authStateChanges(),
      builder: (BuildContext context, AsyncSnapshot<User?> snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          final User? user = snapshot.data;
          if (user == null) {
            if (isIntroShown) {
              return LoginScreen();
            } else {
              return const OnBoardingScreen();
            }
          } else {
            return const NavigationMenu();
          }
        } else {
          return const Scaffold(
              body: Center(child: CircularProgressIndicator()));
        }
      },
    );
  }
}
