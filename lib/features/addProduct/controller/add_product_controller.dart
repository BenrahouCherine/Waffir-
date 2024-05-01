import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:waffir/features/addProduct/model/product.dart';
import 'package:waffir/utils/constants/colors.dart';

class AddProductController extends GetxController {
  FirebaseStorage storage = FirebaseStorage.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Rx<ProductModel> product = ProductModel(
    category: '',
    description: '',
    img: '',
    price: 0,
    market: '',
    quantity: '',
    sellerUid: '',
    name: '',
  ).obs;

  Future<void> addProduct() async {
    try {
      Reference ref = storage.ref().child('product/${product.value.img}');
      UploadTask uploadTask = ref.putFile(File(product.value.img));
      TaskSnapshot snapshot = await uploadTask;
      String downloadURL = await snapshot.ref.getDownloadURL();

      product.update((val) {
        val!.img = downloadURL;
      });

      CollectionReference collectionReference = firestore.collection('product');
      await collectionReference.add(product.value.toMap());

      Get.snackbar(
        'Produit ajouté',
        'Votre produit a été ajouté',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.lightGreen,
        colorText: TColors.white,
        icon: const Icon(Icons.check),
        margin: const EdgeInsets.all(10),
      );
    } catch (e) {
      printError(info: e.toString());
    }
  }
}
