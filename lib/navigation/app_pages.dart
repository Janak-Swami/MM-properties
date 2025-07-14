import 'package:get/get.dart';
import 'package:mm_properties/view/home/widgets/favorite_view.dart';
import 'package:mm_properties/view/Filter/binding/filter_binding.dart';
import 'package:mm_properties/view/Filter/view/filter_view.dart';
import 'package:mm_properties/view/Property_details/binding/property_details_binding.dart';
import 'package:mm_properties/view/Property_details/view/property_details_view.dart';
import 'package:mm_properties/view/splash/binding/splash_binding.dart';
import 'package:mm_properties/view/splash/view/splash_view.dart';

import '../view/home/binding/home_binding.dart';
import '../view/home/view/home_view.dart';
import '../view/onboarding/binding/onboarding_binding.dart';
import '../view/onboarding/view/onboarding_view.dart';
import 'app_routes.dart';

class AppPages {
  static const initial = AppRoutes.splash;

  static final routes = [
    GetPage(
      name: AppRoutes.splash,
      page: () => const SplashView(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: AppRoutes.onBoarding,
      page: () => const OnboardingView(),
      binding: OnboardingBinding(),
    ),
    GetPage(
      name: AppRoutes.home,
      page: () => const HomeView(),
      binding: HomeBinding(),
      transition: Transition.rightToLeftWithFade,
      transitionDuration: Duration(milliseconds: 150),
    ),
    GetPage(name: AppRoutes.favorites, page: () => const FavoriteView()),
    GetPage(
      name: AppRoutes.propertyDetails,
      page: () => const PropertyDetailsView(),
      binding: PropertyDetailsBinding(),
    ),
    GetPage(
      name: AppRoutes.filter,
      page: () {
        final args = Get.arguments as Map<String, dynamic>?;
        final contextType = args?['contextType'] ?? 'sale';
        return FilterView(contextType: contextType);
      },
      binding: FilterBinding(),
    ),
  ];
}
