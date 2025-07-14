import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mm_properties/utility/widgets/suggestion_card.dart';
import 'package:mm_properties/view/home/controller/home_controller.dart';
import '../../home/controller/rent_properties_controller.dart';
import '../../home/controller/sale_properties_controller.dart';

class FavoriteView extends StatelessWidget {
  const FavoriteView({super.key});

  @override
  Widget build(BuildContext context) {
    final RentPropertiesController rentController = Get.find();
    final SalePropertiesController saleController = Get.find();
    final HomeController homeController = Get.find();

    return Obx(() {
      final favorites = [
        ...saleController.favoriteSaleProperties,
        ...rentController.favoriteRentProperties,
      ];

      if (favorites.isEmpty) {
        return const Center(child: Text('No favorites yet.'));
      }

      return ListView.builder(
        padding: const EdgeInsets.only(bottom: 90),
        itemCount: favorites.length,
        itemBuilder: (context, index) {
          final property = favorites[index];
          return SuggestionCard(
            property: property,
            onTap: () => homeController.navigateToPropertyDetails(property),
            onFavoriteToggle: () {
              property.isFavorite.toggle();
              saleController.update();
              rentController.update();
            },
          );
        },
      );
    });
  }
}
