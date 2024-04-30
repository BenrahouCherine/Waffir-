import 'package:flutter/material.dart';
import 'package:waffir/utils/constants/sizes.dart';
import 'package:waffir/utils/helppers/helper_functions.dart';
class OnBoardingPage extends StatelessWidget {
  const OnBoardingPage({
    super.key, required this.image, required this.title, required this.subTitle,
  });
final String image, title,subTitle ;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(TSizes.defaultSpace),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Image(
            width: THelperFunctions.screenWidth()*0.9,
            height: THelperFunctions.screenHeight() * 0.6,
            image: AssetImage(image),
          ),
          const SizedBox(height: TSizes.spaceBtwItems*0.05),
          Text(
            title,
            style: Theme.of(context).textTheme.headlineMedium,
            textAlign: TextAlign.left,
          ),
          const SizedBox(height: TSizes.spaceBtwItems),
          Text(
           subTitle,
            style: Theme.of(context).textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}