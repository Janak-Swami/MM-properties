import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mm_properties/utility/common/app_colors.dart';
import 'package:mm_properties/utility/widgets/property_card.dart';
import 'package:mm_properties/utility/widgets/property_type_tabs.dart';
import 'package:mm_properties/utility/widgets/suggestion_card.dart';
import '../controller/sale_properties_controller.dart';
import '../controller/home_controller.dart';

class SalePropertiesView extends StatefulWidget {
  const SalePropertiesView({super.key});

  @override
  State<SalePropertiesView> createState() => _SalePropertiesViewState();
}

class _SalePropertiesViewState extends State<SalePropertiesView> {
  final controller = Get.find<SalePropertiesController>();
  final homeController = Get.find<HomeController>();

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
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final properties = controller.saleProperties;

      return CustomScrollView(
        controller: _scrollController,
        slivers: [
          if (_showHeader) ...[
            const SliverToBoxAdapter(child: SizedBox(height: 10)),

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

          if (properties.isEmpty)
            const SliverFillRemaining(
              child: Center(
                child: Text(
                  'No sale properties found.',
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
                    'Recommended for You',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppColors.black,
                    ),
                  ),
                ),
                SizedBox(
                  height: 205,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: controller.saleProperties.length > 5
                        ? 5
                        : controller.saleProperties.length,
                    itemBuilder: (context, index) {
                      final property = controller.saleProperties[index];
                      return Container(
                        width: 340,
                        margin: const EdgeInsets.only(right: 10),
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
