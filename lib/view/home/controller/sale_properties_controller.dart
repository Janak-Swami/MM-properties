import 'package:get/get.dart';
import 'package:mm_properties/data/model/property_model';

class SalePropertiesController extends GetxController {
  final RxList<Property> saleProperties = <Property>[].obs;
  final Rx<PropertyType> selectedPropertyType = PropertyType.All.obs;

  List<Property> _allProperties = [];

  List<Property> get favoriteSaleProperties =>
      _allProperties.where((p) => p.isFavorite.value).toList();

  @override
  void onInit() {
    super.onInit();
    _loadDummyData();
  }

  void toggleFavorite(Property property) {
    property.isFavorite.toggle();
    update();
  }

  void _loadDummyData() {
    _allProperties = [
      Property(
        id: '1',
        title: 'Modern Villa with Pool',
        description: 'Beautiful 5BHK with garden and pool',
        imageUrl: [
          'https://hips.hearstapps.com/hmg-prod.s3.amazonaws.com/images/suburban-house-royalty-free-image-1584972559.jpg',
          'https://hips.hearstapps.com/hmg-prod.s3.amazonaws.com/images/suburban-house-royalty-free-image-1584972559.jpg',
          'https://hips.hearstapps.com/hmg-prod.s3.amazonaws.com/images/suburban-house-royalty-free-image-1584972559.jpg',
        ],
        price: 15000000,
        priceUnit: 'asking',
        status: PropertyStatus.Sale,
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
        id: '1',
        title: 'Modern Villa with Pool',
        description: 'Beautiful 5BHK with garden and pool',
        imageUrl: [
          'https://i.pinimg.com/736x/0f/0f/36/0f0f36421e8e8eb3f231cb617808a561.jpg',

          'https://i.pinimg.com/736x/0f/0f/36/0f0f36421e8e8eb3f231cb617808a561.jpg',
          'https://www.maramani.com/cdn/shop/files/3BedroomHousePlanwithflatroof-ID33402-Image01.jpg?crop=center&height=1200&v=1692783449&width=1200',
        ],
        price: 15000000,
        priceUnit: 'asking',
        status: PropertyStatus.Sale,
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
        id: '1',
        title: 'Modern Flat with Balcony',
        description: 'Beautiful 3bhk Apartment',
        imageUrl: [
          'https://upload.wikimedia.org/wikipedia/commons/1/1e/AIMCO_apartment_interior.jpg',
          'https://media.istockphoto.com/id/1299199492/photo/modern-apartment-building.jpg?s=612x612&w=0&k=20&c=XIAwzxRSI8K7PcHUE9whrLWzekmltIpeMAO8NQT18J8=',
          'https://www.nobroker.in/blog/wp-content/uploads/2024/02/three-bedroom-floor-plans.jpg',
        ],
        price: 15000000,
        priceUnit: 'asking',
        status: PropertyStatus.Sale,
        type: PropertyType.Apartment,
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
        id: '1',
        title: 'Modern Villa with Pool',
        description: 'Beautiful 5BHK with garden and pool',
        imageUrl: [
          'https://hips.hearstapps.com/hmg-prod.s3.amazonaws.com/images/suburban-house-royalty-free-image-1584972559.jpg',
          'https://hips.hearstapps.com/hmg-prod.s3.amazonaws.com/images/suburban-house-royalty-free-image-1584972559.jpg',
          'https://hips.hearstapps.com/hmg-prod.s3.amazonaws.com/images/suburban-house-royalty-free-image-1584972559.jpg',
        ],
        price: 15000000,
        priceUnit: 'asking',
        status: PropertyStatus.Sale,
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
      ),
      Property(
        id: '1',
        title: 'Modern Villa with Pool',
        description: 'Beautiful 5BHK with garden and pool',
        imageUrl: [
          'https://hips.hearstapps.com/hmg-prod.s3.amazonaws.com/images/suburban-house-royalty-free-image-1584972559.jpg',
          'https://hips.hearstapps.com/hmg-prod.s3.amazonaws.com/images/suburban-house-royalty-free-image-1584972559.jpg',
          'https://hips.hearstapps.com/hmg-prod.s3.amazonaws.com/images/suburban-house-royalty-free-image-1584972559.jpg',
        ],
        price: 15000000,
        priceUnit: 'asking',
        status: PropertyStatus.Sale,
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
        id: '2',
        title: 'Downtown Apartment',
        description: 'Stylish 2BHK with skyline view',
        imageUrl: [
          'https://hips.hearstapps.com/hmg-prod.s3.amazonaws.com/images/suburban-house-royalty-free-image-1584972559.jpg',
        ],
        price: 950000,
        priceUnit: 'asking',
        status: PropertyStatus.Sale,
        type: PropertyType.Apartment,
        beds: 2,
        baths: 2,
        receptions: 1,
        areaSqft: 1100,
        pricePerSqft: 863,
        addedOn: '2025-01-10',
        agentName: 'Sudhir Dhundhara',
        agentLogoUrl:
            'https://static.vecteezy.com/system/resources/previews/008/646/755/large_2x/real-estate-logo-design-vector.jpg',
        mmpNo: 'MMP456',
        tenure: 'Leasehold',
        address: 'Nihal Khera',
        whatsappNumber: '+91100000001',
        isFavorite: true,
      ),
    ];

    saleProperties.assignAll(_allProperties);
  }

  void updatePropertyTypeFilter(PropertyType type) {
    if (selectedPropertyType.value == type) {
      selectedPropertyType.value = PropertyType.All;
    } else {
      selectedPropertyType.value = type;
    }
    update();

    if (selectedPropertyType.value == PropertyType.All) {
      saleProperties.assignAll(_allProperties);
    } else {
      saleProperties.assignAll(
        _allProperties.where((p) => p.type == type).toList(),
      );
    }
  }

  void searchProperties(String query) {
    final filtered = _allProperties
        .where(
          (p) =>
              p.title.toLowerCase().contains(query.toLowerCase()) ||
              p.description.toLowerCase().contains(query.toLowerCase()),
        )
        .toList();

    saleProperties.assignAll(filtered);
    update();
  }

  void applyFilters(Map<String, dynamic> filters) {
    final type = filters['propertyType'];
    final beds = filters['beds'] as int;
    final baths = filters['baths'] as int;
    final receptions = filters['receptions'] as int;
    final minArea = filters['area'] as double;
    final minPrice = filters['minPrice'] as double;
    final maxPrice = filters['maxPrice'] as double;

    final filtered = _allProperties.where((property) {
      return (type == 'all' ||
              property.type.name.toLowerCase() == type.toString()) &&
          (beds == 0 || property.beds >= beds) &&
          (baths == 0 || property.baths >= baths) &&
          (receptions == 0 || property.receptions >= receptions) &&
          (property.areaSqft >= minArea) &&
          (property.price >= minPrice && property.price <= maxPrice);
    }).toList();

    saleProperties.assignAll(filtered);
    update();
  }
}
