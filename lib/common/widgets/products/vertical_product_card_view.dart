import 'dart:math';

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

  final cartController = Get.put(CartController());
  final favController = Get.put(FavController());

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
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
                  Obx(
                    () => Positioned(
                      top: 0,
                      right: 0,
                      child: CircularIcon(
                        icon: favController.favProducts.contains(product)
                            ? Icons.favorite
                            : Icons.favorite_border,
                        color: Colors.red,
                        onPressed: () {
                          log(favController.favProducts.length);
                          if (favController.favProducts.contains(product)) {
                            favController.removeFavProduct(product);
                          } else {
                            favController.addFavProduct(product);
                          }
                        },
                      ),
                    ),
                  )
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
