import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:mm_properties/data/model/property_model';

class FilterController extends GetxController {
  final Rx<PropertyStatus> selectedStatus = PropertyStatus.Sale.obs;
  final RxString location = ''.obs;
  final RxDouble radius = 5.0.obs;
  final Rx<PropertyType> selectedPropertyType = PropertyType.All.obs;
  final RxInt beds = 0.obs;
  final RxInt baths = 0.obs;
  final RxInt receptions = 0.obs;
  final RxDouble area = 0.0.obs;
  final Rx<RangeValues> priceRange = const RangeValues(200000, 10000000).obs;

  void applyFilters() {
    Get.back(
      result: {
        'status': selectedStatus.value.toString().split('.').last.toLowerCase(),
        'location': location.value,
        'radius': radius.value,
        'propertyType': selectedPropertyType.value
            .toString()
            .split('.')
            .last
            .toLowerCase(),
        'beds': beds.value,
        'baths': baths.value,
        'receptions': receptions.value,
        'area': area.value,
        'minPrice': priceRange.value.start,
        'maxPrice': priceRange.value.end,
      },
    );
  }

  void initWithContextType(String contextType) {
    if (contextType == 'rent') {
      selectedStatus.value = PropertyStatus.Rent;
    } else {
      selectedStatus.value = PropertyStatus.Sale;
    }
  }

  void updateStatus(PropertyStatus status) => selectedStatus.value = status;
  void updateLocation(String loc) => location.value = loc;
  void updateRadius(double val) => radius.value = val;
  void updatePropertyType(PropertyType type) =>
      selectedPropertyType.value = type;
  void incrementBeds() => beds.value++;
  void decrementBeds() => beds.value > 0 ? beds.value-- : null;
  void incrementBaths() => baths.value++;
  void decrementBaths() => baths.value > 0 ? baths.value-- : null;
  void incrementReceptions() => receptions.value++;
  void decrementReceptions() =>
      receptions.value > 0 ? receptions.value-- : null;
  void updatePriceRange(RangeValues values) => priceRange.value = values;
}
