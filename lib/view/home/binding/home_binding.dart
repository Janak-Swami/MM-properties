import 'package:get/get.dart';
//import 'package:mm_properties/api/api.dart';
import 'package:mm_properties/view/home/controller/favorite_controller.dart';
import '../controller/home_controller.dart';
import '../controller/sale_properties_controller.dart';
import '../controller/rent_properties_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(() => HomeController());

    Get.lazyPut<SalePropertiesController>(() => SalePropertiesController());
    Get.lazyPut<RentPropertiesController>(() => RentPropertiesController());
    // Get.lazyPut<FavoriteController>(() => FavoriteController());
    Get.put(FavoriteController());
  }
}
