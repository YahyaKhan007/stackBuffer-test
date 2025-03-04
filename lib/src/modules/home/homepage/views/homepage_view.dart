import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stackbuffer_test/src/core/custom_elements/app_assets.dart';
import 'package:stackbuffer_test/src/core/custom_elements/app_constants.dart';
import 'package:stackbuffer_test/src/core/custom_elements/custom_text.dart';
import 'package:stackbuffer_test/src/core/services/route_service/app_route_service.dart';
import 'package:stackbuffer_test/src/modules/home/homepage/controller/homepage_controller.dart';

import '../../../../core/custom_elements/app_colors.dart';

class HomepageView extends StatelessWidget {
  HomepageView({super.key});

  final HomepageController homepageController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Padding(
          padding: EdgeInsets.only(left: 16.0),
          child: Text(
            'Hi ${homepageController.userService.currentUser.value?.name ?? ""}',
            style: GoogleFonts.plusJakartaSans(
              color: AppColors.blueGrey,
              fontSize: 22.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        actions: [
          IconButton(
            onPressed: homepageController.logout,
            icon: Icon(Icons.logout, color: AppColors.errorColor),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
             Text(
              'Popular Now',
              style: GoogleFonts.plusJakartaSans(
                color: AppColors.blueGrey,
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 0.8,
                ),
                itemCount: AppConstants.burgerNames.length,
                itemBuilder: (context, index) {
                  return _buildBurgerCard(index: index , onTap: (){
                    Get.toNamed(AppRoutes.productDetails.path);
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBurgerCard({required int index, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.blue.shade50,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(AppAssets.burger),
            // 8.verticalSpace,
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start
                ,crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppConstants.burgerNames[index],
                    style: GoogleFonts.plusJakartaSans(
                      color: AppColors.blueGrey,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  8.verticalSpace,

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start
                      ,crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                          text: 'Cicada Market',
                          textStyle: GoogleFonts.plusJakartaSans(
                            color: AppColors.grey,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        // 8.verticalSpace,
                        CustomText(
                          text: AppConstants.prices[index],
                          textStyle: GoogleFonts.plusJakartaSans(
                            color: AppColors.secondary,
                            fontSize: 20.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration:  BoxDecoration(
                        color: AppColors.secondary.withValues(alpha: 0.7),
                        shape: BoxShape.circle,
                      ),
                      child:  Image.asset(AppAssets.cartIcon),
                    ).paddingOnly(top: 12.h),
                    // 8.verticalSpace,


                  ],)
                ],
              ).paddingSymmetric(horizontal: 16.w),
            )
          ],
        ),
      ),
    );
  }
}
