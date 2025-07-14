import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mm_properties/data/model/property_model';
import 'package:mm_properties/utility/common/app_colors.dart';
import 'package:mm_properties/utility/common/asset_paths.dart';

class SuggestionCard extends StatelessWidget {
  final Property property;
  final VoidCallback onTap;
  final VoidCallback onFavoriteToggle;

  const SuggestionCard({
    super.key,
    required this.property,
    required this.onTap,
    required this.onFavoriteToggle,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(18),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildImageWithFavorite(),
            const SizedBox(width: 12),
            Expanded(child: _buildDetailsSection()),
          ],
        ),
      ),
    );
  }

  Widget _buildImageWithFavorite() {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Image.network(
            property.imageUrl.first,
            width: 116,
            height: 166,
            fit: BoxFit.cover,
          ),
        ),
        Positioned(
          top: 6,
          right: 6,
          child: GestureDetector(
            onTap: onFavoriteToggle,
            child: Container(
              padding: const EdgeInsets.all(6),
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: Icon(
                property.isFavorite.value
                    ? Icons.favorite
                    : Icons.favorite_border,
                color: property.isFavorite.value ? Colors.red : Colors.grey,
                size: 20,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDetailsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildPriceAndStatus(),
        const SizedBox(height: 4),
        Text(
          property.title,
          style: GoogleFonts.openSans(
            fontWeight: FontWeight.bold,
            fontSize: 13,
            color: AppColors.black,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          property.type.name,
          style: GoogleFonts.openSans(color: AppColors.darkGrey, fontSize: 13),
        ),
        const SizedBox(height: 6),
        _buildFeatureIcons(),
        const SizedBox(height: 8),
        _buildBottomInfoRow(),
      ],
    );
  }

  Widget _buildPriceAndStatus() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        RichText(
          text: TextSpan(
            text: '₹${property.price.toStringAsFixed(0)}',
            style: GoogleFonts.openSans(
              color: AppColors.munsell,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
            children: [
              TextSpan(
                text: ' (asking)',
                style: GoogleFonts.openSans(
                  color: AppColors.munsell,
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
        Text(
          property.status == PropertyStatus.Sale ? 'Sale' : 'Rent',
          style: GoogleFonts.inter(
            color: AppColors.black,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildFeatureIcons() {
    return Wrap(
      spacing: 10,
      runSpacing: 6,
      children: [
        _buildIconLabel(AssetPaths.bedIcon, '${property.beds}'),
        _buildIconLabel(AssetPaths.bathIcon, '${property.baths}'),
        _buildIconLabel(AssetPaths.receptionIcon, '${property.receptions}'),
        _buildIconLabel(
          AssetPaths.prop1,
          '${property.areaSqft.toStringAsFixed(0)} sqft (₹${property.pricePerSqft.toStringAsFixed(0)}/sqft)',
        ),
      ],
    );
  }

  Widget _buildBottomInfoRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [_buildAddedOn(), _buildAgentInfo()],
    );
  }

  Widget _buildAddedOn() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Added on',
          style: GoogleFonts.montserrat(
            fontSize: 10,
            fontWeight: FontWeight.w400,
          ),
        ),
        Text(
          property.addedOn,
          style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w400),
        ),
      ],
    );
  }

  Widget _buildAgentInfo() {
    return Container(
      constraints: const BoxConstraints(maxWidth: 100),
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
      decoration: BoxDecoration(
        color: AppColors.chineseWhite.withValues(alpha: 0.4),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(17),
          bottomRight: Radius.circular(17),
        ),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 18,
            backgroundColor: Colors.grey.shade200,
            backgroundImage: property.agentLogoUrl.isNotEmpty
                ? NetworkImage(property.agentLogoUrl)
                : null,
            child: property.agentLogoUrl.isEmpty
                ? const Icon(Icons.person, size: 16, color: Colors.grey)
                : null,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              property.agentName,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.openSans(
                fontSize: 10,
                fontWeight: FontWeight.w600,
                color: AppColors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIconLabel(String? iconPath, String label) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (iconPath != null)
          Image.asset(
            iconPath,
            width: 16,
            height: 16,
            color: AppColors.darkGrey,
          ),
        if (iconPath != null) const SizedBox(width: 4),
        Text(
          label,
          style: GoogleFonts.openSans(fontSize: 13, color: AppColors.darkGrey),
        ),
      ],
    );
  }
}
