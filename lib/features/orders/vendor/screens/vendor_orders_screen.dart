import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:waffir/features/orders/vendor/controllers/vendor_orders_controller.dart';
import 'package:waffir/features/orders/vendor/screens/order_card.dart';
import 'package:waffir/utils/constants/colors.dart';

class VendorOrdersScreen extends StatefulWidget {
  const VendorOrdersScreen({super.key});

  @override
  State<VendorOrdersScreen> createState() => _VendorOrdersScreenState();
}

class _VendorOrdersScreenState extends State<VendorOrdersScreen> {
  final vendorOrdersController = Get.put(VendorOrdersController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TColors.primary,
      appBar: AppBar(
        title: const Text(
          'Commandes',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Obx(() {
        return vendorOrdersController.isLoading.value
            ? const Center(child: CircularProgressIndicator())
            : Container(
                padding: const EdgeInsets.all(8.0),
                child: ListView.separated(
                  separatorBuilder: (context, index) => const SizedBox(
                    height: 10,
                  ),
                  itemCount: vendorOrdersController.vendorOrders.length,
                  itemBuilder: (context, index) {
                    return OrderCard(
                      isSeller: true,
                      order: vendorOrdersController.vendorOrders[index],
                    );
                  },
                ),
              );
      }),
    );
  }
}
