import 'package:dokan/config/routes/app_pages.dart';
import 'package:dokan/feature/location_search/screens/location_search.dart';

import 'package:get/get_navigation/src/routes/get_route.dart';

abstract class AppPages {
  static final pages = [

    GetPage(name: Routes.LOCATIONSEARCH, page: () => const LocationSearch()),

  ];

}
