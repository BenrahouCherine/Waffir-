import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:waffir/features/cart/controllers/cart_controller.dart';
import 'package:waffir/features/cart/screens/cart_item_card.dart';
import 'package:waffir/features/orders/client/screens/checkout_screen.dart';
import 'package:waffir/utils/constants/colors.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  CartController cartController = Get.find<CartController>();

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.black,
      statusBarIconBrightness: Brightness.dark,
    ));
    return Scaffold(
      backgroundColor: TColors.primary,
      appBar: AppBar(
        elevation: 1,
        leading: const BackButton(color: Colors.white),
      ),
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.only(top: 8),
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: GetX<CartController>(
            builder: (controller) {
              if (controller.cartItems.isEmpty) {
                return const Center(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Votre panier est vide",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: Colors.white),
                    ),
                  ],
                ));
              }
              return Column(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Produits",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              color: Colors.white),
                        ),
                        Text(
                          "${controller.cartItems.length} produits",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.grey[100]),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: ListView.separated(
                      itemCount: controller.cartItems.length,
                      itemBuilder: (context, index) {
                        return CartItemCard(
                          cartItem: controller.cartItems[index],
                        );
                      },
                      separatorBuilder: (context, index) {
                        return const SizedBox(height: 10);
                      },
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Total",
                          style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w600,
                              color: Colors.white),
                        ),
                        Text(
                          "${controller.total.value} DA",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.grey[100]),
                        ),
                      ],
                    ),
                  ),
                  Container(
                      width: double.infinity,
                      padding: const EdgeInsets.only(
                          left: 12.0, right: 12.0, top: 12.0, bottom: 18.0),
                      child: ElevatedButton(
                        child: const Text("Commander"),
                        onPressed: () {
                          Get.to(() => const CheckoutScreen());
                        },
                      )),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
