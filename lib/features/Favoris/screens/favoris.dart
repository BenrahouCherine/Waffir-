import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:iconsax/iconsax.dart';
import 'package:waffir/common/Icons/circular_icon.dart';
import 'package:waffir/common/widgets/appbar/app_bar.dart';
import 'package:waffir/common/widgets/layouts/grid_layout.dart';
import 'package:waffir/common/widgets/products/product_card_vertical.dart';
import 'package:waffir/features/decouvrir/screens/decouvrir.dart';
import 'package:waffir/utils/constants/colors.dart';
import 'package:waffir/utils/constants/sizes.dart';

class favoris extends StatelessWidget {
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
                GridViewVertical(
                    itemCount: 4,
                    itemBuilder: (_, index) => const ProductCardVertical()),
              ],
            ),
          ),
        ));
  }
}
