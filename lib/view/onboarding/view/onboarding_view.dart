import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../utility/common/asset_paths.dart';
import '../../../utility/common/app_colors.dart';
import '../controller/onboarding_controller.dart';
import '../widgets/onboarding_page_content.dart';

class OnboardingView extends GetView<OnboardingController> {
  const OnboardingView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OnboardingController>(
      builder: (controller) {
        return SafeArea(
          top: false,
          bottom: true,
          child: Scaffold(
            backgroundColor: AppColors.white,
            body: Column(
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(10.0, 5.0, 20.0, 5.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Image.asset(
                        AssetPaths.logo,
                        width: 100,
                        height: 100,
                        color: AppColors.black,
                      ),
                      if (controller.currentPageIndex.value != 2)
                        GestureDetector(
                          onTap: controller.skipOnboarding,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 25.0,
                              vertical: 8.0,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.munsell.withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            child: Text(
                              'Skip',
                              style: GoogleFonts.montserrat(
                                color: AppColors.black,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),

                Expanded(
                  child: Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      PageView.builder(
                        controller: controller.pageController,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: controller.onboardingPages.length,
                        allowImplicitScrolling: false,
                        onPageChanged: (value) {
                          controller.currentPageIndex.value = value;
                          controller.update();
                        },
                        itemBuilder: (context, index) {
                          final pageData = controller.onboardingPages[index];
                          return OnboardingPageContent(
                            imagePath:
                                pageData['image'] ?? AssetPaths.onboarding1,
                            title: pageData['title'] ?? 'Default Title',
                            boldWord: pageData['boldWord'] ?? '',
                            description:
                                pageData['description'] ??
                                'No description available.',
                            isFirstPage: index == 0,
                            isLastPage:
                                index == controller.onboardingPages.length - 1,
                            onNext: controller.nextPage,
                            onSkip: controller.skipOnboarding,
                            onPrevious: controller.previousPage,
                            currentPageIndex: index,
                            totalPages: controller.onboardingPages.length,
                          );
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 25,
                          horizontal: 40,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            if (controller.currentPageIndex.value != 0)
                              Container(
                                width: 54,
                                height: 54,

                                decoration: BoxDecoration(
                                  color: AppColors.white,
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withValues(
                                        alpha: 0.8,
                                      ),
                                      blurRadius: 20.0,
                                    ),
                                  ],
                                  border: Border.all(
                                    color: AppColors.chineseWhite.withValues(
                                      alpha: 0.5,
                                    ),
                                  ),
                                ),
                                child: IconButton(
                                  icon: const Icon(
                                    Icons.arrow_back,
                                    color: AppColors.black,
                                    size: 25,
                                  ),
                                  onPressed: controller.previousPage,
                                ),
                              ),
                            Flexible(
                              flex: 1,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      left: 10.0,
                                      right: 10.0,
                                    ),
                                    child: ElevatedButton(
                                      onPressed: controller.nextPage,
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: AppColors.munsell,
                                        foregroundColor: AppColors.white,
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 15,
                                          horizontal: 50,
                                        ),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            10,
                                          ),
                                        ),
                                        elevation: 0,
                                      ),
                                      child: Text(
                                        controller.currentPageIndex.value != 3
                                            ? 'Next'
                                            : 'Get Started',
                                        style: GoogleFonts.lato(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            if (controller.currentPageIndex.value != 0)
                              SizedBox(width: 50, height: 50),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
