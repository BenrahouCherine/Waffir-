import 'package:get/get.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class decController extends GetxController {
static  decController get instance => Get.find();


final carouselCurrentIndex = 0.obs; 

void updatePageIndicator(index){

  carouselCurrentIndex.value = index ;
}


}