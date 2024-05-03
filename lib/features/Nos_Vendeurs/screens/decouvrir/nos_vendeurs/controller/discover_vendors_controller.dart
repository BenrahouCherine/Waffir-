import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:waffir/features/Profil/models/user.dart';

class DiscoverVendorsController extends GetxController {
  RxList<UserModel> vendors = <UserModel>[].obs;
  RxBool isLoading = false.obs;

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<int> countProducts(String vendorId) async {
    try {
      QuerySnapshot querySnapshot = await firestore
          .collection("product")
          .where("seller_uid", isEqualTo: vendorId)
          .get();
      return querySnapshot.docs.length;
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      return 0;
    }
  }

  Future fetchVendors() async {
    try {
      vendors.clear();
      isLoading.value = true;
      QuerySnapshot querySnapshot = await firestore
          .collection("userDetail")
          .where("userNature", isEqualTo: "Seller")
          .get();

      for (var doc in querySnapshot.docs) {
        UserModel vendor = UserModel.fromQueryDocumentSnapshot(doc);
        vendor.productsCount = await countProducts(vendor.uid);
        vendors.add(vendor);
      }
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    } finally {
      isLoading.value = false;
    }
  }
}
