import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../utility/common/asset_paths.dart';
import '../../../utility/common/app_colors.dart';
import '../controller/splash_controller.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.find<SplashController>();

    return Scaffold(
      backgroundColor: AppColors.munsell,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              AssetPaths.mmLogo,
              width: 320,
              height: 132,
              color: AppColors.white,
            ),
          ],
        ),
      ),
    );
  }
}
