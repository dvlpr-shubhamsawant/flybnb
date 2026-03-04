import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';

class AuthController extends GetxController {
  final phoneFocus = FocusNode();
  final TextEditingController phoneController = TextEditingController();

  RxBool isLoginLoader = false.obs;
  Future<void> loginWithMobile({required String phoneNo}) async {
    try {
      isLoginLoader.value = true;
      await Future.delayed(Duration(seconds: 3));
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    } finally {
      isLoginLoader.value = false;
    }
  }

  @override
  void onClose() {
    phoneFocus.dispose();
    phoneController.dispose();
    super.onClose();
  }
}
