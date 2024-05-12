import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:waffir/features/addProduct/model/product.dart';

class DecouvrirController extends GetxController {
  RxList<ProductModel> products = <ProductModel>[].obs;
  final carouselCurrentIndex = 0.obs;
  RxBool isLoading = false.obs;
  RxString filterCategory = "Tout".obs;

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  void onInit() {
    fetchProducts();
    ever(filterCategory, (_) => fetchProducts());
    super.onInit();
  }

  void updatePageIndicator(index) {
    carouselCurrentIndex.value = index;
  }

  Future<void> fetchProducts() async {
    try {
      isLoading.value = true;
      QuerySnapshot querySnapshot;

      if (filterCategory.value != "Tout") {
        querySnapshot = await firestore
            .collection('product')
            .where('category', isEqualTo: filterCategory.value)
            .get();
      } else {
        querySnapshot = await firestore.collection('product').get();
      }
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
