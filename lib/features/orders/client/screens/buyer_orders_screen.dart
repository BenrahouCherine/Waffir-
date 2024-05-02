import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:waffir/features/orders/client/controllers/order_controller.dart';
import 'package:waffir/features/orders/vendor/screens/order_card.dart';
import 'package:waffir/utils/constants/colors.dart';

class BuyerOrdersScreen extends StatefulWidget {
  const BuyerOrdersScreen({super.key});

  @override
  State<BuyerOrdersScreen> createState() => _BuyerOrdersScreenState();
}

class _BuyerOrdersScreenState extends State<BuyerOrdersScreen> {
  final buyerOrdersController = Get.put(OrderController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TColors.primary,
      appBar: AppBar(
        title: const Text('Commandes'),
      ),
      body: Obx(() {
        return buyerOrdersController.isLoading.value
            ? const Center(child: CircularProgressIndicator())
            : buyerOrdersController.userOrders.isEmpty
                ? const Center(
                    child: Text(
                    'Vous n\'avez pas encore de commandes',
                    style: TextStyle(color: TColors.white),
                  ))
                : Container(
                    padding: const EdgeInsets.all(8.0),
                    child: ListView.separated(
                      separatorBuilder: (context, index) => const SizedBox(
                        height: 10,
                      ),
                      itemCount: buyerOrdersController.userOrders.length,
                      itemBuilder: (context, index) {
                        return OrderCard(
                          isSeller: false,
                          order: buyerOrdersController.userOrders[index],
                        );
                      },
                    ),
                  );
      }),
    );
  }
}
