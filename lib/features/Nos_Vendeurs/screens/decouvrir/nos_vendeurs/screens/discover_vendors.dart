import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:waffir/common/styles/RoundedContainer.dart';
import 'package:waffir/common/widgets/appbar/app_bar.dart';
import 'package:waffir/common/widgets/custom_shapes/containers/search_Container.dart';
import 'package:waffir/common/widgets/image_text_widget/Circular_image.dart';
import 'package:waffir/common/widgets/layouts/grid_layout.dart';
import 'package:waffir/common/widgets/texts/brand_text/TBrandTitleTEXT2.dart';
import 'package:waffir/common/widgets/texts/section_heading.dart';
import 'package:waffir/features/Nos_Vendeurs/screens/decouvrir/nos_vendeurs/controller/discover_vendors_controller.dart';
import 'package:waffir/utils/constants/colors.dart';
import 'package:waffir/utils/constants/enums.dart';
import 'package:waffir/utils/constants/image_strings.dart';
import 'package:waffir/utils/constants/sizes.dart';

class DiscoverVendorsScreen extends GetView<DiscoverVendorsController> {
  const DiscoverVendorsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TColors.primary,
      appBar: TAppBar(
        title: Text('Nos Vendeurs',
            style: Theme.of(context)
                .textTheme
                .headlineMedium!
                .apply(color: TColors.white)),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              const SizedBox(
                height: TSizes.spaceBtwItems,
              ),
              const searchContainer(
                text: 'Recherche',
                padding: EdgeInsets.zero,
              ),
              const SizedBox(
                height: TSizes.spaceBtwSections,
              ),
              TSectionHeading(
                title: 'Nos meilleurs Vendeurs',
                textColor: TColors.white,
                onPressed: () {},
                buttonTextColor: TColors.light,
              ),
              const SizedBox(
                height: TSizes.spaceBtwItems / 1.5,
              ),
              GridViewVertical(
                  itemCount: 4,
                  mainAxisExtent: 80,
                  itemBuilder: (_, index) {
                    return GestureDetector(
                      onTap: () {},
                      child: RoundedContainer(
                        height: 180,
                        padding: const EdgeInsets.all(TSizes.sm),
                        showBorder: true,
                        backgroundColor: Colors.transparent,
                        child: Row(
                          children: [
                            Flexible(
                                child: const TCircularImage(
                              image: TImages.productImage1,
                            )),
                            const SizedBox(
                              width: TSizes.spaceBtwItems / 2,
                            ),
                            Expanded(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const TBrandTitleTextw(
                                    title: 'Patisserie Soleil',
                                    textColor: TColors.white,
                                    brandTextSizes: TextSizes.large,
                                  ),
                                  Text(
                                    '20 Produits',
                                    overflow: TextOverflow.ellipsis,
                                    style:
                                        Theme.of(context).textTheme.labelMedium,
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  }),
              // Add more widgets here that will appear under the "Tout voir" button row
            ],
          ),
        ),
      ),
    );
  }
}
