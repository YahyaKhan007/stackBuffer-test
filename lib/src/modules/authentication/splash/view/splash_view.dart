import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:stackbuffer_test/src/core/custom_elements/base_scaffold.dart';
import 'package:stackbuffer_test/src/modules/authentication/splash/controller/splash_controller.dart';

import '../../../../core/custom_elements/app_strings.dart';
import '../../../../core/custom_elements/custom_text.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  final SplashController splashController = Get.put(SplashController());

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await splashController
          .checkingAuthUser(); // Call your async function here
    });
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      body: Center(
        child: CustomText(
          text: AppStrings.splashScreen,
          textStyle: TextStyle(
            fontSize: 12.sp,
            fontWeight: FontWeight.normal,
            fontStyle: FontStyle.italic,
          ),
        ),
      ),
    );
  }
}
