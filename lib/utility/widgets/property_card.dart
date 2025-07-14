import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mm_properties/data/model/property_model';
import 'package:mm_properties/utility/common/app_colors.dart';
import 'package:mm_properties/utility/common/asset_paths.dart';

class PropertyCard extends StatelessWidget {
  final Property property;
  final VoidCallback onTap;
  final bool showTags;
  final VoidCallback onFavoriteToggle;

  const PropertyCard({
    super.key,
    required this.property,
    required this.onTap,
    this.showTags = true,
    required this.onFavoriteToggle,
  });

  @override
  Widget build(BuildContext context) {
    final hasImages = property.imageUrl.isNotEmpty;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (hasImages) _buildImageHeader(),
            if (hasImages) const SizedBox(height: 8),

            _buildPriceBar(),
            const SizedBox(height: 6),

            Text(
              property.title,
              style: GoogleFonts.openSans(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 4),

            Text(
              'Residential  |  Semi-Detached  |  ${property.status.name}',
              style: GoogleFonts.openSans(
                color: Colors.grey[600],
                fontSize: 13,
              ),
            ),
            const SizedBox(height: 8),

            _buildFeatureRow(),
            const SizedBox(height: 12),

            _buildBottomInfoRow(),
          ],
        ),
      ),
    );
  }

  Widget _buildImageHeader() {
    return SizedBox(
      height: 166,
      width: double.infinity,
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Row(
              children: [
                Expanded(flex: 2, child: _buildImage(property.imageUrl[0])),
                if (property.imageUrl.length > 1) ...[
                  const SizedBox(width: 5),
                  Expanded(
                    flex: property.imageUrl.length > 2 ? 1 : 2,
                    child: Column(
                      children: [
                        Expanded(child: _buildImage(property.imageUrl[1])),
                        if (property.imageUrl.length > 2) ...[
                          const SizedBox(height: 5),
                          Expanded(child: _buildImage(property.imageUrl[2])),
                        ],
                      ],
                    ),
                  ),
                ],
              ],
            ),
          ),
          if (showTags && property.isFeatured)
            Positioned(
              top: 10,
              left: 10,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.green,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  ),
                ),
                child: Text(
                  'FEATURED',
                  style: GoogleFonts.openSans(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          Positioned(
            top: 10,
            right: 10,
            child: Obx(
              () => GestureDetector(
                onTap: onFavoriteToggle,
                child: Container(
                  padding: const EdgeInsets.all(6),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                  child: Icon(
                    property.isFavorite.value
                        ? Icons.favorite
                        : Icons.favorite_border,
                    color: Colors.red,
                    size: 20,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImage(String url) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Image.network(
        url,
        width: double.infinity,
        height: double.infinity,
        fit: BoxFit.cover,
        errorBuilder: (context, error, _) => Container(
          color: AppColors.chineseWhite.withValues(alpha: 0.4),
          alignment: Alignment.center,
          child: const Icon(
            Icons.image_not_supported,
            size: 40,
            color: Colors.grey,
          ),
        ),
      ),
    );
  }

  Widget _buildPriceBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.status,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(10),
          bottomRight: Radius.circular(10),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              '₹${property.price.toStringAsFixed(0)} (${property.priceUnit})',
              style: GoogleFonts.openSans(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Text(
            property.status.name,
            style: GoogleFonts.openSans(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _iconLabel(AssetPaths.bedIcon, '${property.beds}'),
        _iconLabel(AssetPaths.bathIcon, '${property.baths}'),
        _iconLabel(AssetPaths.prop, '${property.receptions}'),
        _iconLabel(
          AssetPaths.prop1,
          '${property.areaSqft.toInt()} sqft (₹${property.pricePerSqft.toInt()}/sqft)',
        ),
      ],
    );
  }

  Widget _iconLabel(String iconAssetPath, String text) {
    return Row(
      children: [
        Image.asset(
          iconAssetPath,
          width: 16,
          height: 16,
          color: Colors.grey[700],
        ),
        const SizedBox(width: 4),
        Text(
          text,
          style: GoogleFonts.openSans(fontSize: 13, color: Colors.black87),
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
        Text('Added on', style: GoogleFonts.openSans(fontSize: 10)),
        Text(
          property.addedOn,
          style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w400),
        ),
      ],
    );
  }

  Widget _buildAgentInfo() {
    return Container(
      constraints: const BoxConstraints(maxWidth: 120),
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
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              property.agentName,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.openSans(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: AppColors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
