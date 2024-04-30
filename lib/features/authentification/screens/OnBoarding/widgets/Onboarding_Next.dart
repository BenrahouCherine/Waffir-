import 'package:flutter/material.dart';
import 'package:waffir/features/authentification/controlers/onboarding_controller.dart';
import 'package:waffir/utils/constants/colors.dart';
import 'package:waffir/utils/constants/sizes.dart';
import 'package:iconsax/iconsax.dart';
import 'package:waffir/utils/device/device_utility.dart';


class OnBoardingNext extends StatelessWidget {
  const OnBoardingNext({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    
    return Positioned(
     right: TSizes.defaultSpace,
     bottom: TDeviceUtils.getBottomNavigationBarHeight(),
     child: ElevatedButton(
     onPressed:()=> OnBoardingController.instance.NextPage(), 
     style: ElevatedButton.styleFrom(shape : const CircleBorder() , backgroundColor: TColors.secondary),
     child: const Icon (Iconsax.arrow_right_3)));
  }
}