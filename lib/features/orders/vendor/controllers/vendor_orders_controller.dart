import 'package:cloud_firestore/cloud_firestore.dart';
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
}
