import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:waffir/features/authentification/screens/OnBoarding/onboarding.dart';
//import 'package:waffir/features/authentification/screens/onboarding.dart';
import 'package:waffir/utils/theme/theme.dart';
import 'package:firebase_auth/firebase_auth.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return  GetMaterialApp(
      themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false,
    theme: TAppTheme.lightTheme,
    darkTheme: TAppTheme.darkTheme,
    home: const OnBoardingScreen(),


    );
  }
}