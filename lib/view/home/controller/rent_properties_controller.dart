import 'package:get/get.dart';
import 'package:mm_properties/data/model/property_model';

class RentPropertiesController extends GetxController {
  final RxList<Property> rentProperties = <Property>[].obs;
  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;

  final Rx<PropertyType> selectedPropertyType = PropertyType.All.obs;

  List<Property> _allRent = [];

  List<Property> get favoriteRentProperties =>
      _allRent.where((p) => p.isFavorite.value).toList();

  @override
  void onInit() {
    super.onInit();
    _loadDummyRentProperties();
  }

  void toggleFavorite(Property property) {
    property.isFavorite.toggle();
    update();
  }

  void _loadDummyRentProperties() {
    _allRent = [
      Property(
        id: 'r1',
        imageUrl: [
          'https://thumbs.dreamstime.com/b/modern-house-interior-exterior-design-46517595.jpg',
          'https://hips.hearstapps.com/hmg-prod.s3.amazonaws.com/images/suburban-house-royalty-free-image-1584972559.jpg',
          'https://www.bhg.com/thmb/TD9qUnFen4PBLDuB2hn9yhGXPv8=/1866x0/filters:no_upscale():strip_icc()/white-house-a-frame-section-c0a4a3b3-e722202f114e4aeea4370af6dbb4312b.jpg',
        ],

        title: 'Studio in JVC',
        description: 'Compact and affordable studio.',
        price: 3500,
        priceUnit: 'monthly',
        status: PropertyStatus.Rent,
        type: PropertyType.Apartment,
        beds: 0,
        baths: 1,
        receptions: 1,
        areaSqft: 400,
        pricePerSqft: 8.75,
        addedOn: '2025-01-12',
        agentName: 'Raja Ram ',
        agentLogoUrl:
            'https://graphicsfamily.com/wp-content/uploads/edd/2020/04/Professional-Real-Estate-Logo-Template-JPEG.jpg',
        mmpNo: 'MMP#5678',
        tenure: 'Short Term',
        address: 'JVC, Jaipur',
        whatsappNumber: '+91500000004',
        isPremium: false,
        isFeatured: false,
        isFavorite: false,
      ),

      Property(
        id: '5',
        title: 'Modern Pool',
        description: 'Beautiful 5BHK with garden and pool',
        imageUrl: [
          'https://hips.hearstapps.com/hmg-prod.s3.amazonaws.com/images/suburban-house-royalty-free-image-1584972559.jpg',
          'https://hips.hearstapps.com/hmg-prod.s3.amazonaws.com/images/suburban-house-royalty-free-image-1584972559.jpg',
          'https://hips.hearstapps.com/hmg-prod.s3.amazonaws.com/images/suburban-house-royalty-free-image-1584972559.jpg',
        ],
        price: 3000000,
        priceUnit: 'asking',
        status: PropertyStatus.Rent,
        type: PropertyType.House,
        beds: 5,
        baths: 6,
        receptions: 3,
        areaSqft: 8000,
        pricePerSqft: 20,
        addedOn: '2024-12-01',
        agentName: 'Janak Choudhary',
        agentLogoUrl:
            'https://mobilemarketingwatch.com/wp-content/gallery/real-estate-logos/Real-Estate-Logo-6.png',
        mmpNo: 'MMP123',
        tenure: 'Freehold',
        address: 'Jhumian Wali',
        whatsappNumber: '+91100000000',
        isFeatured: false,
        isPremium: true,
        isFavorite: false,
      ),

      Property(
        id: '1',
        title: 'Modern Villa with Pool',
        description: 'Beautiful 5BHK with garden and pool',
        imageUrl: [
          'https://i.pinimg.com/736x/0f/0f/36/0f0f36421e8e8eb3f231cb617808a561.jpg',

          'https://i.pinimg.com/736x/0f/0f/36/0f0f36421e8e8eb3f231cb617808a561.jpg',
          'https://www.maramani.com/cdn/shop/files/3BedroomHousePlanwithflatroof-ID33402-Image01.jpg?crop=center&height=1200&v=1692783449&width=1200',
        ],
        price: 15000,
        priceUnit: 'asking',
        status: PropertyStatus.Rent,
        type: PropertyType.Villa,
        beds: 5,
        baths: 6,
        receptions: 3,
        areaSqft: 8000,
        pricePerSqft: 1875,
        addedOn: '2024-12-01',
        agentName: 'Janak',
        agentLogoUrl:
            'https://mobilemarketingwatch.com/wp-content/gallery/real-estate-logos/Real-Estate-Logo-6.png',
        mmpNo: 'MMP123',
        tenure: 'Freehold',
        address: 'Jhumian Wali',
        whatsappNumber: '+91100000000',
        isFeatured: true,
        isPremium: true,
        isFavorite: true,
      ),

      Property(
        id: 'r2',
        imageUrl: [
          'https://thumbs.dreamstime.com/b/modern-house-interior-exterior-design-46517595.jpg',
          'https://hips.hearstapps.com/hmg-prod.s3.amazonaws.com/images/suburban-house-royalty-free-image-1584972559.jpg',
          'https://www.bhg.com/thmb/TD9qUnFen4PBLDuB2hn9yhGXPv8=/1866x0/filters:no_upscale():strip_icc()/white-house-a-frame-section-c0a4a3b3-e722202f114e4aeea4370af6dbb4312b.jpg',
        ],
        title: '1BHK in Dubai Marina',
        description: 'Sea-view apartment perfect for couples.',
        price: 6800,
        priceUnit: 'monthly',
        status: PropertyStatus.Rent,
        type: PropertyType.Apartment,
        beds: 1,
        baths: 1,
        receptions: 1,
        areaSqft: 850,
        pricePerSqft: 8.0,
        addedOn: '2025-02-15',
        agentName: 'Sudhir Khan',
        agentLogoUrl:
            'https://cdn.dribbble.com/users/5832433/screenshots/14499634/1___4x.jpg',
        mmpNo: 'MMP#7888',
        tenure: 'Long Term',
        address: 'Dubai Marina',
        whatsappNumber: '+971500000005',
        isPremium: true,
        isFeatured: true,
        isFavorite: true,
      ),
    ];

    rentProperties.assignAll(_allRent);
  }

  void updatePropertyTypeFilter(PropertyType type) {
    if (selectedPropertyType.value == type) {
      selectedPropertyType.value = PropertyType.All;
    } else {
      selectedPropertyType.value = type;
    }
    update();

    if (selectedPropertyType.value == PropertyType.All) {
      rentProperties.assignAll(_allRent);
    } else {
      rentProperties.assignAll(_allRent.where((p) => p.type == type).toList());
    }
  }

  void searchProperties(String query) {
    final filtered = _allRent
        .where(
          (p) =>
              p.title.toLowerCase().contains(query.toLowerCase()) ||
              p.description.toLowerCase().contains(query.toLowerCase()),
        )
        .toList();

    rentProperties.assignAll(filtered);
    update();
  }

  void applyFilters(Map<String, dynamic> filters) {
    final String type = filters['propertyType'] ?? 'all';
    final int beds = filters['beds'] ?? 0;
    final int baths = filters['baths'] ?? 0;
    final int receptions = filters['receptions'] ?? 0;
    final double minArea = filters['area'] ?? 0.0;
    final double minPrice = filters['minPrice'] ?? 0.0;
    final double maxPrice = filters['maxPrice'] ?? double.infinity;

    final filtered = _allRent.where((property) {
      return (type == 'all' ||
              property.type.name.toLowerCase() == type.toLowerCase()) &&
          (beds == 0 || property.beds >= beds) &&
          (baths == 0 || property.baths >= baths) &&
          (receptions == 0 || property.receptions >= receptions) &&
          (property.areaSqft >= minArea) &&
          (property.price >= minPrice && property.price <= maxPrice);
    }).toList();

    rentProperties.assignAll(filtered);
    update();
  }
}
