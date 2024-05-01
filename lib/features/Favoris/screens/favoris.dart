import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:waffir/common/Icons/circular_icon.dart';
import 'package:waffir/common/widgets/appbar/app_bar.dart';
import 'package:waffir/common/widgets/layouts/grid_layout.dart';
import 'package:waffir/common/widgets/products/vertical_product_card_view.dart';
import 'package:waffir/features/Favoris/controllers/fav_controller.dart';
import 'package:waffir/features/decouvrir/screens/decouvrir.dart';
import 'package:waffir/utils/constants/colors.dart';
import 'package:waffir/utils/constants/sizes.dart';

class favoris extends GetView<FavController> {
  const favoris({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: TColors.primary,
        appBar: TAppBar(
          title: Text(
            'Favoris',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          actions: [
            CircularIcon(
              icon: Iconsax.add,
              onPressed: () => Get.to(() => DecScreen()),
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(TSizes.defaultSpace),
            child: Column(
              children: [
                Obx(() => GridViewVertical(
                    itemCount: controller.favProducts.length,
                    itemBuilder: (_, index) => VerticalProductCardView(
                        product: controller.favProducts[index]))),
              ],
            ),
          ),
        ));
  }
}
