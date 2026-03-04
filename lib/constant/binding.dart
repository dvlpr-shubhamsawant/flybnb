import 'package:flybnb/pages/auth/controller/auth_controller.dart';
import 'package:flybnb/pages/flight_listing/controller/flights_controller.dart';
import 'package:flybnb/pages/flight_search/controllers/flight_search_controller.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';

class Binding {
  static void init() {
    Get.lazyPut(() => AuthController());
    Get.lazyPut(() => FlightSearchController());
    Get.lazyPut(() => FlightsController());
  }
}
