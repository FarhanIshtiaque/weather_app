import 'package:dokan/core/constants/app_assets.dart';
import 'package:dokan/core/constants/app_colors.dart';
import 'package:dokan/core/constants/text_styles.dart';
import 'package:dokan/feature/home/controller%20/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:heroicons/heroicons.dart';
import 'package:lottie/lottie.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    HomeController homeController = Get.find();
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Obx(
          () => homeController.isLoading.value
              ? Center(
                  child: Lottie.asset(AppAssets.loaderPurple, width: 35),
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 24,
                    ),
                    const HeroIcon(
                      HeroIcons.mapPin,
                      style: HeroIconStyle.solid,
                      color: AppColors.red400,
                      size: 55,
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      homeController.location.value,
                      style: AppTextStyle.headingXSmall,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    Lottie.asset(homeController
                        .getWeatherAnimation(homeController.weather.main)),
                    const SizedBox(
                      height: 24,
                      width: double.maxFinite,
                    ),
                    Text(
                      "${homeController.weather.temp.round()} C",
                      style: AppTextStyle.headingMedium,
                    )
                  ],
                ),
        ),
      ),
    );
  }
}
