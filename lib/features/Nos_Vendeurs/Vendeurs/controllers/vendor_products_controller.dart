import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:waffir/features/addProduct/model/product.dart';

class VendorProductsController extends GetxController {
  RxList<ProductModel> vendorProducts = <ProductModel>[].obs;
  RxBool isLoading = false.obs;
  FirebaseAuth auth = FirebaseAuth.instance;

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  void onInit() {
    fetchVendorProducts();
    super.onInit();
  }

  Future fetchVendorProducts() async {
    try {
      isLoading.value = true;
      CollectionReference productCollection = firestore.collection('product');

      QuerySnapshot snapshot = await productCollection
          .where('seller_uid', isEqualTo: auth.currentUser!.uid)
          .get();
      if (snapshot.docs.isNotEmpty) {
        vendorProducts.clear();
        for (var element in snapshot.docs) {
          vendorProducts.add(ProductModel.fromQuerySnapshot(element));
        }
      }
    } catch (error) {
      if (kDebugMode) {
        print("Failed to fetch users: $error");
      }
    } finally {
      isLoading.value = false;
    }
  }

  Future deleteProduct(String productId) async {
    try {
      await firestore.collection('product').doc(productId).delete();
      vendorProducts.removeWhere((element) => element.uid == productId);
      await fetchVendorProducts();
    } catch (error) {
      if (kDebugMode) {
        print("Failed to delete product: $error");
      }
    }
  }

  Future modifyProduct(ProductModel product) async {
    try {
      isLoading.value = true;
      await firestore
          .collection('product')
          .doc(product.uid)
          .update(product.toMap());
      await fetchVendorProducts();
      Get.snackbar('Success', 'Product modified successfully',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
          icon: const Icon(Icons.check_circle_outline, color: Colors.white));
    } catch (e) {
      if (kDebugMode) {
        print("Failed to modify product: $e");
      }
    } finally {
      isLoading.value = false;
    }
  }

  Future<String?> uploadImage(File imageFile, String productId) async {
    try {
      isLoading.value = true;
      Reference storageReference =
          FirebaseStorage.instance.ref().child('product_images/$productId');

      UploadTask uploadTask = storageReference.putFile(imageFile);

      final TaskSnapshot downloadUrl = (await uploadTask);
      final String url = await downloadUrl.ref.getDownloadURL();

      return url;
    } catch (e) {
      if (kDebugMode) {
        print("Failed to upload image: $e");
      }
    } finally {
      isLoading.value = false;
    }
    return null;
  }
}
