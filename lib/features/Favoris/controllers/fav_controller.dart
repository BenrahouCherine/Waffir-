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
    super.onInit();
  }

  Future fetchFavProducts() async {
    User? currentUser = auth.currentUser;
    if (currentUser != null) {
      QuerySnapshot querySnapshot = await firestore
          .collection('userDetail')
          .doc(currentUser.uid)
          .collection('favoriteProducts')
          .get();
      return querySnapshot.docs
          .map((doc) => ProductModel.fromQuerySnapshot(doc))
          .toList();
    } else {
      throw Exception('No user logged in');
    }
  }

  Future addFavProduct(ProductModel product) async {
    User? currentUser = auth.currentUser;
    if (currentUser != null) {
      await firestore
          .collection('userDetail')
          .doc(currentUser.uid)
          .collection('favoriteProducts')
          .doc(product.uid)
          .set(product
              .toMap()); // Convert the product to a map before setting it
    } else {
      throw Exception('No user logged in');
    }
  }
}
