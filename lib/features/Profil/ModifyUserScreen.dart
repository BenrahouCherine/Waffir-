import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:waffir/features/Profil/profile_controller.dart';
import 'package:waffir/utils/constants/colors.dart';
import 'package:waffir/utils/constants/sizes.dart';
import 'package:waffir/utils/constants/text_strings.dart';

import '../authentification/screens/login/login.dart';

class ModifyUserScreen extends StatefulWidget {
  const ModifyUserScreen({super.key});

  @override
  _CreateAccountState createState() => _CreateAccountState();
}

class _CreateAccountState extends State<ModifyUserScreen> {
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
  Widget build(BuildContext context) {
    ProfileController profileController = Get.find();
    _userController.text = profileController.user.value.username.toString();
    _lastController.text = profileController.user.value.lastName.toString();
    _firstController.text = profileController.user.value.firstName.toString();
    _phoneController.text = profileController.user.value.phone.toString();

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
        ));
  }

  Future _modify() async {
    String user = FirebaseAuth.instance.currentUser!.uid;
    String firstname = _firstController.text;
    String lastname = _lastController.text;
    String username = _userController.text;
    String phone = _phoneController.text;

    Map<String, dynamic> userDetail = {
      'uid': user,
      'firstname': firstname,
      'lastname': lastname,
      'phone': phone,
    };
    log('entry request of');
    CollectionReference collectionReference =
        FirebaseFirestore.instance.collection('userDetail');
    log('mid request of');
    log(firstname);
    log(username);
    log(phone);
    collectionReference.doc(username).update(userDetail).then(
        (value) => log('succesfully modify'),
        onError: (e) => log("error type $e"));
    log('back request of');
    _showDialogAlert(context);
  }

  void _showDialogAlert(BuildContext Context) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Colors.amberAccent,
            title: const Text('Modify State Alert'),
            content:
                const Text('Your profile has been updated, you need to log in'),
            actions: <Widget>[
              TextButton(
                  onPressed: () {
                    FirebaseAuth.instance.signOut();
                    Get.offAll(() => LoginScreen());
                  },
                  child: const Text(TTexts.tContinue))
            ],
          );
        });
  }
}
