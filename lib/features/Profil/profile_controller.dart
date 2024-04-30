

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class ProfileController extends GetxController{
  @override
  void onInit() {
    getUser();
    super.onInit();
  }
  String userFetchedFirst="";
  String? validated="Non-verified";
  String? userFetchedLast;
  String? userNature;
  String? phone;
  String? userFetched;
  String? photo_URL;
  RxBool userLoading = true.obs;
  Rx<XFile> profilePicture = XFile('').obs;

  FirebaseAuth auth=FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
   FirebaseStorage _storage = FirebaseStorage.instance;


  getUser() {
    userLoading.value = true;
    final currentUser = auth.currentUser;
    CollectionReference users = firestore.collection('userDetail');

    users.where('uid',isEqualTo: currentUser?.uid.toString()).get()
        .then((QuerySnapshot snapshot) {
      snapshot.docs.forEach((doc) {
        userNature=doc["userNature"];
        userFetchedFirst=doc["firstname"];
        userFetchedLast=doc["lastname"];
         phone=doc["phone"];
        userFetched=doc["username"];
        photo_URL = doc['photo_URL'];

        print('userFetched is equal to ');

        update();
      });
    })
        .catchError((error) => print("Failed to fetch users: $error"));
    print('userFetched is  ');
    update();
    userLoading.value = false;

  }


  Future<void> modifyUser() async {
    String fileName = DateTime.now().millisecondsSinceEpoch.toString();
    Reference reference = _storage.ref().child('profilePictures/$fileName');
    UploadTask uploadTask = reference.putFile(
      File(profilePicture.value.path),
    );
    TaskSnapshot storageTaskSnapshot = await uploadTask;
    String photoURL = await storageTaskSnapshot.ref.getDownloadURL();
  }
//test@gmail.com azert1234

}