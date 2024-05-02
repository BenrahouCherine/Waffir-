import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:waffir/features/Nos_Vendeurs/Vendeurs/controllers/vendor_products_controller.dart';
import 'package:waffir/features/Nos_Vendeurs/Vendeurs/modifier_produit.dart';
import 'package:waffir/features/addProduct/screens/AddProduct.dart';
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
        actions: [
          Container(
              margin: const EdgeInsets.only(right: 10),
              decoration: const BoxDecoration(
                  color: TColors.white, shape: BoxShape.circle),
              child: IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () {
                    Get.to(() => const AddProduct());
                  })),
        ],
      ),
      body: Container(
        margin: const EdgeInsets.only(top: 16),
        child: Obx(() {
          if (vendorController.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return GridView.builder(
              padding: const EdgeInsets.all(10),
              itemCount: vendorController.vendorProducts.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.55,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemBuilder: (context, index) => Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                clipBehavior: Clip.antiAliasWithSaveLayer,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AspectRatio(
                      aspectRatio: 1,
                      child: Image.network(
                        vendorController.vendorProducts[index].img,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            vendorController.vendorProducts[index].name,
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            "Price: ${vendorController.vendorProducts[index].price} DA",
                            style: const TextStyle(
                              fontSize: 15,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              IconButton(
                                  onPressed: () {
                                    Get.to(() => ModifierProductScreen(
                                        product: vendorController
                                            .vendorProducts[index]));
                                  },
                                  icon: const Icon(
                                    Icons.edit_outlined,
                                    color: Colors.blue,
                                    size: 25,
                                  )),
                              IconButton(
                                onPressed: () {
                                  Get.dialog(
                                    AlertDialog(
                                      title: const Text('Confirm'),
                                      content: const Text(
                                          'Are you sure you want to delete this item?'),
                                      actions: <Widget>[
                                        TextButton(
                                          child: const Text('Cancel'),
                                          onPressed: () {
                                            Get.back();
                                          },
                                        ),
                                        TextButton(
                                          child: const Text('Delete'),
                                          onPressed: () async {
                                            await vendorController
                                                .deleteProduct(vendorController
                                                    .vendorProducts[index]
                                                    .uid!);
                                            Get.back();
                                          },
                                        ),
                                      ],
                                    ),
                                  );
                                },
                                icon: const Icon(
                                  CupertinoIcons.trash,
                                  color: Colors.red,
                                  size: 25,
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
        }),
      ),
    );
  }
}
