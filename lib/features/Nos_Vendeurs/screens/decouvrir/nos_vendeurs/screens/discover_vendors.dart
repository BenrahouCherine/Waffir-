import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:waffir/common/widgets/appbar/app_bar.dart';
import 'package:waffir/common/widgets/custom_shapes/containers/search_Container.dart';
import 'package:waffir/common/widgets/texts/section_heading.dart';
import 'package:waffir/features/Nos_Vendeurs/screens/decouvrir/nos_vendeurs/controller/discover_vendors_controller.dart';
import 'package:waffir/features/Nos_Vendeurs/screens/decouvrir/nos_vendeurs/screens/vendor_card.dart';
import 'package:waffir/utils/constants/colors.dart';
import 'package:waffir/utils/constants/sizes.dart';

class DiscoverVendorsScreen extends StatefulWidget {
  const DiscoverVendorsScreen({super.key});

  @override
  State<DiscoverVendorsScreen> createState() => _DiscoverVendorsScreenState();
}

class _DiscoverVendorsScreenState extends State<DiscoverVendorsScreen> {
  final DiscoverVendorsController controller =
      Get.find<DiscoverVendorsController>();
  String searchQuery = "";

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
              SearchContainer(
                onChanged: (value) {
                  setState(() {
                    searchQuery = value;
                  });
                },
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
              Obx(
                () => controller.isLoading.value
                    ? const Padding(
                        padding: EdgeInsets.all(20.0),
                        child: CircularProgressIndicator(
                          color: Colors.yellow,
                        ),
                      )
                    : ListView.separated(
                        separatorBuilder: (context, index) {
                          return const SizedBox(
                            height: TSizes.spaceBtwItems,
                          );
                        },
                        itemCount: controller.vendors
                            .where((vendor) =>
                                vendor.firstName.contains(searchQuery) ||
                                vendor.lastName.contains(searchQuery))
                            .length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (_, index) {
                          var filteredVendors = controller.vendors
                              .where((vendor) =>
                                  vendor.firstName.contains(searchQuery) ||
                                  vendor.lastName.contains(searchQuery))
                              .toList();

                          return VendorCard(
                            vendor: filteredVendors[index],
                            numberOfProducts:
                                filteredVendors[index].productsCount ?? 0,
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
