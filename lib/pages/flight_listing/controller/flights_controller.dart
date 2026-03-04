import 'package:flybnb/constant/global.dart';
import 'package:flybnb/data/mock_flights.dart';
import 'package:flybnb/models/flight_model.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class FlightsController extends GetxController {
  List<FlightModel> allFlights = [];
  RxList<FlightModel> filteredFlights = <FlightModel>[].obs;

  Rxn<FlightModel> selectedFlight = Rxn<FlightModel>();

  RxBool nonStopOnly = false.obs;
  RxString sortType = "".obs;

  RxBool isLoader = false.obs;

  void searchFlights(String from, String to) async {
    try {
      isLoader.value = true;
      await Future.delayed(Duration(seconds: 5));
      final result = flights.where((flight) {
        return flight.from == from && flight.to == to;
      }).toList();
      allFlights = result;
      applyFilters();
    } catch (e) {
      logger.e(e);
    } finally {
      isLoader.value = false;
    }
  }

  void applyFilters() {
    try {
      isLoader.value = true;
      List<FlightModel> result = [...allFlights];

      if (nonStopOnly.value) {
        result = result.where((f) => f.stops.isEmpty).toList();
      }

      if (sortType.value == "low") {
        result.sort((a, b) => a.price.compareTo(b.price));
      }

      if (sortType.value == "high") {
        result.sort((a, b) => b.price.compareTo(a.price));
      }

      filteredFlights.value = result;
    } catch (e) {
      logger.e(e);
    } finally {
      isLoader.value = false;
    }
  }

  void toggleNonStop(bool value) {
    nonStopOnly.value = value;
    applyFilters();
  }

  void sortPrice(String type) {
    sortType.value = type;
    applyFilters();
  }

  void selectAirline(FlightModel flight) {
    selectedFlight.value = flight;
  }

  int calculateGST(int price) {
    return (price * 18 / 100).round();
  }

  int calculateTotalWithGST(int price) {
    return price + calculateGST(price);
  }
}
