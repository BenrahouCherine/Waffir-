import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:waffir/features/Nos_Vendeurs/Vendeurs/controllers/vendor_products_controller.dart';
import 'package:waffir/features/addProduct/model/product.dart';
import 'package:waffir/utils/constants/colors.dart';

class AddProductController extends GetxController {
  FirebaseStorage storage = FirebaseStorage.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  final vendorProductsController = Get.find<VendorProductsController>();

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

  RxBool isLoading = false.obs;

  Future<void> addProduct() async {
    try {
      isLoading.value = true;
      Reference ref = storage.ref().child('product/${product.value.img}');
      UploadTask uploadTask = ref.putFile(File(product.value.img));
      TaskSnapshot snapshot = await uploadTask;
      String downloadURL = await snapshot.ref.getDownloadURL();

      product.update((val) {
        val!.img = downloadURL;
      });

      CollectionReference collectionReference = firestore.collection('product');
      await collectionReference.add(product.value.toMap());

      vendorProductsController.fetchVendorProducts();

      Get.snackbar(
        'Produit ajouté',
        'Votre produit a été ajouté',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: TColors.white,
        icon: const Icon(Icons.check, color: TColors.white),
      );
    } catch (e) {
      printError(info: e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
