import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:waffir/common/widgets/appbar/app_bar.dart';
import 'package:waffir/common/widgets/custom_shapes/curved_edges/curved_edges.dart';
import 'package:waffir/common/widgets/layouts/grid_layout.dart';
import 'package:waffir/common/widgets/products/vertical_product_card_view.dart';
import 'package:waffir/common/widgets/texts/section_heading.dart';
import 'package:waffir/features/addProduct/screens/AddProduct.dart';
import 'package:waffir/features/decouvrir/controllers/decouvrir_controller.dart';
import 'package:waffir/features/decouvrir/screens/search_component.dart';
import 'package:waffir/utils/constants/colors.dart';
import 'package:waffir/utils/constants/sizes.dart';
import 'package:waffir/utils/constants/text_strings.dart';

class DecScreen extends StatefulWidget {
  const DecScreen({super.key});

  @override
  State<DecScreen> createState() => _DecScreenState();
}

class _DecScreenState extends State<DecScreen> {
  final decouvrirController = Get.put(DecouvrirController());
  String searchQuery = "";

  @override
  Widget build(BuildContext context) {
    fetchUsers();
    return Scaffold(
        body: SingleChildScrollView(
            child: Column(
      children: [
        ClipPath(
          clipper: CustomCurvesEdges(),
          child: Container(
            color: TColors.primary,
            padding: const EdgeInsets.all(0),
            child: SizedBox(
              height: 100,
              child: Stack(
                children: [
                  Positioned(
                      top: -150,
                      right: -250,
                      child: CircularContainer(
                          backgroundColor: TColors.textWhite.withOpacity(0.1))),
                  Positioned(
                      top: 100,
                      right: -300,
                      child: CircularContainer(
                          backgroundColor: TColors.textWhite.withOpacity(0.1))),
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TAppBar(
                          title: Column(
                            children: [
                              Text(TTexts.homeAppbarTitle,
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelMedium!
                                      .apply(color: TColors.grey)),
                              Text(TTexts.homeAppbarSubTitle,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineSmall!
                                      .apply(color: TColors.white))
                            ],
                          ),
                          actions: [
                            puceNotif(
                              iconColor: TColors.white,
                            )
                          ],
                        ),
                      ]),
                ],
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              TSectionHeading(
                title: 'Produits à découvrir',
                onPressed: () {},
                buttonTextColor: TColors.dark,
              ),
              const SizedBox(
                height: TSizes.spaceBtwSections / 3,
              ),
              SearchComponent(
                onChanged: (value) {
                  setState(() {
                    searchQuery = value;
                  });
                },
                padding: EdgeInsets.zero,
              ),
              const SizedBox(
                height: TSizes.spaceBtwSections / 2,
              ),
              Obx(() {
                final filteredProducts = decouvrirController.products
                    .where((product) => product.name
                        .toUpperCase()
                        .contains(searchQuery.toUpperCase()))
                    .toList();

                return GridViewVertical(
                  itemCount: filteredProducts.length,
                  itemBuilder: (_, index) {
                    return VerticalProductCardView(
                      product: filteredProducts[index],
                    );
                  },
                );
              }),
//const ProductCardVertical()
            ],
          ),
        )
      ],
    )));
  }

  Future<void> fetchUsers() {
    CollectionReference prod = FirebaseFirestore.instance.collection('prod');
    return prod.get().then((QuerySnapshot snapshot) {
      snapshot.docs.forEach((doc) {
        print('${doc.id} => ${doc.data()}');
      });
    }).catchError((error) => print("Failed to fetch users: $error"));
  }
}

class THomeCategories extends StatelessWidget {
  const THomeCategories({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}

class CircularContainer extends StatelessWidget {
  const CircularContainer({
    super.key,
    this.child,
    this.width = 400,
    this.height = 400,
    this.radius = 400,
    this.padding = 0,
    required this.backgroundColor,
    this.margin,
  });
  final double? width;
  final double? height;
  final double radius;
  final double padding;
  final Widget? child;
  final EdgeInsets? margin;
  final Color backgroundColor;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      margin: margin,
      padding: EdgeInsets.all(padding),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        color: backgroundColor,
      ),
      child: child,
    );
  }
}
