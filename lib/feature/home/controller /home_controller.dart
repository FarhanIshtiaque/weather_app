import 'package:dio/dio.dart';
import 'package:dokan/core/constants/app_assets.dart';
import 'package:dokan/core/helper/logger.dart';
import 'package:dokan/feature/home/data/weather.dart';
import 'package:get/get.dart' hide Response, FormData, MultipartFile;
import '../../../config/network_service/network_service.dart';


class HomeController extends GetxController{
  var location = ''.obs;
   HttpService httpService = HttpService();
  var latitude= ''.obs;
  var longitude = ''.obs;
  var isLoading = false.obs;
  late Weather weather ;
   @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    httpService.init();
  }
/// Get weather data from API
  Future<void> getWeatherData() async {
    try {
      isLoading(true);
      final result = await httpService.request(
          url:'/data/2.5/weather?lat=$latitude&lon=$longitude&appid=666055a3faf049182c2ff7377ff29abe', method: Method.GET, params: {},);

      if (result != null) {
        if (result is Response) {
          var data = result.data;
          weather = Weather.fromJson(data);

          isLoading(false);
        } else {
          isLoading(false);
        }
      }
    } finally {
      isLoading(false);
    }
  }

// weather animations
  String getWeatherAnimation(String? mainCondition) {
    if (mainCondition == null) return AppAssets.sunny;

    switch (mainCondition.toLowerCase()) {
      case 'clouds':
      case 'mist':
      case 'smoke':
      case 'haze':
      case 'dust':
      case 'fog':
        return AppAssets.cloudy;
      case 'rain':
      case 'drizzle':
      case 'shower rain':
        return AppAssets.rain;
      case 'thunderstorm':
        return AppAssets.thunder;
      case 'clear':
        return AppAssets.sunny;
      default:
        return AppAssets.sunny;
    }
  }

}