import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flybnb/constant/colors.dart';
import 'package:flybnb/constant/router_path.dart';
import 'package:flybnb/extensions/context_extensions.dart';
import 'package:flybnb/pages/flight_listing/controller/flights_controller.dart';
import 'package:flybnb/pages/flight_search/controllers/flight_search_controller.dart';
import 'package:flybnb/widgets/custom_box.dart';
import 'package:flybnb/widgets/custom_button.dart';
import 'package:flybnb/widgets/custom_flight_calendar.dart';
import 'package:flybnb/widgets/flight_city_dropdown.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';
import 'package:go_router/go_router.dart';

class FlightSearchPage extends StatelessWidget {
  FlightSearchPage({super.key});
  final FlightSearchController _flightSearchController =
      Get.find<FlightSearchController>();
  final FlightsController _flightsController = Get.find<FlightsController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: context.colorScheme.primary,
        centerTitle: true,
        title: Text(
          "Book Flights",
          style: context.textTheme.headlineMedium?.copyWith(
            fontSize: 22.sp,
            fontWeight: FontWeight.w600,
            color: context.colorScheme.onSecondary,
          ),
        ),
      ),
      body: SizedBox(
        width: context.width,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          child: Obx(
            () => Column(
              children: [
                FlightCityDropdown(
                  title: "Select Departure City",
                  hint: "From",
                  icon: Icons.flight_takeoff_rounded,
                  selectedValue: _flightSearchController.fromCity.value,
                  items: _flightSearchController.cities,
                  onSelected: (value) {
                    if (kDebugMode) {
                      print(value);
                    }
                    _flightSearchController.fromCity.value = value;
                  },
                ),
                CustomSizedbox.heightBox(15),

                GestureDetector(
                  onTap: () {
                    _flightSearchController.swapCities();
                  },
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: context.colorScheme.primary.withValues(alpha: 0.1),
                    ),
                    child: Icon(
                      Icons.swap_vert,
                      color: context.colorScheme.primary,
                      size: 26,
                    ),
                  ),
                ),
                CustomSizedbox.heightBox(15),
                FlightCityDropdown(
                  title: "Select Destination City",
                  hint: "To",
                  icon: Icons.flight_land_rounded,
                  selectedValue: _flightSearchController.toCity.value,
                  items: _flightSearchController.cities,
                  onSelected: (value) {
                    if (kDebugMode) {
                      print(value);
                    }
                    _flightSearchController.toCity.value = value;
                  },
                ),
                CustomSizedbox.heightBox(15),
                CustomFlightCalendar(
                  selectedDate: _flightSearchController.selectedDate.value,
                  onDateSelected: (date) {
                    _flightSearchController.selectedDate.value = date;
                  },
                ),
                CustomSizedbox.heightBox(context.height * 0.2),
                CustomButton(
                  title: "Search",
                  titleColor: AppColors.white,
                  titleSize: 18.sp,
                  onPressed: () async {
                    final from = _flightSearchController.fromCity.value;
                    final to = _flightSearchController.toCity.value;
                    if (from == null || to == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor: context.colorScheme.error,
                          content: Text(
                            "Please select both cities",
                            style: TextStyle(color: Colors.white, fontSize: 12),
                          ),
                        ),
                      );
                      return;
                    }
                    _flightsController.searchFlights(from, to);
                    context.goNamed(RouterPath.flightlisting.name);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
