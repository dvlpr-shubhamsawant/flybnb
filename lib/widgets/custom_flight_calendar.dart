import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flybnb/constant/colors.dart';
import 'package:flybnb/extensions/context_extensions.dart';
import 'package:flybnb/widgets/custom_box.dart';
import 'package:intl/intl.dart';

class CustomFlightCalendar extends StatelessWidget {
  final DateTime? selectedDate;
  final Function(DateTime) onDateSelected;

  const CustomFlightCalendar({
    super.key,
    required this.selectedDate,
    required this.onDateSelected,
  });

  void openCalendar(BuildContext context) {
    DateTime currentMonth = DateTime.now();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) {
        return StatefulBuilder(
          builder: (context, setState) {
            DateTime firstDay = DateTime(
              currentMonth.year,
              currentMonth.month,
              1,
            );

            int startWeekday = firstDay.weekday % 7;

            int daysInMonth = DateTime(
              currentMonth.year,
              currentMonth.month + 1,
              0,
            ).day;

            int totalCells = startWeekday + daysInMonth;
            return Container(
              height: context.height * 0.56,
              decoration: BoxDecoration(
                color: context.colorScheme.onSecondary,
                borderRadius: BorderRadius.vertical(top: Radius.circular(25.r)),
              ),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 14,
                    ),
                    decoration: BoxDecoration(
                      color: context.colorScheme.primary,
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(25.r),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          onPressed: () {
                            setState(() {
                              currentMonth = DateTime(
                                currentMonth.year,
                                currentMonth.month - 1,
                              );
                            });
                          },
                          icon: Icon(
                            Icons.chevron_left,
                            color: context.colorScheme.onSecondary,
                          ),
                        ),

                        Text(
                          "${_monthName(currentMonth.month)} ${currentMonth.year}",
                          style: context.textTheme.bodyLarge?.copyWith(
                            color: context.colorScheme.onSecondary,
                            fontSize: 18.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        IconButton(
                          onPressed: () {
                            setState(() {
                              currentMonth = DateTime(
                                currentMonth.year,
                                currentMonth.month + 1,
                              );
                            });
                          },
                          icon: Icon(
                            Icons.chevron_right,
                            color: context.colorScheme.onSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 12),

                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          "S",
                          style: context.textTheme.bodyMedium?.copyWith(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            color: context.colorScheme.onPrimary,
                          ),
                        ),
                        Text(
                          "M",
                          style: context.textTheme.bodyMedium?.copyWith(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            color: context.colorScheme.onPrimary,
                          ),
                        ),
                        Text(
                          "T",
                          style: context.textTheme.bodyMedium?.copyWith(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            color: context.colorScheme.onPrimary,
                          ),
                        ),
                        Text(
                          "W",
                          style: context.textTheme.bodyMedium?.copyWith(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            color: context.colorScheme.onPrimary,
                          ),
                        ),
                        Text(
                          "T",
                          style: context.textTheme.bodyMedium?.copyWith(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            color: context.colorScheme.onPrimary,
                          ),
                        ),
                        Text(
                          "F",
                          style: context.textTheme.bodyMedium?.copyWith(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            color: context.colorScheme.onPrimary,
                          ),
                        ),
                        Text(
                          "S",
                          style: context.textTheme.bodyMedium?.copyWith(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            color: context.colorScheme.onPrimary,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 12),

                  Expanded(
                    child: GridView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: totalCells,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 7,
                            mainAxisSpacing: 8,
                            crossAxisSpacing: 8,
                            childAspectRatio: 1,
                          ),
                      itemBuilder: (_, index) {
                        if (index < startWeekday) {
                          return Container();
                        }

                        int day = index - startWeekday + 1;

                        DateTime date = DateTime(
                          currentMonth.year,
                          currentMonth.month,
                          day,
                        );

                        bool isSelected =
                            selectedDate != null &&
                            selectedDate!.day == date.day &&
                            selectedDate!.month == date.month &&
                            selectedDate!.year == date.year;

                        bool isToday =
                            date.day == DateTime.now().day &&
                            date.month == DateTime.now().month &&
                            date.year == DateTime.now().year;

                        final today = DateTime.now();
                        bool isPast = date.isBefore(
                          DateTime(today.year, today.month, today.day),
                        );

                        return GestureDetector(
                          onTap: isPast
                              ? null
                              : () {
                                  onDateSelected(date);
                                  Navigator.pop(context);
                                },
                          child: Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? context.colorScheme.primary
                                  : Colors.grey.shade200,
                              borderRadius: BorderRadius.circular(10),
                              border: isToday
                                  ? Border.all(
                                      color: context.colorScheme.primary,
                                      width: 1.5,
                                    )
                                  : null,
                            ),
                            child: Text(
                              day.toString(),
                              style: context.textTheme.bodyMedium?.copyWith(
                                fontWeight: isSelected
                                    ? FontWeight.w600
                                    : FontWeight.w500,
                                fontSize: 13,
                                color: isPast
                                    ? AppColors.grey
                                    : isSelected
                                    ? AppColors.white
                                    : AppColors.black,
                              ),
                              // style: context.textTheme.bodyMedium?.copyWith(
                              //   fontSize: 13,
                              //   fontWeight: FontWeight.bold,
                              //   color: context.colorScheme.onPrimary,
                              // ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  static String _monthName(int month) {
    const months = [
      "",
      "January",
      "February",
      "March",
      "April",
      "May",
      "June",
      "July",
      "August",
      "September",
      "October",
      "November",
      "December",
    ];
    return months[month];
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Select Date",
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        CustomSizedbox.heightBox(8),
        GestureDetector(
          onTap: () => openCalendar(context),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            decoration: BoxDecoration(
              color: context.colorScheme.onSecondary,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: Colors.grey.shade400),
            ),
            child: Row(
              children: [
                Icon(Icons.calendar_month, color: context.colorScheme.primary),
                CustomSizedbox.widthBox(15),
                Expanded(
                  child: Text(
                    selectedDate == null
                        ? "Select Date"
                        : DateFormat('dd-MM-yyyy').format(selectedDate!),
                    style: context.textTheme.titleLarge?.copyWith(
                      fontSize: 16,
                      color: selectedDate == null ? Colors.grey : Colors.black,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                const Icon(Icons.keyboard_arrow_down),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
