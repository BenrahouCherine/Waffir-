import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:waffir/features/orders/client/models/order.dart';
import 'package:waffir/features/orders/vendor/screens/order_details_screen.dart';

class OrderCard extends StatelessWidget {
  const OrderCard({super.key, required this.order, required this.isSeller});

  final OrderModel order;
  final bool isSeller;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        isSeller == true
            ? Get.to(() => OrderDetailsScreen(order: order))
            : null;
      },
      child: Container(
        padding: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25.0),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                spreadRadius: 1,
                blurRadius: 1,
                offset: const Offset(0, 1),
              ),
            ],
            color: Colors.grey[900]),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(
                    order.buyer!.photoURL!,
                  ),
                  radius: 25,
                ),
                const SizedBox(width: 10),
                SizedBox(
                  width: Get.width * 0.70,
                  child: Text(
                    "${order.buyer!.firstName} ${order.buyer!.lastName}",
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: Get.width * 0.70,
              child: Text(
                "${order.orderItems.length} produits achetés",
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w600),
              ),
            ),
            const SizedBox(height: 8),
            for (var item in order.orderItems)
              SizedBox(
                child: Row(
                  children: [
                    Text(
                      "${item.product.name} (x${item.quantity})",
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      "${item.prix_total} DA",
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
            const SizedBox(height: 16),
            Row(
              children: [
                const Icon(Icons.phone_outlined, color: Colors.white, size: 20),
                const SizedBox(width: 8),
                Text(order.buyer!.phone),
              ],
            ),
            const SizedBox(height: 8),
            SizedBox(
              child: Row(
                children: [
                  const Icon(Iconsax.truck, color: Colors.white, size: 25),
                  const SizedBox(width: 10),
                  SizedBox(
                    width: Get.width * 0.7,
                    child: Text(
                      "${order.adresse}, ${order.wilaya}, ${order.daira}, ${order.commune}",
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 13,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              children: [
                const Icon(Iconsax.status, color: Colors.white, size: 20),
                const SizedBox(width: 8),
                Text(
                  order.status,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w600),
                )
              ],
            ),
            const SizedBox(height: 20),
            SizedBox(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Total",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w600),
                  ),
                  Text(
                    "${order.orderItems.fold(0, (previousValue, element) => previousValue + element.prix_total)} DA",
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
