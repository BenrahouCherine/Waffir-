import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:waffir/features/Profil/profile_controller.dart';
import 'package:waffir/utils/constants/colors.dart';
import 'package:waffir/utils/constants/sizes.dart';
import 'package:waffir/utils/constants/text_strings.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({super.key});

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  final _emailController = TextEditingController();
  final profileController = Get.find<ProfileController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TColors.primary,
      appBar: AppBar(),
      body: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                TTexts.forgetPassword,
                style: Theme.of(context)
                    .textTheme
                    .headlineMedium
                    ?.copyWith(color: TColors.secondary),
              ),
              const SizedBox(
                height: TSizes.spaceBtwItems,
              ),
              Text(TTexts.forgetPasswordSubTitle,
                  style: Theme.of(context).textTheme.labelMedium),
              const SizedBox(
                height: TSizes.spaceBtwSections * 2,
              ),
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(
                    labelText: TTexts.email,
                    prefixIcon: Icon(
                      Iconsax.direct_right,
                      color: TColors.secondary,
                    )),
              ),
              const SizedBox(
                height: TSizes.spaceBtwSections,
              ),
              SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                      onPressed: () async => await profileController
                          .resetPassword(_emailController.text),
                      child: const Text(TTexts.submit)))
            ],
          )),
    );
  }
}
