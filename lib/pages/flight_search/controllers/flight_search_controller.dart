import 'package:get/state_manager.dart';

class FlightSearchController extends GetxController {
  Rxn<String> fromCity = Rxn<String>();
  Rxn<String> toCity = Rxn<String>();

  Rxn<DateTime> selectedDate = Rxn<DateTime>();

  List<String> cities = [
    "Mumbai",
    "Delhi",
    "Pune",
    "Bangalore",
    "Hyderabad",
    "Chennai",
  ];

  void swapCities() {
    final temp = fromCity.value;
    fromCity.value = toCity.value;
    toCity.value = temp;
  }
}
