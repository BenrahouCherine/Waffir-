import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:waffir/common/styles/shadow.dart';
import 'package:waffir/features/Nos_Vendeurs/screens/decouvrir/Vendeurs/controllers/vendor_products_controller.dart';
import 'package:waffir/utils/constants/colors.dart';

class Vend extends StatelessWidget {
  Vend({super.key});

  final vendorController = Get.put(VendorProductsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TColors.primary,
      appBar: AppBar(
        title: Text('Mes Produits',
            style: Theme.of(context)
                .textTheme
                .headlineMedium!
                .apply(color: TColors.white)),
      ),
      body: Obx(() {
        if (vendorController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        } else {
          return GridView.builder(
            padding: const EdgeInsets.all(10),
            itemCount: vendorController.vendorProducts.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.75, // Aspect ratio of each item
            ),
            itemBuilder: (context, index) => Container(
              margin: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [ShadowStyle.verticalProductShadow],
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15),
                      ),
                      child: Image.network(
                        vendorController.vendorProducts[index].img,
                        fit: BoxFit.fill,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Text(
                        vendorController.vendorProducts[index].name,
                        style: const TextStyle(color: Colors.black),
                      ),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Text(
                        '${vendorController.vendorProducts[index].price} DA',
                        style: const TextStyle(color: Colors.black),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }
      }),
    );
  }
}
