import 'package:flutter/cupertino.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';

class LocationSearchController extends GetxController{
  final searchController = TextEditingController();
  var googleMapAPI = dotenv.env['GOOGLE_MAP_API'];
}