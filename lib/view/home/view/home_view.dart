import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mm_properties/utility/common/app_colors.dart';
import 'package:mm_properties/utility/common/asset_paths.dart';
import '../controller/home_controller.dart';
import '../widgets/sale_properties_view.dart';
import '../widgets/rent_properties_view.dart';
import '../widgets/favorite_view.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (controller) {
        return Scaffold(
          backgroundColor: AppColors.ghostWhite,
          extendBody: true,
          body: Column(
            children: [
              _buildHeaderWithSearch(controller),
              _buildBody(controller),
            ],
          ),
          bottomNavigationBar: _buildDynamicBumpNav(controller),
        );
      },
    );
  }

  Widget _buildHeaderWithSearch(HomeController controller) {
    final currentTab = controller.selectedBottomNavIndex;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 30, left: 0, right: 0, bottom: 6),
          child: Row(
            children: [
              Image.asset(
                AssetPaths.mmLogo,
                width: 200,
                height: 70,
                color: AppColors.black,
                fit: BoxFit.contain,
              ),
              const Spacer(),
              if (currentTab != 2)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 18,
                    vertical: 6,
                  ),
                  decoration: const BoxDecoration(
                    color: AppColors.munsell,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      bottomLeft: Radius.circular(20),
                    ),
                  ),
                  child: Text(
                    controller.currentAppBarTitle,
                    style: GoogleFonts.openSans(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
              else
                IconButton(
                  icon: Image.asset(
                    AssetPaths.filterIcon,
                    width: 30,
                    height: 30,
                  ),
                  onPressed: () => controller.navigateToFilter('sale'),
                ),
            ],
          ),
        ),
        if (currentTab != 2)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: TextField(
              onChanged: (value) => controller.performSearch(value),
              decoration: InputDecoration(
                hintText: 'Search House, Apartment, etc.',
                prefixIcon: const Icon(Icons.search, color: Colors.grey),
                suffixIcon: IconButton(
                  icon: Image.asset(
                    AssetPaths.filterIcon,
                    width: 30,
                    height: 30,
                  ),
                  onPressed: () {
                    final tab = currentTab == 0
                        ? 'sale'
                        : currentTab == 1
                        ? 'rent'
                        : 'favorite';
                    controller.navigateToFilter(tab);
                  },
                ),
                filled: true,
                fillColor: AppColors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 0,
                ),
              ),
            ),
          ),
        const SizedBox(height: 10),
      ],
    );
  }

  Widget _buildBody(HomeController controller) {
    return Expanded(
      child: IndexedStack(
        index: controller.selectedBottomNavIndex,
        children: const [
          SalePropertiesView(),
          RentPropertiesView(),
          FavoriteView(),
        ],
      ),
    );
  }

  Widget _buildDynamicBumpNav(HomeController controller) {
    final icons = [
      AssetPaths.saleIcon,
      AssetPaths.rentIcon,
      AssetPaths.favoriteIcon,
    ];
    final selectedIcons = [
      AssetPaths.saleIconSelected,
      AssetPaths.rentIconSelected,
      AssetPaths.favoriteIconSelected,
    ];

    final screenWidth = Get.width;

    return SizedBox(
      height: 120,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Column(
            children: [
              const SizedBox(height: 30),
              Container(
                margin: const EdgeInsets.all(15),
                width: screenWidth,
                height: 60,
                decoration: BoxDecoration(
                  color: const Color(0xFF3C475B),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 15),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(3, (index) {
                final isSelected = controller.selectedBottomNavIndex == index;
                return Padding(
                  padding: EdgeInsets.only(bottom: isSelected ? 15 : 0),
                  child: GestureDetector(
                    onTap: () => controller.changeBottomNavTab(index),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeOut,
                      width: isSelected ? 70 : 40,
                      height: isSelected ? 70 : 40,
                      margin: const EdgeInsets.only(bottom: 10),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? AppColors.munsell
                            : Colors.transparent,
                        shape: BoxShape.circle,
                        border: isSelected
                            ? Border.all(width: 3, color: Colors.white)
                            : null,
                        boxShadow: isSelected
                            ? [
                                BoxShadow(
                                  color: Colors.black.withValues(alpha: 0.2),
                                  blurRadius: 6,
                                  offset: const Offset(0, 3),
                                ),
                              ]
                            : [],
                      ),
                      child: Center(
                        child: Image.asset(
                          isSelected ? selectedIcons[index] : icons[index],
                          width: isSelected ? 30 : 25,
                          height: isSelected ? 30 : 25,
                          color: isSelected
                              ? AppColors.white
                              : const Color(0xFF8A919D),
                        ),
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}
