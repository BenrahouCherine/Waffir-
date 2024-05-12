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

  void addItem(ProductModel product, int quantity) async {
    int index = cartItems.indexWhere((item) => item.product.uid == product.uid);
    if (index != -1) {
      if (cartItems[index].quantity + quantity <= int.parse(product.quantity)) {
        cartItems[index].quantity += quantity;

        Get.snackbar(
            'Info', '${product.name} est déjà présent dans votre panier!',
            backgroundColor: Colors.green, colorText: Colors.white);
      } else {
        Get.snackbar('Error',
            'Vous avez atteint la quantité maximale pour ${product.name}!',
            backgroundColor: Colors.red, colorText: Colors.white);
      }
    } else {
      if (quantity <= int.parse(product.quantity)) {
        cartItems.add(CartItem(product: product, quantity: quantity));

        Get.snackbar('Success', '${product.name} a été ajouté à votre panier!',
            backgroundColor: Colors.green, colorText: Colors.white);
      } else {
        Get.snackbar('Error',
            'Vous avez atteint la quantité maximale pour ${product.name}!',
            backgroundColor: Colors.red, colorText: Colors.white);
      }
    }
    calculateTotal();
  }

  void removeItem(ProductModel product) async {
    cartItems.removeWhere((item) => item.product.uid == product.uid);
    calculateTotal();
  }

  void incrementQuantity(ProductModel product) async {
    int index = cartItems.indexWhere((item) => item.product.uid == product.uid);
    if (index != -1) {
      if (cartItems[index].quantity < int.parse(product.quantity)) {
        cartItems[index].quantity++;
      } else {
        Get.snackbar('Error',
            'Vous avez atteint la quantité maximale pour ${product.name}!',
            backgroundColor: Colors.red, colorText: Colors.white);
      }
    }
    calculateTotal();
  }

  void decrementQuantity(ProductModel product) async {
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
