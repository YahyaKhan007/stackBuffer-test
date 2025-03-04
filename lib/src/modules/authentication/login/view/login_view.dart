import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stackbuffer_test/src/core/custom_elements/app_assets.dart';
import 'package:stackbuffer_test/src/core/custom_elements/app_colors.dart';
import 'package:stackbuffer_test/src/core/custom_elements/app_strings.dart';
import 'package:stackbuffer_test/src/core/custom_elements/base_scaffold.dart';
import 'package:stackbuffer_test/src/core/custom_elements/custom_image.dart';
import 'package:stackbuffer_test/src/core/custom_elements/custom_text.dart';
import 'package:stackbuffer_test/src/core/utils.dart';
import 'package:stackbuffer_test/src/modules/authentication/login/controller/auth_controller.dart';

class LoginView extends StatelessWidget {
  LoginView({super.key});

  final AuthController authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      body: SingleChildScrollView(
        child: Column(
          spacing: 16.h,
          children: [
            SizedBox(height: Get.height * 0.15),
            CustomText(
              text: AppStrings.welcomeBack,
              textStyle: GoogleFonts.plusJakartaSans(
                color: AppColors.onPrimary,
                fontSize: 32.sp,
                fontWeight: FontWeight.w700,
              ),
            ),

            16.verticalSpace,
            customTextField(
              label: AppStrings.email,
              isPassword: true,
              controller: authController.emailController,
            ),
            customTextField(
              label: AppStrings.password,
              controller: authController.passwordController,
              bgColor: Color(0xffF2F4F7),
            ),

            //    Sign in Button
            signInButton(),
            forgotPasswordField(),

            Image.asset(AppAssets.cartoon1),
          ],
        ).paddingSymmetric(horizontal: 16.w),
      ),
    );
  }

  forgotPasswordField() {
    RxBool isChecked = false.obs;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Obx(
              () => GestureDetector(
                onTap: () {
                  isChecked.value = !isChecked.value;

                  if (isChecked.value) {
                    Utils.showToastBottom(
                      message: AppStrings.notYetImplemented,
                    );
                  }
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding: const EdgeInsets.all(2.0),
                  decoration: BoxDecoration(
                    color: isChecked.value ? Colors.green : Colors.grey[300],
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.check, color: Colors.white, size: 12.0.r),
                ),
              ),
            ),
            8.horizontalSpace,
            GestureDetector(
              onTap: () {
                Utils.showToastBottom(message: AppStrings.notYetImplemented);
              },
              child: Text(
                'Remember me',
                style: GoogleFonts.plusJakartaSans(
                  color: Color(0xff435A39),
                  fontSize: 12.sp,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
          ],
        ),
        GestureDetector(
          onTap: () {
            Utils.showToastBottom(message: AppStrings.notYetImplemented);
          },
          child: CustomText(
            text: AppStrings.forgotPassword,
            textStyle: GoogleFonts.plusJakartaSans(
              color: Color(0xff435A39),
              fontSize: 12.sp,
              fontWeight: FontWeight.normal,
            ),
          ),
        ),
      ],
    );
  }

  Widget customTextField({
    required String label,
    Color? bgColor,
    required TextEditingController controller,
    bool isPassword = false,
  }) {
    RxBool showText = isPassword ? false.obs : true.obs;
    return Obx(
      () => Container(
        decoration: BoxDecoration(
          color: bgColor ?? Colors.transparent,
          borderRadius: BorderRadius.circular(40.r),
        ),
        child: TextFormField(
          controller: controller,
          obscureText: showText.value,
          decoration: InputDecoration(
            label: CustomText(
              text: label,
              textStyle: GoogleFonts.plusJakartaSans(
                color: AppColors.onPrimary,
                fontSize: 14.sp,
                fontWeight: FontWeight.normal,
              ),
            ),

            suffixIcon: Visibility(
              visible: !isPassword,
              child: GestureDetector(
                onTap: () {
                  showText.value = !showText.value;
                },
                child: Icon(Icons.remove_red_eye),
              ),
            ),

            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(40.r),
            ),
          ),
        ),
      ),
    );
  }

  Widget signInButton() {
    return GestureDetector(
      onTap: () async {
        await authController.performSignIn();
      },
      child: Container(
        height: 40.h,
        width: double.maxFinite,
        decoration: BoxDecoration(
          color: AppColors.secondary,
          borderRadius: BorderRadius.circular(40.r),
        ),
        child: Center(
          child: CustomText(
            text: AppStrings.signIn,
            textStyle: GoogleFonts.plusJakartaSans(
              color: AppColors.primary,
              fontSize: 14.sp,
              fontWeight: FontWeight.normal,
            ),
          ),
        ),
      ),
    );
  }
}
