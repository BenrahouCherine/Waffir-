import 'dart:async';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:waffir/features/Nos_Vendeurs/screens/decouvrir/nos_vendeurs/controller/discover_vendors_controller.dart';
import 'package:waffir/features/Profil/models/user.dart';
import 'package:waffir/features/map/services/geolocation_service.dart';

class MapController extends GetxController {
  RxSet<Marker> markers = <Marker>{}.obs;
  final locationData = Get.find<GeoLocationService>().locationData;

  RxBool isLoading = false.obs;

  final Completer<GoogleMapController> completer =
      Completer<GoogleMapController>();

  late CameraPosition initialCameraPosition;

  final discoverVendorController = Get.find<DiscoverVendorsController>();

  void initialize() {
    if (locationData != null) {
      initialCameraPosition = CameraPosition(
        target: LatLng(locationData?['latitude'], locationData?['longitude']),
        zoom: 10.0,
      );
      markers.add(Marker(
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure),
        markerId: const MarkerId('currentLocation'),
        position: LatLng(locationData?['latitude'], locationData?['longitude']),
      ));
    } else {
      initialCameraPosition = const CameraPosition(
        target: LatLng(37.42796133580664, -122.085749655962),
        zoom: 10,
      );
    }
  }

  Future setMarkersOfVendors() async {
    try {
      isLoading.value = true;
      await discoverVendorController.fetchVendors();
      var vendors = discoverVendorController.vendors;
      for (UserModel vendor in vendors) {
        markers.add(Marker(
          markerId: MarkerId(vendor.uid.toString()),
          position: vendor.location!,
          infoWindow: InfoWindow(
            title: "${vendor.firstName} ${vendor.lastName}",
            snippet: vendor.phone,
            onTap: () {
              log(vendor.firstName.toString());
            },
          ),
        ));
      }
    } catch (e) {
      printError(info: e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onInit() {
    initialize();
    setMarkersOfVendors();
    super.onInit();
  }

  @override
  void onClose() {
    markers.clear();
    super.onClose();
  }
}
