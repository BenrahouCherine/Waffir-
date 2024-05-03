import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:image_picker/image_picker.dart';
import 'package:waffir/features/Profil/profile_controller.dart';
import 'package:waffir/features/addProduct/controller/add_product_controller.dart';
import 'package:waffir/features/cart/controllers/cart_controller.dart';
import 'package:waffir/features/cart/screens/cart_screen.dart';
import 'package:waffir/utils/constants/colors.dart';
import 'package:waffir/utils/constants/sizes.dart';
import 'package:waffir/utils/constants/text_strings.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({super.key});

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _descController.dispose();
    _priceController.dispose();
    _quantityController.dispose();
    super.dispose();
  }

  final String selledUid = FirebaseAuth.instance.currentUser!.uid.toString();

  ProfileController profileController = Get.find();

  var _chosenCategory;
  String? imgsrc;
  final _formKey = GlobalKey<FormState>();

  final addProductController = Get.put(AddProductController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Ajouter un produit",
          style: TextStyle(color: Colors.white),
        ),
      ),
      backgroundColor: TColors.primary,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    DropdownButton<String>(
                      dropdownColor: Colors.black,
                      isExpanded: true,
                      value: _chosenCategory,
                      items: <String>[
                        'Gateau',
                        'Boulangerie',
                        'Plat',
                      ].map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          _chosenCategory = newValue!;
                        });
                      },
                      hint: const Text(
                        "Choisissez une categorie",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    const SizedBox(height: 14),
                    TextFormField(
                      controller: _nameController,
                      decoration: const InputDecoration(
                        labelText: "Entrez le nom du produit",
                        prefixIcon:
                            Icon(Iconsax.message, color: TColors.secondary),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Veuillez entrer le nom du produit';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 14),
                    TextFormField(
                      controller: _descController,
                      decoration: const InputDecoration(
                        labelText: TTexts.description,
                        prefixIcon:
                            Icon(Iconsax.direct, color: TColors.secondary),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Veuillez entrer la description du produit';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 14),
                    TextFormField(
                      expands: false,
                      controller: _priceController,
                      decoration: const InputDecoration(
                        labelText: TTexts.price,
                        prefixIcon:
                            Icon(Iconsax.call, color: TColors.secondary),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Veuillez entrer le prix du produit';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 14),
                    TextFormField(
                      controller: _quantityController,
                      decoration: const InputDecoration(
                        labelText: TTexts.quantity,
                        prefixIcon: Icon(Iconsax.password_check,
                            color: TColors.secondary),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Veuillez entrer la quantité du produit';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 14),
                    // field to add image
                    Row(
                      children: [
                        Expanded(
                            child: Container(
                          height: Get.height * 0.2,
                          decoration: BoxDecoration(
                            color: Colors.grey[100],
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: imgsrc == null
                              ? IconButton(
                                  onPressed: () async {
                                    final XFile? image = await ImagePicker()
                                        .pickImage(source: ImageSource.gallery);
                                    if (image != null) {
                                      setState(() {
                                        imgsrc = image.path;
                                      });
                                    }
                                  },
                                  icon: const Icon(
                                    Iconsax.camera,
                                    size: 35,
                                  ),
                                )
                              : InkWell(
                                  onTap: () async {
                                    final XFile? image = await ImagePicker()
                                        .pickImage(source: ImageSource.gallery);
                                    if (image != null) {
                                      setState(() {
                                        imgsrc = image.path;
                                      });
                                    }
                                  },
                                  child: Image.file(File(imgsrc!)),
                                ),
                        )),
                      ],
                    ),
                    const SizedBox(height: 28),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () async {
                          String category = _chosenCategory.toString();
                          String description = _descController.text;
                          String price = _priceController.text;
                          String name = _nameController.text;
                          String quantity = _quantityController.text;
                          if (_formKey.currentState!.validate()) {
                            if (imgsrc == null) {
                              Get.snackbar(
                                "Erreur",
                                "Veuillez ajouter une image",
                                backgroundColor: Colors.red,
                                dismissDirection: DismissDirection.horizontal,
                                isDismissible: true,
                                icon: const Icon(
                                  Icons.error,
                                  color: Colors.white,
                                  size: 30,
                                ),
                              );
                              return;
                            }

                            addProductController.product.update((val) {
                              val!.sellerUid = selledUid;
                              val.category = category;
                              val.name = name;
                              val.description = description;
                              val.market =
                                  profileController.user.value.username;
                              val.img = imgsrc!;
                              val.price = int.parse(price);
                              val.quantity = quantity;
                            });

                            await addProductController.addProduct();
                          }
                        },
                        child: const Text('Ajouter un produit'),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 28,
              ),
            ],
          ),
        ),
      ),
    );
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

class puceNotif extends StatelessWidget {
  puceNotif({super.key, required this.iconColor});
  final Color iconColor;

  final cartController = Get.put(CartController());
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        IconButton(
            onPressed: () {
              Get.to(() => const CartScreen());
            },
            icon: const Icon(
              Iconsax.shopping_bag,
              color: TColors.white,
            )),
        Positioned(
          right: 0,
          child: Container(
              width: 18,
              height: 18,
              decoration: BoxDecoration(
                  color: TColors.black,
                  borderRadius: BorderRadius.circular(100)),
              child: Obx(() => Center(
                  child: Text(cartController.cartItems.length.toString(),
                      style: Theme.of(context)
                          .textTheme
                          .labelLarge!
                          .apply(color: TColors.white, fontSizeFactor: 0.8))))),
        )
      ],
    );
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
