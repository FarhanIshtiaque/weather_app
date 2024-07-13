import 'package:dokan/config/routes/app_pages.dart';
import 'package:dokan/core/constants/app_values.dart';
import 'package:dokan/core/constants/text_styles.dart';
import 'package:dokan/core/helper/logger.dart';
import 'package:dokan/feature/home/controller%20/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_places_flutter/google_places_flutter.dart';
import 'package:google_places_flutter/model/prediction.dart';
import '../controller/location_search_controller.dart';

class LocationSearch extends StatelessWidget {
  const LocationSearch({super.key});

  @override
  Widget build(BuildContext context) {
    final locationSearchController = Get.put(LocationSearchController());
    final homeController = Get.put(HomeController());
    return Scaffold(
      appBar: AppBar(
        title: const Text("Search Location"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppValues.horizontalPadding),
        child: Column(

          children: [
            const SizedBox(height: 24,),
            GooglePlaceAutoCompleteTextField(
              textEditingController: locationSearchController.searchController,
              googleAPIKey: "",
              inputDecoration: const InputDecoration(
                hintText: 'Search location..',
                helperStyle: AppTextStyle.bodyMedium
              ),
              debounceTime: 400,
              isLatLngRequired: true,
              getPlaceDetailWithLatLng: (Prediction prediction) {
               homeController.longitude(prediction.lng);
               homeController.latitude(prediction.lat);
               homeController.location(prediction.description);
               homeController.getWeatherData();
               Get.toNamed(Routes.HOME);
              },
              itemClick: (Prediction prediction) {


             // Get.toNamed(Routes.HOME);

              },
              itemBuilder: (context, index, Prediction prediction) {
                return Container(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    children: [
                      const Icon(Icons.location_on),
                      const SizedBox(
                        width: 7,
                      ),
                      Expanded(child: Text(prediction.description ?? "",

                      style: AppTextStyle.labelMedium,
                      ))
                    ],
                  ),
                );
              },
              seperatedBuilder: Divider(),
              isCrossBtnShown: true,
              containerHorizontalPadding: 10,
            )
          ],
        ),
      ),
    );
  }
}
