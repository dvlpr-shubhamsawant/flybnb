import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flybnb/constant/colors.dart';

SpinKitFadingCircle customLoader() {
  return SpinKitFadingCircle(color: AppColors.primary, size: 40, itemCount: 8);
}
