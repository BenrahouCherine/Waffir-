import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:waffir/features/Profil/profile_controller.dart';
import 'package:waffir/utils/constants/colors.dart';
import 'package:waffir/utils/constants/sizes.dart';
import 'package:waffir/utils/constants/text_strings.dart';


class AddProduct extends StatelessWidget {
  @override
  final TextEditingController _descController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();
  void dispose() {
    _descController.dispose();
    _priceController.dispose();
    _quantityController.dispose();
  }
   AddProduct({super.key});

  @override
  Widget build(BuildContext context) {
    final String _auth=FirebaseAuth.instance.currentUser!.uid.toString();

    ProfileController profileController=Get.find();
    String groupValue="Seller";

    var _chosenCategory;
    String? imgsrc;


    return Scaffold(
        backgroundColor: TColors.primary,

        body:GetBuilder(init: profileController,
        builder: (context)
    { return SingleChildScrollView(

          child: Padding(
            padding: const EdgeInsets.all(TSizes.defaultSpace),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(

                  TTexts.AddProduct,

                ),
                const SizedBox(height: 28,),
                Form(
                  child: Column(
                    children: [

                   DropdownButton<String>(

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
                    onChanged: (String? newValue) { _chosenCategory=newValue;
                     imgsrc="null";},

                   
                    hint: Text(
                      "Choisissez une categorie",

                    ),
                  ),
                
          
                      const SizedBox(height: 14),
                      TextFormField(
                        // expands: false,
                        controller: _descController,
                        decoration: const InputDecoration(
                          labelText: TTexts.Description,
                          prefixIcon: Icon(Iconsax.direct,color: TColors.secondary),
                        ),),
                      const SizedBox(height: 14),
                      TextFormField(
                        expands: false,
                        controller: _priceController,
                        decoration: const InputDecoration(
                          labelText: TTexts.Price,
                          prefixIcon: Icon(Iconsax.call,color: TColors.secondary),
                        ),),
                      const SizedBox(height: 14),
                      TextFormField(

                        controller: _quantityController,
                        decoration: const InputDecoration(
                          labelText: TTexts.Quantity,
                          prefixIcon: Icon(Iconsax.password_check , color: TColors.secondary),
                        ),),
                      const SizedBox(height: 14),
                      const SizedBox(height: 14),

                      const SizedBox(height: 28),


                      SizedBox(width: double.infinity , child:ElevatedButton(onPressed: ()
                      {
                      String category=_chosenCategory.toString();
                      String description=_descController.text;
                      String price=_priceController.text;
                      String quantity=_quantityController.text;

                      print("le prix est"+price);
                       print("le prix est"+description);
                       print("le prix est"+category);
                      print("le prix est"+quantity);


                      Map<String,dynamic>product= { 'seller_uid':_auth
                        ,'category': category,
                        'description': description,
                        'market':profileController.userFetched,
                        'img': imgsrc,
                        'price': price,
                        'quantity': quantity,

                      };
                      print("auth");
                      print(_auth);
                      print('le prix est'+price);
                      CollectionReference collectionReference=FirebaseFirestore.instance.collection('product');
                      collectionReference.doc().set(product);
                      print("produit ajouté");
                      print(collectionReference);



                      }
                        ,
                        child: const Text('Ajouter un produit'),
                      ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 28,),



               ],

            ),
          ),);}



    ),);
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