import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:image_picker/image_picker.dart';
import 'package:waffir/features/Nos_Vendeurs/Vendeurs/controllers/vendor_products_controller.dart';
import 'package:waffir/features/Profil/profile_controller.dart';
import 'package:waffir/features/addProduct/model/product.dart';
import 'package:waffir/utils/constants/colors.dart';
import 'package:waffir/utils/constants/sizes.dart';
import 'package:waffir/utils/constants/text_strings.dart';

class ModifierProductScreen extends StatefulWidget {
  const ModifierProductScreen({super.key, required this.product});

  final ProductModel product;
  @override
  State<ModifierProductScreen> createState() => _ModifierProductScreenState();
}

class _ModifierProductScreenState extends State<ModifierProductScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();
  var _chosenCategory;
  String? imgsrc;
  @override
  void initState() {
    super.initState();
    _chosenCategory = widget.product.category;
    _nameController.text = widget.product.name;
    _descController.text = widget.product.description;
    _priceController.text = widget.product.price.toString();
    _quantityController.text = widget.product.quantity.toString();
  }

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

  final _formKey = GlobalKey<FormState>();

  final vendorController = Get.put(VendorProductsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Modifier le produit'),
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
                    ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.network(
                        widget.product.img,
                        height: Get.height * 0.3,
                      ),
                    ),
                    const SizedBox(height: 20),
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
                              if (imgsrc == null ||
                                  imgsrc == widget.product.img) {
                                // Keep the current image
                                ProductModel product = ProductModel(
                                  market: widget.product.market,
                                  category: category,
                                  description: description,
                                  img: widget.product.img,
                                  name: name,
                                  price: int.parse(price),
                                  quantity: quantity,
                                  sellerUid: selledUid,
                                  uid: widget.product.uid,
                                );
                                await vendorController.modifyProduct(product);
                              } else {
                                // Upload the new image
                                String? photo =
                                    await vendorController.uploadImage(
                                        File(imgsrc!), widget.product.uid!);
                                ProductModel product = ProductModel(
                                  market: widget.product.market,
                                  category: category,
                                  description: description,
                                  img: photo!,
                                  name: name,
                                  price: int.parse(price),
                                  quantity: quantity,
                                  sellerUid: selledUid,
                                  uid: widget.product.uid,
                                );
                                await vendorController.modifyProduct(product);
                              }
                            } else {
                              Get.snackbar(
                                "Erreur",
                                "Veuillez ajouter une image",
                                backgroundColor: Colors.red,
                                dismissDirection: DismissDirection.horizontal,
                              );
                            }
                          },
                          child: const Text('Modifier le produit'),
                        ))
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
