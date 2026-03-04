import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flybnb/extensions/context_extensions.dart';
import 'package:flybnb/widgets/custom_box.dart';

class FlightCityDropdown extends StatelessWidget {
  final String title;
  final String hint;
  final IconData icon;
  final String? selectedValue;
  final List<String> items;
  final Function(String) onSelected;

  const FlightCityDropdown({
    super.key,
    required this.title,
    required this.hint,
    required this.icon,
    required this.items,
    required this.onSelected,
    this.selectedValue,
  });

  void openSelection(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
      ),
      builder: (context) {
        return Container(
          height: 400,
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Column(
            children: [
              Container(
                width: 40,
                height: 5,
                margin: const EdgeInsets.only(top: 10, bottom: 20),
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 15),
              Expanded(
                child: ListView.builder(
                  itemCount: items.length,
                  itemBuilder: (_, index) {
                    return ListTile(
                      leading: Icon(icon, color: context.colorScheme.primary),
                      title: Text(
                        items[index],
                        style: context.textTheme.bodyLarge?.copyWith(
                          color: context.colorScheme.onPrimary,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      onTap: () {
                        onSelected(items[index]);
                        Navigator.pop(context);
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        CustomSizedbox.heightBox(8),
        GestureDetector(
          onTap: () => openSelection(context),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            decoration: BoxDecoration(
              color: context.colorScheme.onSecondary,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: Colors.grey.shade400),
            ),
            child: Row(
              children: [
                Icon(icon, color: context.colorScheme.primary),
                CustomSizedbox.widthBox(15),
                Expanded(
                  child: Text(
                    selectedValue ?? hint,
                    style: context.textTheme.titleLarge?.copyWith(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                      color: selectedValue == null ? Colors.grey : Colors.black,
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
