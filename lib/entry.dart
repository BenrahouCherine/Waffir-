import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
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
  final profileController = Get.find<ProfileController>();

  void _removeSplashScreen() async {
    await Future.delayed(const Duration(seconds: 2));
    FlutterNativeSplash.remove();
  }

  @override
  void initState() {
    isIntroShown = box.read('isIntroShown') ?? false;
    _removeSplashScreen();
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
              Future.microtask(() => Get.offAll(() => const LoginScreen()));
            } else {
              Future.microtask(
                  () => Get.offAll(() => const OnBoardingScreen()));
            }
          } else {
            profileController.getUser();
            Future.microtask(() => Get.offAll(() => NavigationMenu()));
          }
        }
        return const Scaffold(
          body: Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}
