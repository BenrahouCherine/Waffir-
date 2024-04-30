
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:waffir/features/authentification/controlers/onboarding_controller.dart';
import 'package:waffir/utils/constants/colors.dart';
import 'package:waffir/utils/constants/sizes.dart';
import 'package:waffir/utils/device/device_utility.dart';
class OnBoardingDotNavigation extends StatelessWidget {
  const OnBoardingDotNavigation({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
final controller = OnBoardingController.instance;

    return Positioned(
     bottom: TDeviceUtils.getBottomNavigationBarHeight()+25,
     left:TSizes.defaultSpace,
    
     child: SmoothPageIndicator(
      controller: controller.pageController , 
      onDotClicked: controller.dotNavigationClick,
       count:3, 
        effect: const ExpandingDotsEffect(activeDotColor: TColors.secondary, dotHeight:6)));
  }
}

