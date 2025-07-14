// ignore_for_file: unrelated_type_equality_checks

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mm_properties/data/model/property_model';
import 'package:mm_properties/utility/common/app_colors.dart';
import '../controller/filter_controller.dart';

class FilterView extends StatelessWidget {
  final String contextType;

  const FilterView({super.key, required this.contextType});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<FilterController>();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.initWithContextType(contextType);
      controller.update(); // trigger UI update
    });

    return GetBuilder<FilterController>(
      builder: (controller) {
        return Scaffold(
          backgroundColor: AppColors.ghostWhite,
          appBar: AppBar(
            backgroundColor: AppColors.ghostWhite,
            elevation: 0,
            leading: IconButton(
              icon: const Icon(
                Icons.arrow_back_ios_new,
                color: AppColors.black,
              ),
              onPressed: () => Get.back(),
            ),
            title: Text(
              contextType == 'rent'
                  ? 'What are you looking for?'
                  : contextType == 'favorite'
                  ? 'Filter'
                  : 'What are you looking for?',
              style: GoogleFonts.raleway(
                fontSize: 18,
                color: AppColors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            centerTitle: true,
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildStatusSelector(controller),
                const SizedBox(height: 25),

                _buildTextField(
                  hintText: 'Enter location',
                  icon: Icons.location_on_outlined,
                  onChanged: controller.updateLocation,
                ),
                const SizedBox(height: 15),

                _buildDropdown(
                  hintText: 'Select radius',
                  items: ['5 km', '10 km', '20 km', '50 km'],
                  onChanged: (value) {
                    if (value != null) {
                      controller.updateRadius(
                        double.parse(value.split(' ')[0]),
                      );
                    }
                  },
                ),
                const SizedBox(height: 15),

                _buildDropdown(
                  hintText: 'Select property type',
                  items: PropertyType.values
                      .where((type) => type != PropertyType.All)
                      .map((e) => e.name)
                      .toList(),
                  onChanged: (value) {
                    if (value != null) {
                      controller.updatePropertyType(
                        PropertyType.values.firstWhere(
                          (type) => type.name == value,
                        ),
                      );
                    }
                  },
                ),
                const SizedBox(height: 20),

                _buildCounter(
                  'Beds',
                  controller.beds,
                  controller.incrementBeds,
                  controller.decrementBeds,
                  controller,
                ),
                _buildCounter(
                  'Baths',
                  controller.baths,
                  controller.incrementBaths,
                  controller.decrementBaths,
                  controller,
                ),
                _buildCounter(
                  'Receptions',
                  controller.receptions,
                  controller.incrementReceptions,
                  controller.decrementReceptions,
                  controller,
                ),
                const SizedBox(height: 20),

                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextField(
                    keyboardType: TextInputType.number,
                    onChanged: (val) {
                      final parsed = double.tryParse(val);
                      if (parsed != null) controller.area.value = parsed;
                    },
                    decoration: const InputDecoration(
                      hintText: 'Area',
                      hintStyle: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF6A6A6A),
                        fontSize: 15,
                      ),
                      suffixText: 'Sqft',
                      suffixStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.black,
                        fontSize: 15,
                      ),

                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(vertical: 12),
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Price',
                        style: GoogleFonts.raleway(
                          fontSize: 13,
                          color: AppColors.darkGrey.withValues(alpha: 0.8),
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      RangeSlider(
                        values: controller.priceRange.value,
                        min: 0,
                        max: 20000000,
                        divisions: 200,
                        labels: RangeLabels(
                          '₹${controller.priceRange.value.start.toStringAsFixed(0)}',
                          '₹${controller.priceRange.value.end.toStringAsFixed(0)}',
                        ),
                        onChanged: (values) {
                          controller.updatePriceRange(values);
                          controller.update();
                        },
                        activeColor: AppColors.munsell,
                        inactiveColor: AppColors.chineseWhite,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '2lakh',
                            style: GoogleFonts.raleway(
                              fontSize: 15,
                              color: AppColors.darkGrey,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Text(
                            '1CR',
                            style: GoogleFonts.raleway(
                              fontSize: 15,
                              color: AppColors.darkGrey,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 30),

                Container(
                  decoration: BoxDecoration(
                    color: AppColors.munsell,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: ElevatedButton(
                      onPressed: () => controller.applyFilters(),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.munsell,
                        foregroundColor: AppColors.white,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 80,
                          vertical: 15,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        elevation: 0,
                      ),
                      child: Text(
                        contextType == 'rent'
                            ? 'FIND PROPERTIES'
                            : contextType == 'favorite'
                            ? 'APPLY'
                            : 'FIND PROPERTIES',
                        style: GoogleFonts.lato(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildStatusSelector(FilterController controller) {
    return Container(
      height: 180,
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        image: const DecorationImage(
          image: AssetImage('assets/images/filter.jpg'),
          fit: BoxFit.cover,
        ),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          Container(
            margin: const EdgeInsets.only(top: 65),
            child: Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      controller.updateStatus(PropertyStatus.Sale);
                      controller.update();
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      decoration: BoxDecoration(
                        color: controller.selectedStatus == PropertyStatus.Sale
                            ? AppColors.munsell
                            : Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          if (controller.selectedStatus == PropertyStatus.Sale)
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.1),
                              blurRadius: 4,
                              offset: const Offset(0, 2),
                            ),
                        ],
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        'SALE',
                        style: GoogleFonts.raleway(
                          color:
                              controller.selectedStatus == PropertyStatus.Sale
                              ? Colors.white
                              : AppColors.munsell,
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      controller.updateStatus(PropertyStatus.Rent);
                      controller.update();
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      decoration: BoxDecoration(
                        color: controller.selectedStatus == PropertyStatus.Rent
                            ? AppColors.munsell
                            : Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          if (controller.selectedStatus == PropertyStatus.Rent)
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.1),
                              blurRadius: 4,
                              offset: const Offset(0, 2),
                            ),
                        ],
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        'RENT',
                        style: GoogleFonts.raleway(
                          color:
                              controller.selectedStatus == PropertyStatus.Rent
                              ? Colors.white
                              : AppColors.munsell,
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
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
    );
  }

  Widget _buildTextField({
    required String hintText,
    required IconData icon,
    required ValueChanged<String> onChanged,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextField(
        decoration: InputDecoration(
          suffixIcon: Icon(icon, color: AppColors.darkGrey),
          hintText: hintText,
          hintStyle: GoogleFonts.raleway(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF6A6A6A),
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(vertical: 12),
        ),
        onChanged: onChanged,
      ),
    );
  }

  Widget _buildDropdown({
    required String hintText,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: DropdownButtonFormField<String>(
        decoration: const InputDecoration(
          border: InputBorder.none,
          isDense: false,
        ),
        value: null,
        hint: Text(
          hintText,
          style: GoogleFonts.raleway(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF6A6A6A),
          ),
        ),
        items: items
            .map(
              (value) => DropdownMenuItem<String>(
                value: value,
                child: Text(
                  value,
                  style: GoogleFonts.raleway(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
              ),
            )
            .toList(),
        onChanged: onChanged,
        isExpanded: true,
        icon: const Icon(Icons.keyboard_arrow_down),
      ),
    );
  }

  Widget _buildCounter(
    String label,
    RxInt count,
    VoidCallback onIncrement,
    VoidCallback onDecrement,
    FilterController controller,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '# Of $label',
            style: GoogleFonts.raleway(
              fontSize: 15,
              fontWeight: FontWeight.w600,
            ),
          ),
          Container(
            width: 125,
            height: 45,
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    onDecrement();
                    controller.update();
                  },
                  child: Container(
                    width: 38,
                    height: 38,
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(10),
                        bottomLeft: Radius.circular(10),
                      ),
                    ),
                    child: const Icon(
                      Icons.remove,
                      size: 20,
                      color: AppColors.black,
                    ),
                  ),
                ),
                Container(
                  width: 45,
                  height: 35,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: AppColors.chineseWhite.withAlpha(128),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    count.value.toString(),
                    style: GoogleFonts.raleway(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    onIncrement();
                    controller.update();
                  },
                  child: Container(
                    width: 38,
                    height: 38,
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                      ),
                    ),
                    child: const Icon(
                      Icons.add,
                      size: 20,
                      color: AppColors.black,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
