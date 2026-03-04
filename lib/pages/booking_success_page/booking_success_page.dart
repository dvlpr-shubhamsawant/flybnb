import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flybnb/constant/assets.dart';
import 'package:flybnb/constant/router_path.dart';
import 'package:flybnb/extensions/context_extensions.dart';
import 'package:flybnb/widgets/custom_box.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';

class BookingSuccessPage extends StatefulWidget {
  const BookingSuccessPage({super.key});

  @override
  State<BookingSuccessPage> createState() => _BookingSuccessPageState();
}

class _BookingSuccessPageState extends State<BookingSuccessPage> {
  Future<void> switchPage() async {
    await Future.delayed(const Duration(seconds: 3));
    if (!mounted) return;
    context.goNamed(RouterPath.flightsearch.name);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    switchPage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colorScheme.primary,
      body: SizedBox(
        width: context.width,
        child: Column(
          children: [
            CustomSizedbox.heightBox(context.height * 0.12),
            SvgPicture.asset(
              Assets.icPlane,
              fit: BoxFit.scaleDown,
              width: 50.w,
            ),
            CustomSizedbox.heightBox(10),
            Text(
              "Flight BNB",
              style: context.textTheme.headlineLarge?.copyWith(
                fontWeight: FontWeight.w800,
                color: context.colorScheme.onSecondary,
                fontSize: 16.sp,
              ),
            ),
            CustomSizedbox.heightBox(context.height * 0.1),
            LottieBuilder.asset(Assets.lotSuccess, width: context.width * 0.8),
            CustomSizedbox.heightBox(10),
            Text(
              "Thank You! for choosing Fly BNB!",
              style: context.textTheme.headlineLarge?.copyWith(
                fontWeight: FontWeight.w600,
                color: context.colorScheme.onSecondary,
                fontSize: 12.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
