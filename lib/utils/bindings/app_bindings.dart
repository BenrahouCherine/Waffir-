import 'package:get/get.dart';
import 'package:waffir/features/Favoris/controllers/fav_controller.dart';
import 'package:waffir/features/Nos_Vendeurs/screens/decouvrir/nos_vendeurs/controller/discover_vendors_controller.dart';
import 'package:waffir/features/Profil/profile_controller.dart';
import 'package:waffir/features/cart/controllers/cart_controller.dart';
import 'package:waffir/features/notifs/fcm_service.dart';

class AppBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(ProfileController());
    Get.put(FCMService());
    Get.put(FavController());
    Get.put(DiscoverVendorsController());
    Get.put(CartController());
  }
}
