import 'package:flutter/material.dart';
import 'package:mm_properties/data/model/property_model';
import 'package:mm_properties/utility/common/app_colors.dart';

class PropertyTypeTabs extends StatelessWidget {
  final PropertyType selectedType;
  final ValueChanged<PropertyType> onTypeSelected;

  const PropertyTypeTabs({
    super.key,
    required this.selectedType,
    required this.onTypeSelected,
  });

  @override
  Widget build(BuildContext context) {
    final visibleTypes = PropertyType.values
        .where((type) => type != PropertyType.All)
        .toList();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: visibleTypes.map((type) {
          final bool isSelected = type == selectedType;
          final String typeName = type.toString().split('.').last;

          return Expanded(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 8),
              child: GestureDetector(
                onTap: () => onTypeSelected(type),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: BoxDecoration(
                    color: isSelected ? AppColors.munsell : Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    typeName,
                    style: TextStyle(
                      color: isSelected ? Colors.white : AppColors.darkGrey,
                      fontWeight: isSelected
                          ? FontWeight.bold
                          : FontWeight.normal,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
