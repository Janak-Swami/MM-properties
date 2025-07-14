import 'package:get/get.dart';
import 'package:mm_properties/data/model/property_model';
import 'package:mm_properties/navigation/app_routes.dart';
import 'package:mm_properties/view/home/controller/favorite_controller.dart';
import 'package:mm_properties/view/home/controller/rent_properties_controller.dart';
import 'package:mm_properties/view/home/controller/sale_properties_controller.dart';

class HomeController extends GetxController {
  int selectedBottomNavIndex = 0;
  String currentAppBarTitle = 'Sale';

  final RxList<Property> allProperties = <Property>[].obs;
  final RxList<Property> favoriteProperties = <Property>[].obs;

  @override
  void onInit() {
    super.onInit();
    updateAppBarTitle(selectedBottomNavIndex);

    final rent = Get.find<RentPropertiesController>().favoriteRentProperties;
    final sale = Get.find<SalePropertiesController>().favoriteSaleProperties;
    Get.find<FavoriteController>().setAllProperties([...rent, ...sale]);
  }

  void toggleFavorite(Property property) {
    property.isFavorite.toggle();

    if (property.isFavorite.value) {
      if (!favoriteProperties.any((p) => p.id == property.id)) {
        favoriteProperties.add(property);
      }
    } else {
      favoriteProperties.removeWhere((p) => p.id == property.id);
    }

    Get.find<FavoriteController>().setAllProperties(favoriteProperties);
    update();
  }

  void changeBottomNavTab(int index) {
    selectedBottomNavIndex = index;
    updateAppBarTitle(index);
    update();
  }

  void updateAppBarTitle(int index) {
    switch (index) {
      case 0:
        currentAppBarTitle = 'Sale';
        break;
      case 1:
        currentAppBarTitle = 'Rent';
        break;
      case 2:
        currentAppBarTitle = 'Favorite';
        break;
    }
  }

  void navigateToFilter(String tab) async {
    String contextType;
    switch (selectedBottomNavIndex) {
      case 0:
        contextType = 'sale';
        break;
      case 1:
        contextType = 'rent';
        break;
      case 2:
        contextType = 'favorite';
        break;
      default:
        contextType = 'sale';
    }

    final result = await Get.toNamed(
      '/filter',
      arguments: {'contextType': contextType},
    );

    if (result != null && result is Map<String, dynamic>) {
      final status = result['status'];

      if (status == 'sale') {
        Get.find<SalePropertiesController>().applyFilters(result);
      } else if (status == 'rent') {
        Get.find<RentPropertiesController>().applyFilters(result);
      } else if (status == 'favorite') {
        Get.find<FavoriteController>().applyFilters(result);
      }
    }
  }

  void performSearch(String query) {
    if (selectedBottomNavIndex == 0) {
      Get.find<SalePropertiesController>().searchProperties(query);
    } else if (selectedBottomNavIndex == 1) {
      Get.find<RentPropertiesController>().searchProperties(query);
    }
  }

  void navigateToPropertyDetails(Property property) {
    Get.toNamed(AppRoutes.propertyDetails, arguments: property);
  }
}
