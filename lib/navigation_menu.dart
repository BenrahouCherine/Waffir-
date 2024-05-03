import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:iconsax/iconsax.dart';
import 'package:waffir/features//Favoris/screens/favoris.dart';
import 'package:waffir/features/Nos_Vendeurs/Vendeurs/Vendeur.dart';
import 'package:waffir/features/Nos_Vendeurs/screens/decouvrir/nos_vendeurs/screens/discover_vendors.dart';
import 'package:waffir/features/Profil/profile_controller.dart';
import 'package:waffir/features/Profil/profile_screen.dart';
import 'package:waffir/features/decouvrir/screens/decouvrir.dart';
import 'package:waffir/features/map/screens/map.dart';
import 'package:waffir/features/orders/vendor/screens/vendor_orders_screen.dart';
import 'package:waffir/utils/constants/colors.dart';

class NavigationMenu extends StatelessWidget {
  NavigationMenu({super.key});
  final controller = Get.put(NavigationController());
  final profileController = Get.put(ProfileController());
  final FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: profileController.getUser(auth.currentUser!.uid),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            backgroundColor: TColors.primary,
            body: Center(
              child: CircularProgressIndicator(
                color: Colors.yellow,
              ),
            ),
          );
        } else {
          return Obx(() {
            return profileController.userLoading.value
                ? Container()
                : profileController.user.value.userNature == null
                    ? Container()
                    : Scaffold(
                        bottomNavigationBar: profileController
                                    .user.value.userNature ==
                                "Seller"
                            ? NavigationBar(
                                height: 80,
                                elevation: 0,
                                selectedIndex: controller.selectedIndex.value,
                                onDestinationSelected: (index) =>
                                    controller.selectedIndex.value = index,
                                backgroundColor: TColors.white,
                                indicatorColor:
                                    const Color.fromARGB(189, 242, 174, 28),
                                destinations: const [
                                  NavigationDestination(
                                      icon: Icon(Iconsax.document),
                                      label: 'Commande'),
                                  NavigationDestination(
                                      icon: Icon(Iconsax.bag),
                                      label: 'Produit'),
                                  NavigationDestination(
                                      icon: Icon(Iconsax.user), label: 'User'),
                                ],
                              )
                            : NavigationBar(
                                height: 80,
                                elevation: 0,
                                selectedIndex: controller.selectedIndex.value,
                                onDestinationSelected: (index) =>
                                    controller.selectedIndex.value = index,
                                backgroundColor: TColors.white,
                                indicatorColor:
                                    const Color.fromARGB(189, 242, 174, 28),
                                destinations: const [
                                  NavigationDestination(
                                      icon: Icon(Iconsax.discover),
                                      label: 'Découvrir'),
                                  NavigationDestination(
                                      icon: Icon(Iconsax.map), label: 'Carte'),
                                  NavigationDestination(
                                      icon: Icon(Iconsax.bag),
                                      label: 'Vendeurs'),
                                  NavigationDestination(
                                      icon: Icon(Iconsax.heart),
                                      label: 'Favoris'),
                                  NavigationDestination(
                                      icon: Icon(Iconsax.user), label: 'User'),
                                ],
                              ),
                        body: profileController.user.value.userNature ==
                                "Seller"
                            ? controller
                                .sellerScreens[controller.selectedIndex.value]
                            : controller
                                .bayerScreens[controller.selectedIndex.value]);
          });
        }
      },
    );
  }
}

class NavigationController extends GetxController {
  final Rx<int> selectedIndex = 0.obs;
  final sellerScreens = [const VendorOrdersScreen(), Vend(), const Client()];
  final bayerScreens = [
    const DecScreen(),
    const MapSample(),
    const DiscoverVendorsScreen(),
    const favoris(),
    const Client()
  ];
}
