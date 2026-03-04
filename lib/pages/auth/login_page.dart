import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flybnb/constant/assets.dart';
import 'package:flybnb/constant/colors.dart';
import 'package:flybnb/constant/router_path.dart';
import 'package:flybnb/extensions/context_extensions.dart';
import 'package:flybnb/pages/auth/controller/auth_controller.dart';
import 'package:flybnb/widgets/custom_box.dart';
import 'package:flybnb/widgets/custom_button.dart';
import 'package:flybnb/widgets/custom_loader.dart';
import 'package:flybnb/widgets/custom_textfield.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:go_router/go_router.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});
  final _formKey = GlobalKey<FormState>();
  final AuthController _authController = Get.find<AuthController>();
  AutovalidateMode _autoValidate = AutovalidateMode.disabled;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: MediaQuery.of(context).size.height,
          ),
          child: IntrinsicHeight(
            child: Padding(
              padding: EdgeInsets.only(
                right: 16.w,
                left: 16.w,
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              child: SizedBox(
                width: context.width,
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      CustomSizedbox.heightBox(context.height * 0.15),
                      Container(
                        padding: EdgeInsets.all(16.w),
                        decoration: BoxDecoration(
                          color: context.colorScheme.primary,
                          borderRadius: BorderRadius.circular(14.r),
                        ),
                        child: Column(
                          children: [
                            SvgPicture.asset(
                              Assets.icPlane,
                              fit: BoxFit.scaleDown,
                            ),
                            SizedBox(height: 10),
                            Text(
                              "Fly Bnb",
                              style: context.textTheme.displayMedium?.copyWith(
                                fontSize: 28.sp,
                                fontWeight: FontWeight.bold,
                                color: context.colorScheme.onSecondary,
                              ),
                            ),
                          ],
                        ),
                      ),

                      CustomSizedbox.heightBox(30),
                      Text(
                        "Login",
                        style: context.textTheme.bodyMedium?.copyWith(
                          fontSize: 25.sp,
                          fontWeight: FontWeight.w600,
                          color: context.colorScheme.onPrimary,
                        ),
                      ),

                      CustomSizedbox.heightBox(20),
                      CustomTextfield(
                        title: "Phone No.",
                        hintText: "9890877456",
                        isRequired: true,
                        controller: _authController.phoneController,
                        validateMode: _autoValidate,
                        prefixIcon: Icon(
                          Icons.phone,
                          color: AppColors.black.withValues(alpha: 0.6),
                        ),
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          LengthLimitingTextInputFormatter(10),
                        ],
                        keyboardType: TextInputType.phone,
                        // focusNode: _formController.phoneFocus,
                        textInputAction: TextInputAction.done,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Phone number is required";
                          }
                          if (value.length != 10) {
                            return "Enter valid 10 digit phone number";
                          }
                          if (!RegExp(r'^[6-9]\d{9}$').hasMatch(value)) {
                            return "Enter valid mobile number";
                          }
                          return null;
                        },
                      ),

                      Spacer(),
                      Obx(() {
                        if (_authController.isLoginLoader.value) {
                          return customLoader();
                        }
                        return CustomButton(
                          title: "Login",
                          titleColor: AppColors.white,
                          titleSize: 18.sp,
                          onPressed: () async {
                            FocusScope.of(context).unfocus();
                            _autoValidate = AutovalidateMode.onUserInteraction;
                            if (!_formKey.currentState!.validate()) return;
                            final router = GoRouter.of(context);

                            await _authController.loginWithMobile(
                              phoneNo: _authController.phoneController.text,
                            );
                            router.goNamed(RouterPath.flightsearch.name);
                          },
                        );
                      }),
                      SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
