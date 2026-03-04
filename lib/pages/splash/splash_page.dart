import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flybnb/constant/assets.dart';
import 'package:flybnb/constant/router_path.dart';
import 'package:flybnb/extensions/context_extensions.dart';
import 'package:flybnb/widgets/custom_box.dart';
import 'package:go_router/go_router.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  Future<void> animate() async {
    await Future.delayed(const Duration(seconds: 3));
    if (!mounted) return;
    context.goNamed(RouterPath.login.name);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    animate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colorScheme.primary,
      body: SizedBox(
        width: context.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(Assets.icPlane, fit: BoxFit.scaleDown),
            CustomSizedbox.heightBox(20),
            Text(
              "Flight BNB",
              style: context.textTheme.headlineLarge?.copyWith(
                fontWeight: FontWeight.w800,
                color: context.colorScheme.onSecondary,
                fontSize: 34.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
