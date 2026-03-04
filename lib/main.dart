import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flybnb/constant/app_theme.dart';
import 'package:flybnb/constant/binding.dart';
import 'package:flybnb/constant/router.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Binding.init();
  runApp(const FlyBNB());
}

class FlyBNB extends StatelessWidget {
  const FlyBNB({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 780),
      builder: (context, child) {
        return MaterialApp.router(
          themeMode: ThemeMode.light,
          theme: AppTheme.lightTheme,
          routerConfig: Routers.router,
        );
      },
    );
  }
}
