// ignore_for_file: avoid_print

import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:waffir/features/Profil/ModifyUserScreen.dart';
import 'package:waffir/features/Profil/models/user.dart';
import 'package:waffir/features/authentification/screens/login/login.dart';
import 'package:waffir/features/authentification/screens/password_configuration/reset_password.dart';
import 'package:waffir/features/orders/client/screens/buyer_orders_screen.dart';
import 'package:waffir/navigation_menu.dart';

class ProfileController extends GetxController {
  Rx<UserModel> user = UserModel(
    uid: '',
    username: '',
    firstName: '',
    lastName: '',
    userNature: '',
    phone: '',
  ).obs;
  RxBool userLoading = true.obs;
  Rx<XFile?> profilePicture = XFile('').obs;

  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseStorage storage = FirebaseStorage.instance;

  @override
  void onClose() {
    user.value = UserModel(
        uid: '',
        username: '',
        firstName: '',
        lastName: '',
        userNature: '',
        phone: '',
        photoURL: '',
        productsCount: 0);
    super.onClose();
  }

  Future signIn(String email, String password) async {
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
      getUser();
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Get.offAll(() => NavigationMenu());
      });
    } catch (e) {
      log(e.toString());
      Get.snackbar(
        'Error',
        'Failed to sign in. Please check your email and password.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        icon: const Icon(Icons.error_outline_rounded, color: Colors.white),
      );
    }
  }

  Future getUser() async {
    try {
      userLoading.value = true;
      final currentUser = auth.currentUser;
      CollectionReference users = firestore.collection('userDetail');
      await users
          .where('uid', isEqualTo: currentUser?.uid.toString())
          .get()
          .then((QuerySnapshot snapshot) {
        if (snapshot.docs.isNotEmpty) {
          var doc = snapshot.docs.first;
          user.value = UserModel.fromQueryDocumentSnapshot(doc);
          update();
        }
      });
    } catch (e) {
      log("Failed to fetch users: $e");
    } finally {
      userLoading.value = false;
    }
  }

  Future<void> setProfilePic() async {
    userLoading.value = true;
    String fileName = DateTime.now().millisecondsSinceEpoch.toString();
    Reference reference = storage.ref().child('profilePictures/$fileName');
    UploadTask uploadTask = reference.putFile(
      File(profilePicture.value!.path),
    );
    TaskSnapshot storageTaskSnapshot = await uploadTask;
    String photoURL = await storageTaskSnapshot.ref.getDownloadURL();
    // modify collection and add photo_URL
    CollectionReference users = firestore.collection('userDetail');
    final currentUser = auth.currentUser;
    users
        .where('uid', isEqualTo: currentUser?.uid.toString())
        .get()
        .then((QuerySnapshot snapshot) {
      if (snapshot.docs.isNotEmpty) {
        var doc = snapshot.docs.first;
        doc.reference.update({'photo_URL': photoURL});
      }
      getUser();
      userLoading.value = false;
    }).catchError((error) => log("Failed to fetch users: $error"));
  }

  Future signOut() async {
    await FirebaseAuth.instance.signOut();
    user.value = UserModel(
      uid: '',
      username: '',
      firstName: '',
      lastName: '',
      userNature: '',
      phone: '',
      photoURL: '',
      productsCount: 0,
    );
    Get.offAll(() => const LoginScreen());
  }

  Future resetPassword(String email) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email.trim());
      // snack
      Get.snackbar(
        'Success',
        'Password reset email sent. Please check your email.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
        icon:
            const Icon(Icons.check_circle_outline_rounded, color: Colors.white),
      );
      Get.offAll(() => const ResetPassword());
    } on FirebaseAuthException catch (e) {
      print(e);
      //  snack
      Get.snackbar(
        'Error',
        'Failed to send password reset email. Please check your email.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        icon: const Icon(Icons.error_outline_rounded, color: Colors.white),
      );
    }
  }

  void modifyTaped() {
    Get.to(() => const ModifyUserScreen());
  }

  void ordersTaped() {
    Get.to(() => const BuyerOrdersScreen());
  }
}
