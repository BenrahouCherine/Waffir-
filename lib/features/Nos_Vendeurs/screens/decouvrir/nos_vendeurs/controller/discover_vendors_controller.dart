import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:waffir/features/Profil/models/user.dart';

class DiscoverVendorsController extends GetxController {
  RxList<UserModel> vendors = <UserModel>[].obs;
  RxInt productsCount = 0.obs;
  RxBool isLoading = false.obs;

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  void onInit() {
    fetchVendors();
    super.onInit();
  }

  Future fetchVendors() async {
    try {
      isLoading.value = true;
      QuerySnapshot querySnapshot = await firestore
          .collection("userDetail")
          .where("userNature", isEqualTo: "Seller")
          .get();

      for (var doc in querySnapshot.docs) {
        vendors.add(UserModel.fromQueryDocumentSnapshot(doc));
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
