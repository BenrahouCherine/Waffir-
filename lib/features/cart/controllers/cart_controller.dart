import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:waffir/features/addProduct/model/product.dart';
import 'package:waffir/features/cart/models/cart_item.dart';

class CartController extends GetxController {
  RxDouble total = 0.0.obs;
  RxList<CartItem> cartItems = RxList<CartItem>();

  @override
  void onInit() {
    super.onInit();
    calculateTotal();
  }

  void calculateTotal() {
    total.value = cartItems.fold(
        0, (sum, item) => sum + item.product.price * item.quantity);
  }

  void addItem(ProductModel product, int quantity) {
    int index = cartItems.indexWhere((item) => item.product.uid == product.uid);
    if (index != -1) {
      cartItems[index].quantity++;
      Get.snackbar(
          'Info', '${product.name} est déjà présent dans votre panier!',
          backgroundColor: Colors.green);
    } else {
      cartItems.add(CartItem(product: product, quantity: quantity));

      Get.snackbar('Success', '${product.name} a été ajouté à votre panier!',
          backgroundColor: Colors.green);
    }
    calculateTotal();
  }

  void removeItem(ProductModel product) {
    cartItems.removeWhere((item) => item.product.uid == product.uid);
    calculateTotal();
  }

  void incrementQuantity(ProductModel product) {
    int index = cartItems.indexWhere((item) => item.product.uid == product.uid);
    if (index != -1) {
      cartItems[index].quantity++;
    }
    calculateTotal();
  }

  void decrementQuantity(ProductModel product) {
    int index = cartItems.indexWhere((item) => item.product.uid == product.uid);
    if (index != -1 && cartItems[index].quantity > 1) {
      cartItems[index].quantity--;
    }
    calculateTotal();
  }

  int getCartItemQuantity(ProductModel product) {
    int index = cartItems.indexWhere((item) => item.product.uid == product.uid);
    if (index != -1) {
      return cartItems[index].quantity;
    } else {
      return 0;
    }
  }

  @override
  void onClose() {
    cartItems.clear();
    total.value = 0.0;
  }
}
