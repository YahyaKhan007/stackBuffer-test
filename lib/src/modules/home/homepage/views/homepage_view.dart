import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stackbuffer_test/src/core/custom_elements/app_assets.dart';
import 'package:stackbuffer_test/src/core/custom_elements/app_constants.dart';
import 'package:stackbuffer_test/src/core/custom_elements/custom_text.dart';
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
            style: TextStyle(
              color: Colors.black,
              fontSize: 24,
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
            const Text(
              'Popular Now',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.black,
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
                  return _buildBurgerCard(index);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBurgerCard(int index) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(AppAssets.burger),
          // 8.verticalSpace,
          Text(
            AppConstants.burgerNames[index],
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          CustomText(
            text: 'Cicada Market',
            textStyle: GoogleFonts.plusJakartaSans(
              color: Colors.grey,
              fontSize: 12.sp,
              fontWeight: FontWeight.normal,
            ),
          ),
          8.verticalSpace,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CustomText(
                text: AppConstants.prices[index],
                textStyle: GoogleFonts.plusJakartaSans(
                  color: Colors.grey,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.normal,
                ),
              ),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: const BoxDecoration(
                  color: Colors.orange,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.shopping_bag, color: Colors.white),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
