import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:waffir/features/addProduct/model/product.dart';

class FavController extends GetxController {
  List<ProductModel> favProducts = <ProductModel>[].obs;

  FirebaseAuth auth = FirebaseAuth.instance;

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  void onInit() {
    // fetch favs
    fetchFavProducts();
    super.onInit();
  }

  Future fetchFavProducts() async {
    try {
      User? currentUser = auth.currentUser;
      if (currentUser != null) {
        QuerySnapshot querySnapshot = await firestore
            .collection('userDetail')
            .doc(currentUser.uid)
            .collection('favoriteProducts')
            .get();
        var products = querySnapshot.docs
            .map((doc) => ProductModel.fromQuerySnapshot(doc))
            .toList();
        favProducts.assignAll(products);
      }
    } catch (e) {
      log(e.toString());
    }
  }

  Future addFavProduct(ProductModel product) async {
    try {
      User? currentUser = auth.currentUser;
      await firestore
          .collection('userDetail')
          .doc(currentUser!.uid)
          .collection('favoriteProducts')
          .doc(product.uid)
          .set(product.toMap());
      favProducts.add(product);
    } catch (e) {
      log(e.toString());
    }
  }

  Future removeFavProduct(ProductModel product) async {
    try {
      User? currentUser = auth.currentUser;
      if (currentUser != null) {
        await firestore
            .collection('userDetail')
            .doc(currentUser.uid)
            .collection('favoriteProducts')
            .doc(product.uid)
            .delete();

        favProducts.removeWhere((element) => element.uid == product.uid);
      }
    } catch (e) {
      log(e.toString());
    }
  }
}
