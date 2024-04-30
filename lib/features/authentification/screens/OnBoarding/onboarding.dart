import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:waffir/features/authentification/controlers/onboarding_controller.dart';

import 'package:waffir/features/authentification/screens/OnBoarding/widgets/Onboarding_Next.dart';
import 'package:waffir/features/authentification/screens/OnBoarding/widgets/Onboarding_dot.dart';
//import 'package:smooth_page_indicator/smooth_page_indicator.dart';


import 'package:waffir/features/authentification/screens/OnBoarding/widgets/onboarding_page.dart';
import 'package:waffir/features/authentification/screens/OnBoarding/widgets/onboarding_skip.dart';
import 'package:waffir/utils/constants/colors.dart';


import 'package:waffir/utils/constants/image_strings.dart';
import 'package:waffir/utils/constants/text_strings.dart';
//import 'package:waffir/utils/constants/sizes.dart';
//import 'package:waffir/utils/constants/sizes.dart';

/*import 'package:waffir/utils/constants/text_strings.dart';
import 'package:waffir/utils/device/device_utility.dart';
//import 'package:waffir/utils/device/device_utility.dart';*/


class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OnBoardingController());
    return Scaffold(
      backgroundColor: TColors.primary, // Change this to your desired color
      body: Stack(
        children: [
          PageView( 
             controller:controller.pageController,
             onPageChanged: controller.updatePageIndicator,
            children: const [
              OnBoardingPage(image: TImages.onBoardingImage1,
              title: TTexts.onBoardingTitle1,
               subTitle: "",),
                OnBoardingPage(image: TImages.onBoardingImage2,
              title: TTexts.onBoardingTitle2,
               subTitle: "",),
                OnBoardingPage(image: TImages.onBoardingImage3,
              title: TTexts.onBoardingTitle3,
               subTitle: "",),
               
            ],
          ),
           const OnBoardingSkip(),
           const OnBoardingDotNavigation(),
           const OnBoardingNext(),
        ],
      ),
    );
  }
}








