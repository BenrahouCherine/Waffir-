import 'package:carousel_slider/carousel_slider.dart';
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

  @override
  void initState() {
    controller.fetchVendors();
    super.initState();
  }

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
            child: Obx(
              () => controller.isLoading.value
                  ? SizedBox(
                      height: MediaQuery.of(context).size.height / 1.5,
                      child: const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Center(
                            child: CircularProgressIndicator(
                              color: Colors.yellow,
                            ),
                          ),
                        ],
                      ),
                    )
                  : Column(
                      children: [
                        const SizedBox(
                          height: TSizes.spaceBtwItems,
                        ),
                        Obx(() => CarouselSlider(
                              options: CarouselOptions(
                                aspectRatio: 2.0,
                                enlargeCenterPage: true,
                                scrollDirection: Axis.horizontal,
                                autoPlay: true,
                              ),
                              items: controller.vendors.map((vendor) {
                                return Builder(
                                  builder: (BuildContext context) {
                                    return Container(
                                      width: MediaQuery.of(context).size.width,
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 5.0),
                                      child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                        child: Image.network(vendor.photoURL!,
                                            fit: BoxFit.cover),
                                      ),
                                    );
                                  },
                                );
                              }).toList(),
                            )),
                        const SizedBox(
                          height: TSizes.spaceBtwItems * 1.5,
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
                          () => ListView.separated(
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
        ));
  }
}
