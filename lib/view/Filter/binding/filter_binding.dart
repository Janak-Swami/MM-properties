import 'package:get/get.dart';
//import 'package:mm_properties/api/api.dart';
import '../controller/filter_controller.dart';

class FilterBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FilterController>(() => FilterController());
  }
}
