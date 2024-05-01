// ignore_for_file: avoid_print, no_leading_underscores_for_local_identifiers

import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:waffir/common/styles/spacing_styles.dart';
import 'package:waffir/features/authentification/controllers/oauth_controller.dart';
import 'package:waffir/features/authentification/screens/password_configuration/forget_password.dart';
import 'package:waffir/features/authentification/screens/signup.widgets/signup.dart';
import 'package:waffir/model/firebase_service.dart';
import 'package:waffir/navigation_menu.dart';
import 'package:waffir/utils/constants/colors.dart';
import 'package:waffir/utils/constants/image_strings.dart';
import 'package:waffir/utils/constants/sizes.dart';
import 'package:waffir/utils/constants/text_strings.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FirebaseAuthService _auth = FirebaseAuthService();
  bool _hidden = true;

  OauthController oauthController = Get.put(OauthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: TColors.primary,
        body: SingleChildScrollView(
          child: Padding(
              padding: TSpacingStyle.paddingWithAppBarHeight,
              child: Column(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Align(
                        alignment: Alignment.topLeft,
                        child: Image(
                          height: 120,
                          image: AssetImage(TImages.darkAppLogo),
                        ),
                      ),
                      const SizedBox(height: TSizes.lg),
                      Text(
                        TTexts.loginTitle,
                        style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                            color: TColors
                                .secondary), // Remplacez `Colors.red` par la couleur de votre choix
                      ),
                      const SizedBox(height: TSizes.sm),
                      Text(
                        TTexts.loginSubTitle,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                  Form(
                      child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: TSizes.spaceBtwSections),
                    child: Column(
                      children: [
                        TextFormField(
                          controller: _emailController,
                          decoration: const InputDecoration(
                            prefixIcon: Icon(
                              Iconsax.personalcard,
                              color: TColors.secondary,
                            ),
                            labelText: TTexts.email,
                          ),
                        ),
                        const SizedBox(height: TSizes.spaceBtwInputFields),
                        TextFormField(
                          obscureText: _hidden,
                          controller: _passwordController,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Iconsax.password_check,
                                color: TColors.secondary),
                            labelText: TTexts.password,
                            suffixIcon: IconButton(
                              icon: Icon(
                                _hidden ? Iconsax.eye_slash : Iconsax.eye,
                                color: TColors.secondary,
                              ),
                              onPressed: () {
                                setState(() {
                                  _hidden = !_hidden;
                                });
                              },
                            ),
                          ),
                        ),
                        const SizedBox(height: TSizes.spaceBtwInputFields / 2),
                        Row(
                          children: [
                            Checkbox(value: true, onChanged: (value) {}),
                            const Text(TTexts.rememberMe),
                          ],
                        ),
                        TextButton(
                          onPressed: () => Get.to(() => forgetPassword()),
                          child: const Text(
                            TTexts.forgetPassword,
                            style: TextStyle(
                                color: Color.fromARGB(210, 255, 255,
                                    255)), // Remplacez `Colors.red` par la couleur de votre choix
                          ),
                        ),
                        const SizedBox(height: TSizes.spaceBtwSections),
                        SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                                onPressed: () async => await _signIn(),
                                child: const Text(TTexts.signIn))),
                        const SizedBox(height: TSizes.spaceBtwItems),
                        SizedBox(
                            width: double.infinity,
                            child: OutlinedButton(
                                onPressed: () =>
                                    Get.to(() => const SignupScreen()),
                                child: const Text(TTexts.createAccount))),
                      ],
                    ),
                  )),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Flexible(
                          child: Divider(
                        color: Color.fromARGB(207, 0, 0, 0),
                        thickness: 0.5,
                        indent: 60,
                        endIndent: 5,
                      )),
                      Text(
                        TTexts.orSignInWith,
                      ),
                      Flexible(
                          child: Divider(
                        color: Color.fromARGB(207, 0, 0, 0),
                        thickness: 0.5,
                        indent: 5,
                        endIndent: 60,
                      )),
                    ],
                  ),
                  const SizedBox(height: TSizes.spaceBtwItems),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                          decoration: BoxDecoration(
                              border: Border.all(color: TColors.grey),
                              borderRadius: BorderRadius.circular(100)),
                          child: IconButton(
                              onPressed: () async {
                                await oauthController.signInWithGoogle();
                              },
                              icon: const Image(
                                width: TSizes.iconMd,
                                height: TSizes.iconMd,
                                image: AssetImage(TImages.google),
                              )))
                    ],
                  )
                ],
              )),
        ));
  }

  Future _signIn() async {
    String password = _passwordController.text;
    String email = _emailController.text;
    User? _user = await _auth.signInWithEmailAndPassword(email, password);

    if (_user != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Get.offAll(() => NavigationMenu());
      });
    }
  }

  void inContact(TapDownDetails details) {
    _hidden = false;
  }

  void outContact(TapUpDetails details) {
    _hidden = true;
  }
}
