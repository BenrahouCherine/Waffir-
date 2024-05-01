import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:iconsax/iconsax.dart';
import 'package:waffir/features//Favoris/screens/favoris.dart';
import 'package:waffir/features/Nos_Vendeurs/screens/decouvrir/Vendeurs/Vendeur.dart';
import 'package:waffir/features/Profil/Client.dart';
import 'package:waffir/features/Profil/profile_controller.dart';
import 'package:waffir/features/decouvrir/screens/decouvrir.dart';
import 'package:waffir/utils/constants/colors.dart';

import 'features/addProduct/screens/AddProduct.dart';

class NavigationMenu extends StatelessWidget {
  const NavigationMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NavigationController());
    final profileController = Get.put(ProfileController());

    return Obx(() {
      return profileController.userLoading.value
          ? Container()
          : profileController.user.value.userNature == null
              ? Container()
              : Scaffold(
                  bottomNavigationBar: Obx(
                    () => profileController.user.value.userNature == "Seller"
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
                                  icon: Icon(Iconsax.heart), label: 'Commande'),
                              NavigationDestination(
                                  icon: Icon(Iconsax.bag), label: 'Produit'),
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
                                  icon: Icon(Iconsax.bag), label: 'Vendeurs'),
                              NavigationDestination(
                                  icon: Icon(Iconsax.heart), label: 'Favoris'),
                              NavigationDestination(
                                  icon: Icon(Iconsax.user), label: 'User'),
                            ],
                          ),
                  ),
                  body: Obx(() => profileController.user.value.userNature ==
                          "Seller"
                      ? controller.sellerScreens[controller.selectedIndex.value]
                      : controller
                          .bayerScreens[controller.selectedIndex.value]),
                );
    });
  }
}

class NavigationController extends GetxController {
  final Rx<int> selectedIndex = 0.obs;
  final sellerScreens = [const AddProduct(), Vend(), const Client()];
  final bayerScreens = [DecScreen(), Vend(), const favoris(), const Client()];
}
