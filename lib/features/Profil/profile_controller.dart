// ignore_for_file: avoid_print

import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:waffir/features/Profil/ModifyUserScreen.dart';
import 'package:waffir/features/Profil/models/user.dart';
import 'package:waffir/features/authentification/screens/login/login.dart';
import 'package:waffir/features/authentification/screens/password_configuration/reset_password.dart';
import 'package:waffir/features/authentification/screens/signup.widgets/verify_email.dart';
import 'package:waffir/features/map/services/geolocation_service.dart';
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
  RxString profilePicturePath = "".obs;

  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseStorage storage = FirebaseStorage.instance;
  GeoLocationService geoLocationService = Get.find<GeoLocationService>();

  @override
  void onInit() {
    ever(
      profilePicturePath,
      (_) async => {
        if (profilePicturePath.value != '') {await setProfilePic()}
      },
    );
    auth.authStateChanges().listen((User? usr) {
      if (usr != null) {
        getUser(usr.uid);
      } else {
        user.value = UserModel(
          uid: '',
          username: '',
          firstName: '',
          lastName: '',
          userNature: '',
          phone: '',
        );
      }
    });
    ever(user, (_) => log(user.value.firstName));

    super.onInit();
  }

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

  Future getUser(String uid) async {
    try {
      userLoading.value = true;

      CollectionReference users = firestore.collection('userDetail');
      await users
          .where('uid', isEqualTo: uid)
          .get()
          .then((QuerySnapshot snapshot) async {
        if (snapshot.docs.isNotEmpty) {
          var doc = snapshot.docs.first;
          await doc.reference
              .update({'location': geoLocationService.locationData});
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

  Future signUp(
      {required String firstName,
      required String lastName,
      required String username,
      required String email,
      required String password,
      required String phone,
      required String groupValue}) async {
    bool verification = false;

    UserCredential userCredential = await auth.createUserWithEmailAndPassword(
        email: email, password: password);
    String uid = userCredential.user!.uid;

    Map<String, dynamic> userDetail = {
      'uid': uid,
      'username': username,
      'firstname': firstName,
      'lastname': lastName,
      'phone': phone,
      'isvalidated': verification.toString(),
      'userNature': groupValue,
      'photo_URL':
          'https://www.pngitem.com/pimgs/m/146-1468479_my-profile-icon-blank-profile-picture-circle-hd.png',
      'location': geoLocationService.locationData,
    };
    CollectionReference collectionReference =
        FirebaseFirestore.instance.collection('userDetail');
    collectionReference.doc(username).set(userDetail);
    print(collectionReference);
    print(userDetail);
    FirebaseAuth.instance.currentUser!.sendEmailVerification();
    //  snack
    Get.snackbar(
      'Success',
      'Account created successfully. Please verify your email.',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.green,
      colorText: Colors.white,
      icon: const Icon(Icons.check_circle_outline_rounded, color: Colors.white),
    );
    Get.offAll(() => const VerifyEmailScreen());
  }

  Future signIn(String email, String password) async {
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);

      if (auth.currentUser?.emailVerified == false) {
        await auth.signOut();
        Get.snackbar(
          'Error',
          'Please verify your email first.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
          icon: const Icon(Icons.error_outline_rounded, color: Colors.white),
        );
        return;
      } else {
        await getUser(auth.currentUser!.uid);
        Get.snackbar(
          'Success',
          'Signed in successfully.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
          icon: const Icon(
            Icons.check_circle_outline_rounded,
            color: Colors.white,
          ),
        );
        Get.offAll(() => NavigationMenu());
      }
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

  Future setProfilePic() async {
    try {
      userLoading.value = true;

      String fileName = "${DateTime.now()}${auth.currentUser!.uid}";
      final reference = storage.ref().child('profilePictures/$fileName');
      await reference.putFile(File(profilePicturePath.value));
      String photoURL = await reference.getDownloadURL();

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
        getUser(currentUser!.uid);
        profilePicturePath.value = "";
      });
      Get.snackbar(
        'Success',
        'Profile picture updated successfully.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
        icon:
            const Icon(Icons.check_circle_outline_rounded, color: Colors.white),
      );
    } catch (e) {
      log(e.toString());
    } finally {
      userLoading.value = false;
    }
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

  Future verifyEmail() async {
    try {
      User? usr = auth.currentUser;
      if (usr != null && !usr.emailVerified) {
        await usr.sendEmailVerification();
        Get.snackbar(
          'Success',
          'Verification email sent. Please check your email.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
          icon: const Icon(Icons.check_circle_outline_rounded,
              color: Colors.white),
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to send verification email. Please try again.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        icon: const Icon(Icons.error_outline_rounded, color: Colors.white),
      );
    }
  }

  Future resendEmailVerification() async {
    try {
      User? usr = auth.currentUser;
      if (usr?.emailVerified == false) {
        await usr?.sendEmailVerification();
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to send verification email. Please try again.',
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
