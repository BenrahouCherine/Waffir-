import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:waffir/features/authentification/screens/logindart/login.dart';
import 'package:waffir/navigation_menu.dart';

class OnBoardingController extends GetxController {
  static OnBoardingController get instance => Get.find();
  final pageController = PageController();
  final box = GetStorage();

  Rx<int> currentPageIndex = 0.obs;

  void updatePageIndicator(index) => currentPageIndex.value = index;

  void dotNavigationClick(index) {
    currentPageIndex.value = index;
    pageController.jumpTo(index);
  }

  void NextPage() {
    if (currentPageIndex.value == 2) {
      if (FirebaseAuth.instance.currentUser != null) {
        Get.offAll(() => const NavigationMenu());
        box.write("isIntroShown", true);
      } else {
        Get.offAll(() => LoginScreen());
        box.write("isIntroShown", true);
      }
    } else {
      int page = currentPageIndex.value + 1;
      pageController.jumpToPage(page);
    }
  }

  void skipPage() {
    if (FirebaseAuth.instance.currentUser != null) {
      Get.offAll(() => const NavigationMenu());
      box.write("isIntroShown", true);
    } else {
      Get.offAll(() => LoginScreen());
      box.write("isIntroShown", true);
    }
  }
}
