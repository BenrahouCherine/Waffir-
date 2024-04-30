import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:http/http.dart';
import 'package:iconsax/iconsax.dart';
import 'package:waffir/features//Favoris/screens/favoris.dart';
import 'package:waffir/features/Decouvrir/screens/decouvrir.dart';
import 'package:waffir/features/Profil/Client.dart';
import 'package:waffir/features/Nos_Vendeurs/screens/decouvrir/Vendeurs/vendeur.dart';
import 'package:waffir/features/Profil/profile_controller.dart';
import 'package:waffir/utils/constants/colors.dart';

import 'features/Decouvrir/screens/AddProduct.dart';
class NavigationMenu extends StatelessWidget {
  const NavigationMenu(   {super.key});


  @override
  Widget build(BuildContext context) {

    final controller = Get.put(NavigationController());
    final currentUser = FirebaseAuth.instance.currentUser;
    final uid=currentUser?.uid;
  ProfileController profileController
     = Get.put(ProfileController());
    CollectionReference users = FirebaseFirestore.instance.collection('userDetail');

     fetchUsers();

Fluttertoast.showToast(msg: uid.toString());
    print('nav menu'+uid.toString());

    return Obx(() { return profileController.userLoading.value?Container(): GetBuilder(
      init: profileController,
      builder: (context) {
        return  profileController.userNature==null?  Container():
         Scaffold(
         bottomNavigationBar: Obx(
           () =>profileController.userNature =="Seller"? NavigationBar(
            height: 80,
            elevation: 0,
            selectedIndex: controller.selectedIndex.value,
            onDestinationSelected: (index)=> controller.selectedIndex.value=index ,
            backgroundColor: TColors.white,
            indicatorColor:const Color.fromARGB(189, 242, 174, 28),
            destinations: const [

              NavigationDestination(icon:Icon(Iconsax.heart) , label:'Commande'),
              NavigationDestination(icon:Icon(Iconsax.bag) , label:'Produit'),



              NavigationDestination(icon:Icon(Iconsax.user) , label:'User'),
            ],):
           NavigationBar(
             height: 80,
             elevation: 0,
             selectedIndex: controller.selectedIndex.value,
             onDestinationSelected: (index)=> controller.selectedIndex.value=index ,
             backgroundColor: TColors.white,
             indicatorColor:const Color.fromARGB(189, 242, 174, 28),
             destinations: const [
               NavigationDestination(icon:Icon(Iconsax.discover) , label:'Découvrir'),
               NavigationDestination(icon:Icon(Iconsax.bag) , label:'Vendeurs'),

               NavigationDestination(icon:Icon(Iconsax.heart) , label:'Favoris'),

               NavigationDestination(icon:Icon(Iconsax.user) , label:'User'),
             ],),
         ),
          body: Obx(()=>profileController.userNature=="Seller"?controller.sellerScreens[controller.selectedIndex.value]: controller.bayerScreens[controller.selectedIndex.value]),

        );
      }
    );});
  }
  Future<void> fetchUsers() {
    final currentUser = FirebaseAuth.instance.currentUser;
    CollectionReference users = FirebaseFirestore.instance.collection('userDetail');

    return users.where('uid',isEqualTo: currentUser?.uid.toString()).get()
        .then((QuerySnapshot snapshot) {
      snapshot.docs.forEach((doc) {
        print(doc["username"]);
        String $userFetched=doc["username"];
        String $verified=doc["isvalidated"];

      });
    })
        .catchError((error) => print("Failed to fetch users: $error"));


  }
}




class NavigationController extends GetxController{
final Rx<int>  selectedIndex = 0.obs;
final sellerScreens = [ AddProduct(),const vend(),const client()];
final bayerScreens = [const DecScreen(),const vend(),const favoris(),const client()];

}



