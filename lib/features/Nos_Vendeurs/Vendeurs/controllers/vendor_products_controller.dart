import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
      print("Failed to fetch users: $error");
    } finally {
      isLoading.value = false;
    }
  }
}
