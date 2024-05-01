import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:waffir/features/addProduct/model/product.dart';

class DecouvrirController extends GetxController {
  static DecouvrirController get instance => Get.find();

  RxList<ProductModel> products = <ProductModel>[].obs;
  final carouselCurrentIndex = 0.obs;
  RxBool isLoading = false.obs;

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  void onInit() {
    fetchProducts();
    super.onInit();
  }

  void updatePageIndicator(index) {
    carouselCurrentIndex.value = index;
  }

  Future<void> fetchProducts() async {
    try {
      isLoading.value = true;
      QuerySnapshot querySnapshot = await firestore.collection('product').get();
      var fetchedProducts = querySnapshot.docs.map((doc) {
        return ProductModel.fromQuerySnapshot(doc);
      }).toList();

      products.value = fetchedProducts;
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
