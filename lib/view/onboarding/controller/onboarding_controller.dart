import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:mm_properties/navigation/app_routes.dart';

class OnboardingController extends GetxController {
  final PageController pageController = PageController();
  var currentPageIndex = 0.obs;

  final List<Map<String, String>> onboardingPages = [
    {
      'image': 'assets/images/onboarding_1.jpg',
      'title': 'Find best place\nto stay in good price',
      'boldWord': 'good price',
      'description':
          'Browse thousands of verified listings for rent and sale. From cozy apartments to spacious villas - your dream space is just a few taps away.',
    },
    {
      'image': 'assets/images/onboarding_2.jpg',
      'title': 'Fast sell your property\nin just one click',
      'boldWord': 'one click',
      'description':
          'Narrow down results with custom filters - price, location, amenities, and more. Save time and find exactly what you need, instantly.',
    },
    {
      'image': 'assets/images/onboarding_3.png',
      'title': 'Find perfect choice for\nyour future house',
      'boldWord': 'perfect choice',
      'description':
          'Chat with owners, agents, or buyers directly in the app. Schedule visits, negotiate prices, and close deals all in one place.',
    },
  ];

  @override
  void onInit() {
    super.onInit();
    pageController.addListener(_updatePageIndex);
  }

  void _updatePageIndex() {
    if (pageController.page != null) {
      currentPageIndex.value = pageController.page!.round();
    }
  }

  void nextPage() {
    if (currentPageIndex.value < onboardingPages.length - 1) {
      pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    } else {
      Get.offAllNamed(AppRoutes.home);
    }
  }

  void skipOnboarding() {
    Get.offAllNamed(AppRoutes.home);
  }

  void previousPage() {
    if (currentPageIndex.value > 0) {
      pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    }
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }
}
