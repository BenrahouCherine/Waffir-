import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:waffir/features/Profil/profile_controller.dart';
import 'package:waffir/utils/constants/colors.dart';
import 'package:waffir/utils/constants/sizes.dart';

class ModifyUserScreen extends StatefulWidget {
  const ModifyUserScreen({super.key});

  @override
  State<ModifyUserScreen> createState() => _ModifyUserScreenState();
}

class _ModifyUserScreenState extends State<ModifyUserScreen> {
  String groupValue = "Seller";
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _firstController = TextEditingController();
  final TextEditingController _lastController = TextEditingController();
  final TextEditingController _userController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  @override
  void dispose() {
    _firstController.dispose();
    _lastController.dispose();
    _userController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _userController.text = profileController.user.value.username.toString();
    _lastController.text = profileController.user.value.lastName.toString();
    _firstController.text = profileController.user.value.firstName.toString();
    _phoneController.text = profileController.user.value.phone.toString();
    super.initState();
  }

  ProfileController profileController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TColors.primary,
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Modify user",
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(
                height: 38,
              ),
              Form(
                child: Column(
                  children: [
                    const SizedBox(height: 24),
                    TextFormField(
                      //expands: false,
                      controller: _firstController,
                      expands: false,
                      decoration: const InputDecoration(
                        prefixIcon:
                            Icon(Iconsax.user, color: TColors.secondary),
                      ),
                    ),
                    const SizedBox(height: 24),
                    TextFormField(
                      expands: false,
                      controller: _lastController,
                      decoration: const InputDecoration(
                        prefixIcon:
                            Icon(Iconsax.user, color: TColors.secondary),
                      ),
                    ),
                    const SizedBox(height: 24),
                    TextFormField(
                      //expands: false,
                      controller: _userController,
                      readOnly: true,
                      decoration: const InputDecoration(
                        prefixIcon:
                            Icon(Iconsax.user_edit, color: TColors.secondary),
                      ),
                    ),
                    const SizedBox(height: 24),
                    TextFormField(
                      expands: false,
                      controller: _phoneController,
                      decoration: const InputDecoration(
                        prefixIcon:
                            Icon(Iconsax.call, color: TColors.secondary),
                      ),
                    ),
                    const SizedBox(height: 58),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          _modify();
                        },
                        child: const Text('Modify user'),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 28,
              ),
              const SizedBox(height: 14),
            ],
          ),
        ),
      ),
    );
  }

  Future _modify() async {
    String user = FirebaseAuth.instance.currentUser!.uid;
    String firstname = _firstController.text;
    String lastname = _lastController.text;
    String username = _userController.text;
    String phone = _phoneController.text;

    Map<String, dynamic> userDetail = {
      'firstName': firstname,
      'lastName': lastname,
      'username': username,
      'phone': phone,
    };

    profileController.user.update((val) {
      val!.firstName = firstname;
      val.lastName = lastname;
      val.username = username;
      val.phone = phone;
    });

    CollectionReference collectionReference =
        FirebaseFirestore.instance.collection('userDetail');
    collectionReference.doc(user).update(userDetail).then((value) {
      Get.snackbar(
        'Success',
        'User modified successfully',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: TColors.white,
        icon: const Icon(Icons.check, color: TColors.white),
      );
    }, onError: (e) => log("error type $e"));
  }
}
