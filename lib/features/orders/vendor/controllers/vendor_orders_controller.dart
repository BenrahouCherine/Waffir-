import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:waffir/features/Profil/profile_controller.dart';
import 'package:waffir/features/orders/client/models/order.dart';

class VendorOrdersController extends GetxController {
  RxList<OrderModel> vendorOrders = <OrderModel>[].obs;
  final profileController = Get.find<ProfileController>();
  RxBool isLoading = false.obs;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  void onInit() {
    fetchVendorOrders();
    super.onInit();
  }

  Future fetchVendorOrders() async {
    try {
      isLoading.value = true;
      firestore
          .collection('orders')
          .where('seller_uid', isEqualTo: profileController.user.value.uid)
          .snapshots()
          .listen((event) {
        vendorOrders.clear();
        for (var doc in event.docs) {
          vendorOrders.add(OrderModel.fromQuerySnapshot(doc));
        }
      });
    } catch (e) {
      print(e);
    } finally {
      isLoading.value = false;
    }
  }

  Future updateOrderStatus(String orderId, String status) async {
    try {
      await firestore
          .collection('orders')
          .doc(orderId)
          .update({'status': status});

      Get.snackbar('Succès', 'Statut de la commande mis à jour avec succès',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
          icon: const Icon(
            Icons.check_circle_outline,
            color: Colors.white,
            size: 30,
          ));

      await fetchVendorOrders();
    } catch (e) {
      print(e);
    }
  }

  Future deleteOrder(String orderId) async {
    try {
      await firestore.collection('orders').doc(orderId).delete();
      Get.back();
      Get.back();
      Get.snackbar('Succès', 'Commande supprimée avec succès',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
          icon: const Icon(
            Icons.check_circle_outline,
            color: Colors.white,
            size: 30,
          ));
      await fetchVendorOrders();
    } catch (e) {
      print(e);
    }
  }
}
