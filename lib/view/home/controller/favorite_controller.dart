import 'package:get/get.dart';
import 'package:mm_properties/data/model/property_model';

class FavoriteController extends GetxController {
  final RxList<Property> _allFavorites = <Property>[].obs;
  final RxList<Property> filteredFavorites = <Property>[].obs;

  @override
  void onInit() {
    super.onInit();
    filteredFavorites.assignAll(_allFavorites);
  }

  List<Property> get favoriteProperties => filteredFavorites;

  void setAllProperties(List<Property> allProperties) {
    _allFavorites.assignAll(allProperties.where((p) => p.isFavorite.value));
    filteredFavorites.assignAll(_allFavorites);
    update();
  }

  void toggleFavorite(Property property) {
    property.isFavorite.toggle();

    if (property.isFavorite.value) {
      if (!_allFavorites.any((p) => p.id == property.id)) {
        _allFavorites.add(property);
      }
    } else {
      _allFavorites.removeWhere((p) => p.id == property.id);
    }

    filteredFavorites.assignAll(_allFavorites);
    update();
  }

  void applyFilters(Map<String, dynamic> filters) {
    final type = filters['propertyType'];
    final beds = filters['beds'] as int;
    final baths = filters['baths'] as int;
    final receptions = filters['receptions'] as int;
    final minArea = filters['area'] as double;
    final minPrice = filters['minPrice'] as double;
    final maxPrice = filters['maxPrice'] as double;

    final result = _allFavorites.where((property) {
      return (type == 'all' ||
              property.type.name.toLowerCase() == type.toString()) &&
          (beds == 0 || property.beds >= beds) &&
          (baths == 0 || property.baths >= baths) &&
          (receptions == 0 || property.receptions >= receptions) &&
          (property.areaSqft >= minArea) &&
          (property.price >= minPrice && property.price <= maxPrice);
    }).toList();

    filteredFavorites.assignAll(result);
    update();
  }

  void clearFilters() {
    filteredFavorites.assignAll(_allFavorites);
    update();
  }

  void navigateToPropertyDetails(Property property) {
    Get.toNamed('/property-details', arguments: property);
  }
}
