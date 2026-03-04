import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flybnb/constant/assets.dart';
import 'package:flybnb/constant/colors.dart';
import 'package:flybnb/constant/router_path.dart';
import 'package:flybnb/extensions/context_extensions.dart';
import 'package:flybnb/models/flight_model.dart';
import 'package:flybnb/pages/flight_listing/controller/flights_controller.dart';
import 'package:flybnb/pages/flight_search/controllers/flight_search_controller.dart';
import 'package:flybnb/widgets/custom_box.dart';
import 'package:flybnb/widgets/custom_button.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/state_manager.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';

class FlightDetailPage extends StatelessWidget {
  FlightDetailPage({super.key});

  final FlightsController _flightsController = Get.find<FlightsController>();
  final FlightSearchController _flightSearchController =
      Get.find<FlightSearchController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        backgroundColor: context.colorScheme.primary,
        centerTitle: true,
        toolbarHeight: 80.h,
        title: Text(
          "Flight Details",
          style: context.textTheme.bodyMedium?.copyWith(
            fontSize: 22.sp,
            fontWeight: FontWeight.w600,
            color: context.colorScheme.onSecondary,
          ),
        ),
      ),
      body: Obx(() {
        if (_flightsController.isLoader.value) {
          return SizedBox();
        }
        FlightModel? flight = _flightsController.selectedFlight.value;
        if (flight == null) {
          return Center(
            child: Text(
              "No Flight Available",
              style: context.textTheme.bodyLarge?.copyWith(
                fontSize: 15.sp,
                fontWeight: FontWeight.w500,
                color: context.colorScheme.onPrimary,
              ),
            ),
          );
        }
        return SizedBox(
          width: context.width,
          child: SingleChildScrollView(
            child: Column(
              children: [
                CustomSizedbox.heightBox(30),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 22.w),
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 18),
                  decoration: BoxDecoration(
                    color: context.colorScheme.onSecondary,
                    borderRadius: BorderRadius.circular(16.r),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.black.withValues(alpha: 0.2),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Image.asset(
                        flight.logo,
                        width: 80.w,
                        fit: BoxFit.scaleDown,
                      ),
                      CustomSizedbox.heightBox(15),
                      Divider(
                        color: context.colorScheme.onPrimary.withValues(
                          alpha: 0.3,
                        ),
                      ),
                      CustomSizedbox.heightBox(15),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 14.0),
                        child: Column(
                          children: [
                            Text(
                              flight.duration,
                              style: context.textTheme.bodyLarge?.copyWith(
                                fontSize: 13.sp,
                                fontWeight: FontWeight.w500,
                                color: context.colorScheme.onPrimary,
                              ),
                            ),
                            Row(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      flight.departureTime,
                                      style: context.textTheme.headlineMedium
                                          ?.copyWith(
                                            fontSize: 22.sp,
                                            fontWeight: FontWeight.bold,
                                            color:
                                                context.colorScheme.onPrimary,
                                          ),
                                    ),
                                    Text(
                                      flight.from,
                                      style: context.textTheme.bodyLarge
                                          ?.copyWith(
                                            fontSize: 13.sp,
                                            fontWeight: FontWeight.w500,
                                            color:
                                                context.colorScheme.onPrimary,
                                          ),
                                    ),
                                  ],
                                ),
                                CustomSizedbox.widthBox(8),
                                Expanded(
                                  child: Divider(color: Colors.grey.shade400),
                                ),
                                Container(
                                  padding: const EdgeInsets.all(8),
                                  height: context.height * 0.06,
                                  width: context.width * 0.12,
                                  decoration: BoxDecoration(
                                    color: context.colorScheme.primary,
                                    shape: BoxShape.circle,
                                  ),
                                  child: SvgPicture.asset(
                                    Assets.icPlane,
                                    fit: BoxFit.scaleDown,
                                  ),
                                ),
                                Expanded(
                                  child: Divider(color: Colors.grey.shade400),
                                ),
                                CustomSizedbox.widthBox(8),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      flight.arrivalTime,
                                      style: context.textTheme.headlineMedium
                                          ?.copyWith(
                                            fontSize: 22.sp,
                                            fontWeight: FontWeight.bold,
                                            color:
                                                context.colorScheme.onPrimary,
                                          ),
                                    ),
                                    Text(
                                      flight.to,
                                      style: context.textTheme.bodyLarge
                                          ?.copyWith(
                                            fontSize: 13.sp,
                                            fontWeight: FontWeight.w500,
                                            color:
                                                context.colorScheme.onPrimary,
                                          ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            CustomSizedbox.heightBox(16),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width: context.width * 0.25,
                                  child: Text(
                                    "Shivaji Maharaj International Airport",
                                    textAlign: TextAlign.left,
                                    maxLines: 3,
                                    overflow: TextOverflow.ellipsis,
                                    style: context.textTheme.bodyMedium
                                        ?.copyWith(
                                          fontSize: 11.sp,
                                          fontWeight: FontWeight.w500,
                                          color: AppColors.grey,
                                        ),
                                  ),
                                ),
                                SizedBox(
                                  width: context.width * 0.25,
                                  child: Text(
                                    "Subhash Chandra Bose International Airport",
                                    textAlign: TextAlign.right,
                                    maxLines: 3,
                                    overflow: TextOverflow.ellipsis,
                                    style: context.textTheme.bodyMedium
                                        ?.copyWith(
                                          fontSize: 11.sp,
                                          fontWeight: FontWeight.w500,
                                          color: AppColors.grey,
                                        ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      CustomSizedbox.heightBox(15),
                      Divider(
                        color: context.colorScheme.onPrimary.withValues(
                          alpha: 0.3,
                        ),
                      ),
                      CustomSizedbox.heightBox(15),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 14.0),
                        child: Column(
                          children: [
                            Text(
                              "Date",
                              style: context.textTheme.bodyMedium?.copyWith(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w500,
                                color: AppColors.black,
                              ),
                            ),
                            Text(
                              DateFormat('dd MMM yyyy').format(
                                _flightSearchController.selectedDate.value!,
                              ),
                              style: context.textTheme.bodyMedium?.copyWith(
                                color: context.colorScheme.onPrimary,
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                      if (flight.stops.isNotEmpty)
                        Column(
                          children: [
                            CustomSizedbox.heightBox(15),
                            Divider(
                              color: context.colorScheme.onPrimary.withValues(
                                alpha: 0.3,
                              ),
                            ),
                            CustomSizedbox.heightBox(15),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 14.0,
                              ),
                              child: Column(
                                children: [
                                  Text(
                                    "Stops",
                                    style: context.textTheme.bodyMedium
                                        ?.copyWith(
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w500,
                                          color: AppColors.black,
                                        ),
                                  ),
                                  Text(
                                    flight.stops.join("\n"),
                                    textAlign: TextAlign.center,
                                    style: context.textTheme.bodyMedium
                                        ?.copyWith(
                                          color: context.colorScheme.onPrimary,
                                          fontSize: 18.sp,
                                          fontWeight: FontWeight.w600,
                                        ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      CustomSizedbox.heightBox(15),
                      Divider(
                        color: context.colorScheme.onPrimary.withValues(
                          alpha: 0.3,
                        ),
                      ),
                      CustomSizedbox.heightBox(15),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 14.0),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Ticket Price",
                                  style: context.textTheme.titleMedium
                                      ?.copyWith(
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w500,
                                        color: AppColors.black,
                                      ),
                                ),
                                Text(
                                  "₹${flight.price}/-",
                                  textAlign: TextAlign.center,
                                  style: context.textTheme.bodyMedium?.copyWith(
                                    color: context.colorScheme.onPrimary,
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                            CustomSizedbox.heightBox(8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "GST (18%)",
                                  style: context.textTheme.titleMedium
                                      ?.copyWith(
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w500,
                                        color: AppColors.black,
                                      ),
                                ),
                                Text(
                                  "₹${_flightsController.calculateGST(flight.price)}/-",
                                  textAlign: TextAlign.center,
                                  style: context.textTheme.bodyMedium?.copyWith(
                                    color: context.colorScheme.onPrimary,
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                            CustomSizedbox.heightBox(8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Promotion",
                                  style: context.textTheme.titleMedium
                                      ?.copyWith(
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w500,
                                        color: AppColors.black,
                                      ),
                                ),
                                Text(
                                  "₹0/-",
                                  textAlign: TextAlign.center,
                                  style: context.textTheme.bodyMedium?.copyWith(
                                    color: context.colorScheme.onPrimary,
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      CustomSizedbox.heightBox(15),
                      Divider(
                        color: context.colorScheme.onPrimary.withValues(
                          alpha: 0.3,
                        ),
                      ),
                      CustomSizedbox.heightBox(15),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 14),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Total Price",
                              style: context.textTheme.titleMedium?.copyWith(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w500,
                                color: AppColors.black,
                              ),
                            ),
                            Text(
                              "₹${_flightsController.calculateTotalWithGST(flight.price)}/-",
                              textAlign: TextAlign.center,
                              style: context.textTheme.bodyMedium?.copyWith(
                                color: context.colorScheme.onPrimary,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                CustomSizedbox.heightBox(25),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: CustomButton(
                    title: "Book",
                    titleColor: context.colorScheme.onSecondary,
                    titleSize: 18,
                    onPressed: () {
                      context.goNamed(RouterPath.bookingsuccess.name);
                    },
                  ),
                ),
                CustomSizedbox.heightBox(40),
              ],
            ),
          ),
        );
      }),
    );
  }
}
