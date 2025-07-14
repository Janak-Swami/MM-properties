// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:mm_properties/data/model/property_model';
import 'package:mm_properties/utility/common/app_colors.dart';
import 'package:mm_properties/utility/common/asset_paths.dart';
import 'package:mm_properties/utility/widgets/suggestion_card.dart';

import '../controller/property_details_controller.dart';

class PropertyDetailsView extends GetView<PropertyDetailsController> {
  const PropertyDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final property = controller.property.value;

      if (property == null) {
        return const Scaffold(
          body: Center(
            child: CircularProgressIndicator(color: AppColors.munsell),
          ),
        );
      }

      return Scaffold(
        backgroundColor: AppColors.ghostWhite,
        body: Stack(
          children: [
            SingleChildScrollView(
              padding: const EdgeInsets.only(bottom: 80),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 10,
                      ),
                      child: Row(
                        children: [
                          IconButton(
                            icon: const Icon(
                              Icons.arrow_back_ios_new,
                              color: AppColors.black,
                            ),
                            onPressed: () => Get.back(),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'Property Details',
                            style: GoogleFonts.raleway(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: AppColors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.network(
                            property.imageUrl.first,
                            height: 220,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                        if (property.isFeatured)
                          Positioned(
                            top: 12,
                            left: 12,
                            child: _buildTag('FEATURED', AppColors.green),
                          ),
                        Positioned(
                          top: 12,
                          right: 12,
                          child: GestureDetector(
                            onTap: controller.toggleFavorite,
                            child: Container(
                              padding: const EdgeInsets.all(6),
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white,
                              ),
                              child: Image.asset(
                                property.isFavorite.value
                                    ? AssetPaths.favoriteIconSelected
                                    : AssetPaths.favoriteIcon,
                                width: 22,
                                height: 22,
                                color: property.isFavorite.value
                                    ? Colors.red
                                    : Colors.red,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 10),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.green,
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '₹${property.price.toStringAsFixed(0)} (${property.priceUnit})',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                          _buildTag(
                            property.status == PropertyStatus.Sale
                                ? 'Sale'
                                : 'Rent',
                            AppColors.green,
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 10),

                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 10,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          property.title,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: AppColors.black,
                          ),
                        ),
                        const SizedBox(height: 6),
                        const Text('Residential  |  Semi-Detached  |  Sale'),
                        const SizedBox(height: 8),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _buildIconLabel(
                              AssetPaths.bedIcon,
                              '${property.beds}',
                            ),
                            _buildIconLabel(
                              AssetPaths.bathIcon,
                              '${property.baths}',
                            ),
                            _buildIconLabel(
                              AssetPaths.prop,
                              '${property.receptions}',
                            ),
                            _buildIconLabel(
                              AssetPaths.prop1,
                              '${property.areaSqft.toInt()} sqft (₹${property.pricePerSqft.toInt()}/sqft)',
                            ),
                          ],
                        ),
                        const SizedBox(height: 15),
                        const Divider(
                          thickness: 2,
                          color: AppColors.chineseWhite,
                        ),
                        const SizedBox(height: 0),
                      ],
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 10,
                    ),
                    child: SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.darkGrey,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        onPressed: () {},
                        child: const Text(
                          'REQUEST A VIEWING',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'About The Professional',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: AppColors.white.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            children: [
                              CircleAvatar(
                                backgroundColor: AppColors.munsell,
                                radius: 22,
                                backgroundImage: NetworkImage(
                                  property.agentLogoUrl,
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      property.agentName,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(property.address),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 12),

                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: AppColors.white.withValues(alpha: 0.9),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      'MMP NO: ${property.mmpNo}',
                                      style: const TextStyle(fontSize: 13),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {},
                                    child: Row(
                                      children: [
                                        const Icon(
                                          Icons.location_on_outlined,
                                          color: AppColors.munsell,
                                          size: 18,
                                        ),
                                        const SizedBox(width: 4),
                                        Text(
                                          'Map View',
                                          style: TextStyle(
                                            fontSize: 13,
                                            color: AppColors.munsell,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 6),
                              Text(
                                'Tenure: ${property.tenure}',
                                style: const TextStyle(fontSize: 13),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  Obx(() {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 10,
                          ),
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(color: Colors.transparent),
                          child: Row(
                            children: [
                              Expanded(
                                child: GestureDetector(
                                  onTap: () => controller.tabIndex.value = 0,
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 10,
                                    ),
                                    decoration: BoxDecoration(
                                      color: controller.tabIndex.value == 0
                                          ? Colors.white
                                          : Colors.transparent,

                                      border: Border(
                                        bottom: BorderSide(
                                          color: controller.tabIndex.value == 0
                                              ? AppColors.munsell
                                              : Colors.transparent,
                                          width: 2.5,
                                        ),
                                      ),
                                    ),
                                    alignment: Alignment.center,
                                    child: Text(
                                      'Description',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                        color: controller.tabIndex.value == 0
                                            ? AppColors.munsell
                                            : Colors.black,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 4),

                              Expanded(
                                child: GestureDetector(
                                  onTap: () => controller.tabIndex.value = 1,
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 10,
                                    ),
                                    decoration: BoxDecoration(
                                      color: controller.tabIndex.value == 1
                                          ? Colors.white
                                          : Colors.transparent,

                                      border: Border(
                                        bottom: BorderSide(
                                          color: controller.tabIndex.value == 1
                                              ? AppColors.munsell
                                              : Colors.transparent,
                                          width: 2.5,
                                        ),
                                      ),
                                    ),
                                    alignment: Alignment.center,
                                    child: Text(
                                      'Key Features',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                        color: controller.tabIndex.value == 1
                                            ? AppColors.munsell
                                            : Colors.black,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 10),

                        Padding(
                          padding: const EdgeInsets.only(left: 30, right: 16),
                          child: controller.tabIndex.value == 0
                              ? Text(
                                  property.description,
                                  style: GoogleFonts.raleway(fontSize: 14),
                                  textAlign: TextAlign.justify,
                                )
                              : Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    _buildFeatureText('${property.beds} Beds'),
                                    _buildFeatureText(
                                      '${property.baths} Baths',
                                    ),
                                    _buildFeatureText(
                                      '${property.receptions} Receptions',
                                    ),
                                    _buildFeatureText(
                                      '${property.areaSqft.toStringAsFixed(0)} Sqft',
                                    ),
                                  ],
                                ),
                        ),
                      ],
                    );
                  }),

                  const SizedBox(height: 10),

                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      color: AppColors.white.withValues(alpha: 0.8),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30),
                          ),
                          child: Stack(
                            children: [
                              Image.asset(
                                AssetPaths.mapImage,
                                fit: BoxFit.fitWidth,
                                width: double.infinity,
                              ),

                              Positioned(
                                bottom: 0,
                                right: 0,
                                child: GestureDetector(
                                  onTap: () {},
                                  child: Container(
                                    width: 340,
                                    height: 56,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(30),
                                        bottomRight: Radius.circular(30),
                                      ),
                                      boxShadow: [],
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(18),
                                      child: Text(
                                        'View all on map',
                                        textAlign: TextAlign.center,

                                        style: GoogleFonts.raleway(
                                          color: const Color(0xFF06044F),
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  SizedBox(
                    height: 235,
                    child: Obx(() {
                      final list = controller.similarProperties;
                      if (list.isEmpty) {
                        return const Center(
                          child: Text('No similar properties found.'),
                        );
                      }
                      return ListView.builder(
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        itemCount: list.length,
                        itemBuilder: (_, i) => Container(
                          margin: const EdgeInsets.only(right: 20),
                          width: 340,
                          child: SuggestionCard(
                            property: list[i],
                            onTap: () {
                              if (list[i].id != controller.property.value?.id) {
                                Get.to(
                                  () => const PropertyDetailsView(),
                                  binding: BindingsBuilder(() {
                                    Get.create<PropertyDetailsController>(
                                      () => PropertyDetailsController(),
                                    );
                                  }),
                                  arguments: list[i],
                                );
                              }
                            },
                            onFavoriteToggle: controller.toggleFavorite,
                          ),
                        ),
                      );
                    }),
                  ),
                ],
              ),
            ),

            Positioned(
              bottom: 16,
              right: 16,
              child: FloatingActionButton(
                shape: const CircleBorder(),
                backgroundColor: Colors.green,
                onPressed: () async {
                  final phone = property.whatsappNumber;
                  final message = Uri.encodeComponent(
                    "Hello! I'm interested in your property '${property.title}' listed on MM Properties.",
                  );
                  final whatsappUrl = "https://wa.me/$phone?text=$message";

                  if (await canLaunchUrl(Uri.parse(whatsappUrl))) {
                    await launchUrl(
                      Uri.parse(whatsappUrl),
                      mode: LaunchMode.externalApplication,
                    );
                  } else {
                    Get.snackbar('Error', 'WhatsApp is not available.');
                  }
                },
                child: Image.asset(
                  'assets/icons/whatsapp_icon.png',
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ],
        ),
      );
    });
  }

  Widget _buildTag(String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 10,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildIconLabel(String? iconPath, String text) {
    return Row(
      children: [
        if (iconPath != null)
          Image.asset(
            iconPath,
            height: 18,
            width: 18,
            color: AppColors.darkGrey,
          ),
        if (iconPath != null) const SizedBox(width: 6),
        Text(
          text,
          style: GoogleFonts.openSans(fontSize: 13, color: AppColors.darkGrey),
        ),
      ],
    );
  }

  Widget _buildFeatureText(String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Text('• $label', style: GoogleFonts.openSans(fontSize: 13)),
    );
  }
}
