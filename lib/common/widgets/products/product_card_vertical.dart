
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:iconsax/iconsax.dart';
import 'package:waffir/common/Icons/circular_icon.dart';
import 'package:waffir/common/styles/shadow.dart';
import 'package:waffir/common/widgets/image_text_widget/product_price.dart';
import 'package:waffir/common/widgets/image_text_widget/roundImage.dart';
import 'package:waffir/common/widgets/texts/brand_text/TBrandTitleTEXT2.dart';
import 'package:waffir/common/widgets/texts/product_title_text.dart';
import 'package:waffir/common/styles/RoundedContainer.dart';
import 'package:waffir/utils/constants/colors.dart';
import 'package:waffir/utils/constants/image_strings.dart';
import 'package:waffir/utils/constants/sizes.dart';

class ProductCardVertical extends StatelessWidget {
  const ProductCardVertical({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){},
      child: Container(
        width: 180,
        //height: 100,
        //padding: const EdgeInsets.all(1),
        decoration : BoxDecoration(
          boxShadow: [ShadowStyle.verticalProductShadow],
          borderRadius: BorderRadius.circular(TSizes.productImageRadius),
          color: TColors.white
        ),
        child: Column(
      
          children: [
            const RoundedContainer(
             padding:  EdgeInsets.all(TSizes.sm),
             height: 180,
             //width: 180,
             
             backgroundColor: TColors.light,
             child: Stack(
              children: [
                RoundImage(imagurl: TImages.productImage1 , applyImageRadius: true, fit: BoxFit.fill,), 
                /// sale tage ??
               /* Positioned(
                  //top : 12 ,
                  child: RoundedContainer(
                    radius: TSizes.sm,
                    backgroundColor: TColors.secondary.withOpacity(0.8),
                    padding: const EdgeInsets.symmetric(horizontal: TSizes.sm , vertical: TSizes.xs),
                    child: Text ('25%' , style: Theme.of(context).textTheme.labelLarge!.apply(color: TColors.black),)
                  ),
                ),*/
                Positioned(
                  top : 0 ,
                  right: 0,
                  child: CircularIcon(icon: Iconsax.heart5,color : Colors.red))
              ],
             ),
              
            ),
          const SizedBox(height: TSizes.spaceBtwItems / 2,),
          
           const Padding(
            
            padding: EdgeInsets.only(left:TSizes.sm),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                
                  ProductTitleText(title: 'Macarons a la vanille', smallSize: true,),
                   SizedBox(height: TSizes.spaceBtwItems / 2,),
                   TBrandTitleTextw(title: 'Patisserie Soleil', textColor: TColors.black,),
                   
      
      
                   
      
                  
                  ],
            ),
            ),
           // const Spacer(),
                   
                     Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(left: TSizes.sm),
                        child: ProductPrice(price: '250',),
                      ), 
                      Container(
                        decoration: const BoxDecoration(
                          color: TColors.secondary, 
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(TSizes.cardRadiusMd),
                            bottomRight: Radius.circular(TSizes.productImageRadius),
      
                          )
                        ),
                        child:const Center( child: Icon(Iconsax.add , color: TColors.white , size: TSizes.iconLg *1.5,)),
      
                      )
                    ],)
      
      
          ],
        ) ,
      ),
    );
  }
}







/*class Product {
  String name;
  double price;
  String imageUrl;

  Product({required this.name, required this.price, required this.imageUrl});

  // Convertir le produit en un document Firestore
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'price': price,
      'imageUrl': imageUrl,
    };
  }
}

// Ajouter un produit à Firestore
FirebaseFirestore.instance.collection('products').add(product.toMap());

// Récupérer les produits de Firestore et les afficher
StreamBuilder<QuerySnapshot>(
  stream: FirebaseFirestore.instance.collection('products').snapshots(),
  builder: (context, snapshot) {
    if (!snapshot.hasData) return CircularProgressIndicator();
    return ListView.builder(
      itemCount: snapshot.data!.docs.length,
      itemBuilder: (context, index) {
        DocumentSnapshot data = snapshot.data!.docs[index];
        Product product = Product(
          name: data['name'],
          price: data['price'],
          imageUrl: data['imageUrl'],
        );
        return ProductCardVertical(product: product);
      },
    );
  },
);
*/