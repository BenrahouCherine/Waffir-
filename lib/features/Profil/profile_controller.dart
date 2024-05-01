// ignore_for_file: avoid_print

import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:waffir/features/Profil/models/user.dart';

class ProfileController extends GetxController {
  @override
  void onInit() {
    getUser();
    super.onInit();
    ever(user, (_) {
      log(user.value.toString());
      update();
    });
  }

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

  getUser() {
    userLoading.value = true;
    final currentUser = auth.currentUser;
    CollectionReference users = firestore.collection('userDetail');

    users
        .where('uid', isEqualTo: currentUser?.uid.toString())
        .get()
        .then((QuerySnapshot snapshot) {
      if (snapshot.docs.isNotEmpty) {
        var doc = snapshot.docs.first;
        user.value = UserModel.fromQueryDocumentSnapshot(doc);
        log(user.value.toString());
        update();
      }
    }).catchError((error) => log("Failed to fetch users: $error"));
    update();
    userLoading.value = false;
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
}
