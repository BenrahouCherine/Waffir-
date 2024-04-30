import 'package:flutter/material.dart';
import 'package:waffir/features/authentification/controlers/onboarding_controller.dart';
import 'package:waffir/utils/constants/sizes.dart';
import 'package:waffir/utils/device/device_utility.dart';


class OnBoardingSkip extends StatelessWidget {
  const OnBoardingSkip({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(top:TDeviceUtils.getAppBarHeight(),right:TSizes.defaultSpace,  child:TextButton(onPressed: ()=> OnBoardingController.instance.skipPage(), child: const Text(
    'Passer',
    style: TextStyle(color: Color.fromARGB(210, 255, 255, 255)),  // Remplacez `Colors.red` par la couleur de votre choix
  ),
         
       ));
  }
}


