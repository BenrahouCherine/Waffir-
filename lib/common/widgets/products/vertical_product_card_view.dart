import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:waffir/common/Icons/circular_icon.dart';
import 'package:waffir/common/styles/RoundedContainer.dart';
import 'package:waffir/common/styles/shadow.dart';
import 'package:waffir/common/widgets/image_text_widget/product_price.dart';
import 'package:waffir/common/widgets/image_text_widget/roundImage.dart';
import 'package:waffir/common/widgets/texts/brand_text/TBrandTitleTEXT2.dart';
import 'package:waffir/common/widgets/texts/product_title_text.dart';
import 'package:waffir/features/Favoris/controllers/fav_controller.dart';
import 'package:waffir/features/addProduct/model/product.dart';
import 'package:waffir/features/cart/controllers/cart_controller.dart';
import 'package:waffir/utils/constants/colors.dart';
import 'package:waffir/utils/constants/sizes.dart';

class VerticalProductCardView extends StatelessWidget {
  VerticalProductCardView({super.key, required this.product});

  final ProductModel product;

  final cartController = Get.find<CartController>();
  final favController = Get.find<FavController>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.bottomSheet(
          enableDrag: true,
          persistent: true,
          backgroundColor: TColors.white,
          DraggableScrollableSheet(
              expand: false,
              maxChildSize: 0.85,
              initialChildSize: 0.85,
              minChildSize: 0.3,
              builder: (context, ScrollController scrollController) {
                return Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20, vertical: 12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      // product image
                      Container(
                        height: 200,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          image: DecorationImage(
                            image: NetworkImage(product.img),
                            fit: BoxFit.fitHeight,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(product.name,
                                  style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black)),
                            ],
                          ),
                          Text("${product.price} DA",
                              style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.orangeAccent)),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          const Icon(
                            Iconsax.shop,
                            size: 25,
                          ),
                          const SizedBox(width: 10),
                          Text(
                            product.market,
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      const Text(
                        "Description",
                        style: TextStyle(color: Colors.black, fontSize: 20),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      SizedBox(
                        height: Get.height * 0.15,
                        child: Expanded(
                          child: SingleChildScrollView(
                            child: Text(product.description,
                                style: const TextStyle(
                                    fontSize: 16, color: Colors.black)),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 18,
                      ),
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: product.quantity == '0'
                              ? Colors.red[100]
                              : Colors.green[100],
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          'Quantité restante: ${product.quantity}',
                          style: TextStyle(
                              fontSize: 16,
                              color: product.quantity == '0'
                                  ? Colors.red[500]
                                  : Colors.green[500]),
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {
                                cartController.addItem(product, 1);
                              },
                              child: const Text('Ajouter au panier'),
                            ),
                          ),
                          const SizedBox(
                            width: 16,
                          ),
                          Obx(() => Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.1),
                                      spreadRadius: 1,
                                      blurRadius: 10,
                                      offset: const Offset(0, 0),
                                    ),
                                  ],
                                ),
                                child: IconButton(
                                  icon: Icon(
                                    favController.favProducts.any(
                                            (favProduct) =>
                                                favProduct.uid == product.uid)
                                        ? Icons.favorite
                                        : Icons.favorite_border,
                                    color: Colors.red,
                                  ),
                                  onPressed: () {
                                    if (favController.favProducts.any(
                                        (favProduct) =>
                                            favProduct.uid == product.uid)) {
                                      favController.removeFavProduct(product);
                                    } else {
                                      favController.addFavProduct(product);
                                    }
                                  },
                                ),
                              )),
                        ],
                      ),
                    ],
                  ),
                );
              }),
          barrierColor: Colors.black.withOpacity(0.5),
          isDismissible: true,
          isScrollControlled: true,
        );
      },
      child: Container(
        width: 180,
        decoration: BoxDecoration(
            boxShadow: [ShadowStyle.verticalProductShadow],
            borderRadius: BorderRadius.circular(TSizes.productImageRadius),
            color: TColors.white),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RoundedContainer(
              padding: const EdgeInsets.all(TSizes.sm),
              height: 180,
              backgroundColor: TColors.light,
              child: Stack(
                children: [
                  RoundImage(
                    height: 180,
                    isNetworkingImage: true,
                    imagurl: product.img,
                    applyImageRadius: true,
                    fit: BoxFit.cover,
                  ),
                  Obx(() => Positioned(
                        top: 0,
                        right: 0,
                        child: CircularIcon(
                          icon: favController.favProducts.any(
                                  (favProduct) => favProduct.uid == product.uid)
                              ? Icons.favorite
                              : Icons.favorite_border,
                          color: Colors.red,
                          onPressed: () {
                            if (favController.favProducts.any((favProduct) =>
                                favProduct.uid == product.uid)) {
                              favController.removeFavProduct(product);
                            } else {
                              favController.addFavProduct(product);
                            }
                          },
                        ),
                      )),
                ],
              ),
            ),
            const SizedBox(
              height: TSizes.spaceBtwItems / 2,
            ),
            Padding(
              padding: const EdgeInsets.only(left: TSizes.sm + 2),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ProductTitleText(
                    title: product.name,
                    smallSize: true,
                    maxLines: 1,
                  ),
                  const SizedBox(
                    height: TSizes.spaceBtwItems / 2,
                  ),
                  TBrandTitleTextw(
                    title: product.market,
                    textColor: TColors.black,
                    maxlines: 1,
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: TSizes.sm),
                  child: ProductPrice(
                    price: product.price.toString(),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    cartController.addItem(product, 1);
                  },
                  child: Container(
                    decoration: const BoxDecoration(
                        color: TColors.secondary,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(TSizes.cardRadiusMd),
                          bottomRight:
                              Radius.circular(TSizes.productImageRadius),
                        )),
                    child: const Center(
                        child: Icon(
                      Iconsax.add,
                      color: TColors.white,
                      size: TSizes.iconLg * 1.5,
                    )),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
