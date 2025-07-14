// ignore_for_file: file_names

import 'package:get/get.dart';
//import 'package:mm_properties/api/api.dart';

import '../controller/property_details_controller.dart';

class PropertyDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PropertyDetailsController>(() => PropertyDetailsController());
  }
}
