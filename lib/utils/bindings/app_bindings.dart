import 'package:get/get.dart';
import 'package:waffir/features/Favoris/controllers/fav_controller.dart';
import 'package:waffir/features/Nos_Vendeurs/screens/decouvrir/nos_vendeurs/controller/discover_vendors_controller.dart';
import 'package:waffir/features/Profil/profile_controller.dart';
import 'package:waffir/features/cart/controllers/cart_controller.dart';
import 'package:waffir/features/decouvrir/controllers/decouvrir_controller.dart';
import 'package:waffir/features/map/controllers/map_controller.dart';
import 'package:waffir/features/map/services/geolocation_service.dart';
import 'package:waffir/features/orders/client/controllers/order_controller.dart';
import 'package:waffir/features/orders/vendor/controllers/vendor_orders_controller.dart';
import 'package:waffir/navigation_menu.dart';

class AppBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(GeoLocationService(), permanent: true);
    Get.put(ProfileController(), permanent: true);
    Get.put(DiscoverVendorsController());
    Get.put(MapController());
    Get.lazyPut(() => OrderController(), fenix: true);
    Get.lazyPut(() => CartController(), fenix: true);
    Get.lazyPut(() => FavController(), fenix: true);
    Get.lazyPut(() => DecouvrirController(), fenix: true);
    Get.lazyPut(() => NavigationController(), fenix: true);
    Get.lazyPut(() => VendorOrdersController(), fenix: true);
  }
}
