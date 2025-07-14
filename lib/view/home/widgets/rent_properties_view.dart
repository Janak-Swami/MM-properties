import 'package:flutter/material.dart';
// ignore: unnecessary_import
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:mm_properties/utility/common/app_colors.dart';
import 'package:mm_properties/utility/widgets/property_card.dart';
import 'package:mm_properties/utility/widgets/property_type_tabs.dart';
import 'package:mm_properties/utility/widgets/suggestion_card.dart';
import '../controller/rent_properties_controller.dart';
import '../controller/home_controller.dart';

class RentPropertiesView extends StatefulWidget {
  const RentPropertiesView({super.key});

  @override
  State<RentPropertiesView> createState() => _RentPropertiesViewState();
}

class _RentPropertiesViewState extends State<RentPropertiesView> {
  final RentPropertiesController controller = Get.find();
  final HomeController homeController = Get.find();

  final ScrollController _scrollController = ScrollController();

  bool _showHeader = true;
  double _lastOffset = 0;

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(() {
      final offset = _scrollController.offset;

      if (offset > _lastOffset + 10 && _showHeader) {
        setState(() => _showHeader = false);
      } else if (offset < _lastOffset - 10 && !_showHeader) {
        setState(() => _showHeader = true);
      }

      _lastOffset = offset;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final properties = controller.rentProperties;

      return CustomScrollView(
        controller: _scrollController,
        slivers: [
          if (_showHeader) ...[
            SliverToBoxAdapter(child: const SizedBox(height: 10)),

            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: PropertyTypeTabs(
                  selectedType: controller.selectedPropertyType.value,
                  onTypeSelected: controller.updatePropertyTypeFilter,
                ),
              ),
            ),

            const SliverToBoxAdapter(child: SizedBox(height: 10)),
          ],
          if (controller.isLoading.value)
            const SliverFillRemaining(
              child: Center(
                child: CircularProgressIndicator(color: AppColors.munsell),
              ),
            )
          else if (controller.errorMessage.isNotEmpty)
            SliverFillRemaining(
              child: Center(
                child: Text(
                  controller.errorMessage.value,
                  style: const TextStyle(color: AppColors.red, fontSize: 16),
                ),
              ),
            )
          else if (properties.isEmpty)
            const SliverFillRemaining(
              child: Center(
                child: Text(
                  'No rent properties found.',
                  style: TextStyle(color: AppColors.darkGrey, fontSize: 16),
                ),
              ),
            )
          else
            SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
                final property = properties[index];
                return PropertyCard(
                  property: property,
                  showTags: true,
                  onTap: () =>
                      homeController.navigateToPropertyDetails(property),
                  onFavoriteToggle: () => controller.toggleFavorite(property),
                );
              }, childCount: properties.length),
            ),

          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Text(
                    'Recommended Rentals',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppColors.black,
                    ),
                  ),
                ),
                SizedBox(
                  height: 210,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: controller.rentProperties.length > 5
                        ? 5
                        : controller.rentProperties.length,
                    itemBuilder: (context, index) {
                      final property = controller.rentProperties[index];
                      return Container(
                        width: 340,
                        margin: const EdgeInsets.only(right: 16),
                        child: SuggestionCard(
                          property: property,
                          onTap: () => homeController.navigateToPropertyDetails(
                            property,
                          ),
                          onFavoriteToggle: () =>
                              controller.toggleFavorite(property),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),

          const SliverToBoxAdapter(child: SizedBox(height: 90)),
        ],
      );
    });
  }
}
