import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:waffir/common/widgets/appbar/app_bar.dart';
import 'package:waffir/common/widgets/custom_shapes/containers/search_Container.dart';
import 'package:waffir/common/widgets/image_text_widget/Circular_image.dart';
import 'package:waffir/common/widgets/layouts/grid_layout.dart';
import 'package:waffir/common/widgets/texts/brand_text/TBrandTitleTEXT2.dart';
import 'package:waffir/common/widgets/texts/section_heading.dart';
import 'package:waffir/features/decouvrir/screens/decouvrir.dart';
import 'package:waffir/common/styles/RoundedContainer.dart';
import 'package:waffir/utils/constants/colors.dart';
import 'package:waffir/utils/constants/enums.dart';
import 'package:waffir/utils/constants/image_strings.dart';
import 'package:waffir/utils/constants/sizes.dart';

class vend extends StatelessWidget {
  const vend({super.key});

  @override
  Widget build(BuildContext context) {
    return   Scaffold(
backgroundColor: TColors.primary,

      appBar: TAppBar(
      title:  Text('Nos vendeurs',
       style: Theme.of(context).textTheme.headlineMedium!.apply(color: TColors.white)),
      actions:[ 
        puceNotif(onPressed: () {}, iconColor: TColors.white,)
        
      ]),
      body: 
      NestedScrollView(headerSliverBuilder: (_, innerBoxIsScrolled){
     return[
       SliverAppBar(
        automaticallyImplyLeading: false,
        pinned: true,
        floating: true,
        backgroundColor: TColors.primary,
        expandedHeight: 440,

        flexibleSpace: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: ListView(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            children:  [
              const SizedBox(height: TSizes.spaceBtwItems,),
              const searchContainer(text: 'Recherche' , padding:EdgeInsets.zero ,),
               const SizedBox(height: TSizes.spaceBtwSections,),


              TSectionHeading(title:'Nos meilleurs vendeurs' ,textColor: TColors.white, onPressed: (){}, buttonTextColor: TColors.light,),
              const SizedBox(height: TSizes.spaceBtwItems/1.5,),

                   GridViewVertical(itemCount: 4,mainAxisExtent: 80, itemBuilder: (_,index) {


                    return  GestureDetector(
                      onTap:(){} ,
                      child: RoundedContainer(
                      height: 180,
                      padding: const EdgeInsets.all(TSizes.sm),
                      
                      showBorder: true,
                      backgroundColor: Colors.transparent,
                      child: Row(
                        children: [
                          Flexible(child: const TCircularImage(image: TImages.productImage1,)),
                           const SizedBox(width: TSizes.spaceBtwItems/2,),
                      
                          Expanded(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                  
                              children: [
                              const TBrandTitleTextw(title: 'Patisserie Soleil', textColor: TColors.white , brandTextSizes: TextSizes.large,),
                              Text(
                                '20 Produits',
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context).textTheme.labelMedium,
                                                  
                              )
                                                  
                            ],),
                          )
                        ],
                      ),
                      
                                        ),
                    )  ;  
                   })


                   
            ], 
          ),
        ),

      ),
     ];

      }, body: Container(),
      )
    );
  }
}

