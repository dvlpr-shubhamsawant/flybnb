import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flybnb/constant/assets.dart';
import 'package:flybnb/constant/colors.dart';
import 'package:flybnb/constant/router_path.dart';
import 'package:flybnb/extensions/context_extensions.dart';
import 'package:flybnb/models/flight_model.dart';
import 'package:flybnb/pages/flight_listing/controller/flights_controller.dart';
import 'package:flybnb/pages/flight_search/controllers/flight_search_controller.dart';
import 'package:flybnb/widgets/custom_box.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/state_manager.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';

class FlightListingPage extends StatelessWidget {
  FlightListingPage({super.key});
  final FlightSearchController _flightSearchController =
      Get.find<FlightSearchController>();
  final FlightsController _flightsController = Get.find<FlightsController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        backgroundColor: context.colorScheme.primary,
        centerTitle: true,
        toolbarHeight: 80.h,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  _flightSearchController.fromCity.value ?? "",
                  style: context.textTheme.headlineMedium?.copyWith(
                    fontSize: 22.sp,
                    fontWeight: FontWeight.w600,
                    color: context.colorScheme.onSecondary,
                  ),
                ),

                CustomSizedbox.widthBox(10),

                const Icon(
                  Icons.arrow_forward_rounded,
                  size: 20,
                  color: Colors.white,
                ),

                CustomSizedbox.widthBox(10),

                Text(
                  _flightSearchController.toCity.value ?? "",
                  style: context.textTheme.headlineMedium?.copyWith(
                    fontSize: 22.sp,
                    fontWeight: FontWeight.w600,
                    color: context.colorScheme.onSecondary,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 4),

            Text(
              DateFormat(
                'dd MMM yyyy',
              ).format(_flightSearchController.selectedDate.value!),
              style: context.textTheme.bodyMedium?.copyWith(
                color: context.colorScheme.onSecondary.withValues(alpha: 0.9),
                fontSize: 13.sp,
              ),
            ),
          ],
        ),
      ),
      body: Obx(() {
        if (_flightsController.isLoader.value) {
          return Center(
            child: LottieBuilder.asset(
              Assets.lotFlightLoader,
              width: context.width * 0.8,
            ),
          );
        }
        return Column(
          children: [
            if (_flightsController.filteredFlights.isNotEmpty)
              Container(
                color: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 10,
                ),
                child: Row(
                  children: [
                    Row(
                      children: [
                        Text(
                          "Non-Stop",
                          style: context.textTheme.bodyLarge?.copyWith(
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w500,
                            color: context.colorScheme.onPrimary,
                          ),
                        ),
                        Switch(
                          value: _flightsController.nonStopOnly.value,
                          onChanged: (val) {
                            _flightsController.toggleNonStop(val);
                          },
                          inactiveTrackColor: AppColors.grey.withValues(
                            alpha: 0.4,
                          ),
                          thumbColor: WidgetStatePropertyAll(
                            context.colorScheme.onSecondary,
                          ),
                        ),
                      ],
                    ),

                    const Spacer(),

                    TextButton(
                      onPressed: () {
                        _flightsController.sortPrice("low");
                      },
                      child: const Text("Low  ↓"),
                    ),

                    TextButton(
                      onPressed: () {
                        _flightsController.sortPrice("high");
                      },
                      child: const Text("High ↑"),
                    ),
                  ],
                ),
              ),

            const SizedBox(height: 6),
            Expanded(
              child: _flightsController.filteredFlights.isEmpty
                  ? Center(
                      child: Text(
                        "No Flights Available",
                        style: context.textTheme.bodyLarge?.copyWith(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w500,
                          color: context.colorScheme.onPrimary,
                        ),
                      ),
                    )
                  : ListView.builder(
                      itemCount: _flightsController.filteredFlights.length,
                      itemBuilder: (context, index) {
                        final flight =
                            _flightsController.filteredFlights[index];

                        return FlightCard(
                          flight: flight,
                          onTap: () {
                            _flightsController.selectAirline(flight);
                            context.pushNamed(RouterPath.flightdetails.name);
                          },
                        );
                      },
                    ),
            ),
          ],
        );
      }),
    );
  }
}

class FlightCard extends StatelessWidget {
  final FlightModel flight;
  final VoidCallback onTap;

  const FlightCard({super.key, required this.flight, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: context.colorScheme.onSecondary,
          borderRadius: BorderRadius.circular(16.r),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(.15),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          children: [
            Row(
              children: [
                Image.asset(
                  flight.logo,
                  width: 35.w,
                  height: 35.h,
                  fit: BoxFit.scaleDown,
                ),

                CustomSizedbox.widthBox(10),

                Text(
                  flight.airline,
                  style: context.textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                    fontSize: 15.sp,
                  ),
                ),

                const Spacer(),

                Text(
                  "₹${flight.price}",
                  style: context.textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 18.sp,
                    color: context.colorScheme.primary,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 14),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      flight.departureTime,
                      style: context.textTheme.bodyLarge?.copyWith(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      flight.from,
                      style: context.textTheme.bodyMedium?.copyWith(
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),

                Column(
                  children: [
                    Text(
                      flight.duration,
                      style: context.textTheme.bodyMedium?.copyWith(
                        color: AppColors.grey,
                        fontSize: 12.sp,
                      ),
                    ),

                    CustomSizedbox.heightBox(4),

                    Container(
                      width: 80,
                      height: 1,
                      color: Colors.grey.shade300,
                    ),
                    CustomSizedbox.heightBox(4),

                    Text(
                      flight.stops.isEmpty
                          ? "Non-stop"
                          : "${flight.stops.length} Stop",
                      style: context.textTheme.bodyMedium?.copyWith(
                        fontSize: 12.sp,
                        color: AppColors.grey,
                      ),
                    ),
                  ],
                ),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      flight.arrivalTime,
                      style: context.textTheme.bodyLarge?.copyWith(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      flight.to,
                      style: context.textTheme.bodyMedium?.copyWith(
                        color: AppColors.grey,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
