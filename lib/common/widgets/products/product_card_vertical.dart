import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:waffir/common/Icons/circular_icon.dart';
import 'package:waffir/common/styles/RoundedContainer.dart';
import 'package:waffir/common/styles/shadow.dart';
import 'package:waffir/common/widgets/image_text_widget/product_price.dart';
import 'package:waffir/common/widgets/image_text_widget/roundImage.dart';
import 'package:waffir/common/widgets/texts/brand_text/TBrandTitleTEXT2.dart';
import 'package:waffir/common/widgets/texts/product_title_text.dart';
import 'package:waffir/utils/constants/colors.dart';
import 'package:waffir/utils/constants/image_strings.dart';
import 'package:waffir/utils/constants/sizes.dart';

class ProductCardVertical extends StatelessWidget {
  const ProductCardVertical({super.key});

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
          children: [
            const RoundedContainer(
              padding: EdgeInsets.all(TSizes.sm),
              height: 180,
              backgroundColor: TColors.light,
              child: Stack(
                children: [
                  RoundImage(
                    imagurl: TImages.productImage1,
                    applyImageRadius: true,
                    fit: BoxFit.fill,
                  ),
                  Positioned(
                      top: 0,
                      right: 0,
                      child:
                          CircularIcon(icon: Iconsax.heart5, color: Colors.red))
                ],
              ),
            ),
            const SizedBox(
              height: TSizes.spaceBtwItems / 2,
            ),
            const Padding(
              padding: EdgeInsets.only(left: TSizes.sm),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ProductTitleText(
                    title: 'Macarons a la vanille',
                    smallSize: true,
                  ),
                  SizedBox(
                    height: TSizes.spaceBtwItems / 2,
                  ),
                  TBrandTitleTextw(
                    title: 'Patisserie Soleil',
                    textColor: TColors.black,
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: TSizes.sm),
                  child: ProductPrice(
                    price: '250',
                  ),
                ),
                Container(
                  decoration: const BoxDecoration(
                      color: TColors.secondary,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(TSizes.cardRadiusMd),
                        bottomRight: Radius.circular(TSizes.productImageRadius),
                      )),
                  child: const Center(
                      child: Icon(
                    Iconsax.add,
                    color: TColors.white,
                    size: TSizes.iconLg * 1.5,
                  )),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
