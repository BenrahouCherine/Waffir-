// ignore_for_file: non_constant_identifier_names

import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:waffir/features/Profil/profile_controller.dart';
import 'package:waffir/features/cart/controllers/cart_controller.dart';
import 'package:waffir/features/cart/models/cart_item.dart';
import 'package:waffir/features/decouvrir/controllers/decouvrir_controller.dart';
import 'package:waffir/features/orders/client/models/order.dart';
import 'package:waffir/features/orders/client/models/order_item.dart';
import 'package:waffir/features/orders/client/screens/order_error_screen.dart';
import 'package:waffir/features/orders/client/screens/order_success_screen.dart';

class OrderController extends GetxController {
  CartController cartController = Get.find<CartController>();
  ProfileController authController = Get.find<ProfileController>();
  DecouvrirController decouvrirController = Get.find<DecouvrirController>();
  RxList<OrderModel> userOrders = <OrderModel>[].obs;
  RxBool isLoading = false.obs;

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  void onInit() {
    fetchUserOrders();
    super.onInit();
  }

  @override
  void onClose() {
    userOrders.clear();
    super.onClose();
  }

  Future<void> makeOrder(
      String adresse, String wilaya, String daira, String commune) async {
    try {
      isLoading.value = true;

      Map<String, List<CartItem>> groupedItems = {};
      for (var item in cartController.cartItems) {
        String? sellerUid = item.product.sellerUid;
        if (!groupedItems.containsKey(sellerUid)) {
          groupedItems[sellerUid] = [];
        }
        groupedItems[sellerUid]?.add(item);
      }

      // Create an order for each group
      for (var entry in groupedItems.entries) {
        List<OrderItem> orderItems = entry.value
            .map((item) => OrderItem(
                  order_uid: entry.value.first.product.sellerUid,
                  product_uid: item.product.uid!,
                  quantity: item.quantity.toString(),
                  prix_total: item.product.price * item.quantity,
                  created_at: DateTime.now().toIso8601String(),
                  updated_at: DateTime.now().toIso8601String(),
                  product: item.product,
                ))
            .toList();

        // Decrease the quantity of each product
        for (var item in orderItems) {
          final docRef = firestore.collection('product').doc(item.product.uid);
          final doc = await docRef.get();
          final currentQuantity = int.parse(doc.data()?['quantity'] ?? '0');
          final newQuantity = currentQuantity - int.parse(item.quantity);

          if (newQuantity >= 0) {
            await docRef.update({'quantity': newQuantity.toString()});
          }
        }

        // Create the order
        OrderModel order = OrderModel(
          buyer_uid: authController.user.value.uid,
          seller_uid: entry.key,
          status: 'pending',
          adresse: adresse,
          wilaya: wilaya,
          daira: daira,
          commune: commune,
          created_at: DateTime.now().toIso8601String(),
          updated_at: DateTime.now().toIso8601String(),
          orderItems: orderItems,
          buyer: authController.user.value,
          seller: authController.user.value,
        );

        await FirebaseFirestore.instance
            .collection('orders')
            .add(order.toMap());
      }

      cartController.cartItems.clear();
      Get.to(() => const OrderSuccessScreen());
      await decouvrirController.fetchProducts();
    } catch (e) {
      if (kDebugMode) {
        log(e.toString());
      }
      Get.to(() => const OrderErrorScreen());
    } finally {
      isLoading.value = false;
    }
  }

  // FETCH ALL ORDERS FOR THE CURRENT USER AS A BUYER
  Future<void> fetchUserOrders() async {
    try {
      isLoading.value = true;
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await FirebaseFirestore.instance
              .collection('orders')
              .where(
                'buyer_uid',
                isEqualTo: FirebaseAuth.instance.currentUser!.uid,
              )
              .get();

      userOrders.value = querySnapshot.docs
          .map((doc) => OrderModel.fromQuerySnapshot(doc))
          .toList();
    } catch (e) {
      if (kDebugMode) {
        log(e.toString());
      }
    } finally {
      isLoading.value = false;
    }
  }
}
