import 'package:flutter/material.dart';
import 'package:waffir/utils/constants/colors.dart';
//import '../../constants/colors.dart';
//import '../../constants/sizes.dart';

/* -- Light & Dark Elevated Button Themes -- */
class TElevatedButtonTheme {
  TElevatedButtonTheme._(); //To avoid creating instances


  /* -- Light Theme -- */
  static final lightElevatedButtonTheme  = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      elevation: 0,
      foregroundColor: Colors.white,
      backgroundColor: TColors.secondary,
      disabledForegroundColor: const Color.fromARGB(255, 255, 255, 255),
      disabledBackgroundColor: const Color.fromARGB(255, 255, 255, 255),
      side: const BorderSide(color: TColors.secondary),
      padding: const EdgeInsets.symmetric(vertical: 18),
      textStyle: const TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.w600),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),
  );

  /* -- Dark Theme -- */
  static final darkElevatedButtonTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      elevation: 0,
      foregroundColor:Colors.white,
      backgroundColor: TColors.secondary,
      disabledForegroundColor: const Color.fromARGB(255, 255, 255, 255),
      disabledBackgroundColor: const Color.fromARGB(255, 255, 255, 255),
      side: const BorderSide(color: TColors.secondary),
      padding: const EdgeInsets.symmetric(vertical: 18),
      textStyle: const TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.w600),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),
  );
}
