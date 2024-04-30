import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:iconsax/iconsax.dart';
import 'package:waffir/common/widgets/appbar/app_bar.dart';
import 'package:waffir/common/widgets/custom_shapes/containers/search_Container.dart';
import 'package:waffir/common/widgets/custom_shapes/curved_edges/curved_edges.dart';
import 'package:waffir/common/widgets/image_text_widget/vertical_image_text.dart';
import 'package:waffir/common/widgets/layouts/grid_layout.dart';
import 'package:waffir/common/widgets/products/product_card_vertical.dart';
import 'package:waffir/common/widgets/texts/section_heading.dart';
import 'package:waffir/common/styles/promo_slide.dart';
import 'package:waffir/utils/constants/colors.dart';
import 'package:waffir/utils/constants/image_strings.dart';
import 'package:waffir/utils/constants/sizes.dart';
import 'package:waffir/utils/constants/text_strings.dart';

class DecScreen extends StatelessWidget {

  const DecScreen({super.key});

  @override
  Widget build(BuildContext context) {
    int count=0;
    fetchUsers();
    return Scaffold(
body : SingleChildScrollView(
  child: Column (children: [
    ClipPath(
      clipper:CustomCurvesEdges(),
      child: Container( 
        color: TColors.primary,
        padding: const EdgeInsets.all(0),
        child :  SizedBox(
          height:100 ,
          child: Stack(
          children: [
            Positioned( top : -150 , right: -250,child: CircularContainer(backgroundColor: TColors.textWhite.withOpacity(0.1))),
            Positioned(top:100 , right: -300 ,child: CircularContainer(backgroundColor: TColors.textWhite.withOpacity(0.1))),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
              children:[
                TAppBar(title:Column( 
              children: [
                Text(TTexts.homeAppbarTitle, style: Theme.of(context).textTheme.labelMedium!.apply(color: TColors.grey)),
                Text(TTexts.homeAppbarSubTitle, style: Theme.of(context).textTheme.headlineSmall!.apply(color: TColors.white))


],

                ),
                actions:  [

                  puceNotif(onPressed: (){} ,iconColor: TColors.white,)
                ],
                ),



              ]
            ),
            
           
            

            
          ],
            ),
        ),
      ),
    ),

       Padding(
      padding : const EdgeInsets.all(TSizes.defaultSpace),
       child: Column(
        children :[
       TSectionHeading(title : 'Produits Populaires' , onPressed : () {}, buttonTextColor: TColors.dark,),
       const SizedBox(height: TSizes.spaceBtwSections,),


GridViewVertical(itemCount: 2, itemBuilder: (_ , index ) => const ProductCardVertical(),),
//const ProductCardVertical()


        ],
     ),
      )
  ],)
)


    );
  }

  Future<void> fetchUsers() {
    CollectionReference prod = FirebaseFirestore.instance.collection('prod');
    return prod.get()
        .then((QuerySnapshot snapshot) {
      snapshot.docs.forEach((doc) {
        print('${doc.id} => ${doc.data()}');
      });
    })
        .catchError((error) => print("Failed to fetch users: $error"));


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
  const puceNotif({
    super.key,
    required this.onPressed , required this.iconColor 
  });
final VoidCallback onPressed;
final Color iconColor ;

  @override
  Widget build(BuildContext context) {
    return Stack(
    
      children: [
     IconButton(onPressed: (){}, icon: const Icon(Iconsax.shopping_bag , color: TColors.white,)),
    Positioned(
      right:0 ,
      child: Container(width: 18, height:18 , decoration: BoxDecoration(
      color: TColors.black,
      borderRadius: BorderRadius.circular(100)
      
      ),
      child : Center(child : Text ('' , style : Theme.of(context).textTheme.labelLarge!.apply(color:TColors.white, fontSizeFactor:0.8 )))
      
      ),
    )
    
      ],
    );
  }
}

class CircularContainer extends StatelessWidget {
  const CircularContainer({
    super.key,
    this.child,
    this.width=400 ,
    this.height =400,
    this.radius= 400 , 
    this.padding=0,
    required this.backgroundColor,   this.margin,
  });
final double? width;
final double? height ; 
final double radius ; 
final double padding; 
final Widget? child;
final EdgeInsets? margin ; 
final Color backgroundColor;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      margin: margin,
      padding:  EdgeInsets.all(padding),
      decoration:BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        color:backgroundColor,
      ) ,
      child:child ,
      );
  }

}