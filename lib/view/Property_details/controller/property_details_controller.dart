import 'package:get/get.dart';
import 'package:mm_properties/data/model/property_model';

class PropertyDetailsController extends GetxController {
  final Rxn<Property> property = Rxn<Property>();
  final RxList<Property> similarProperties = <Property>[].obs;
  var selectedTabIndex = 0.obs;
  final RxInt tabIndex = 0.obs;

  @override
  void onInit() {
    super.onInit();

    final args = Get.arguments;
    if (args != null && args is Property) {
      property.value = args;
      loadSimilarProperties();
    } else {
      property.value = null;
    }
  }

  void toggleFavorite() {
    if (property.value != null) {
      property.value!.isFavorite.toggle();
    }
  }

  void loadSimilarProperties() {
    final base = property.value;
    if (base == null) return;

    similarProperties.assignAll([
      base.copyWith(
        id: '${base.id}_sim1',
        title: '${base.title} (Nearby)',
        imageUrl: [
          'https://tse4.mm.bing.net/th/id/OIP.Fun3wrXk25N4JxXl5Kl2LgHaFD?pid=Api&P=0&h=180',
        ],
        price: base.price + 150000,
      ),
      base.copyWith(
        id: '${base.id}_sim2',
        title: '${base.title} (Also Viewed)',
        imageUrl: [
          'https://mixtafrica.com/wp-content/uploads/2023/12/Nigerian-House-Plan-Designs.jpg',
        ],
        price: base.price - 120000,
      ),
    ]);
  }

  void onPrevious() {}
}
