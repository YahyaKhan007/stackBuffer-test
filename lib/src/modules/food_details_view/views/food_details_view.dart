import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stackbuffer_test/src/core/custom_elements/app_assets.dart';
import 'package:stackbuffer_test/src/core/custom_elements/app_colors.dart';
import 'package:stackbuffer_test/src/core/custom_elements/app_constants.dart';
import 'package:stackbuffer_test/src/core/custom_elements/app_strings.dart';
import 'package:stackbuffer_test/src/core/custom_elements/custom_image.dart';
import 'package:stackbuffer_test/src/core/custom_elements/custom_text.dart';
import 'package:stackbuffer_test/src/core/utils.dart';

class FoodDetailsScreen extends StatelessWidget {
  final String tag;

  const FoodDetailsScreen({Key? key, required this.tag}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Hero(
            tag: tag,
            child: Image.asset(
              AppAssets.lunchImage,
              height: 350.h,
              width: double.maxFinite,
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            top: 32.h,
            left: 16.w,
            child: CircleAvatar(
              backgroundColor: AppColors.primary,
              child: IconButton(
                icon: Icon(
                  Icons.arrow_back_ios_new,
                  color: AppColors.onPrimary,
                  size: 16.r,
                ),
                onPressed: () => Navigator.pop(context),
              ),
            ),
          ),
          Positioned(
            top: 32.h,
            right: 16.w,
            child: CircleAvatar(
              backgroundColor: AppColors.primary,
              child: IconButton(
                icon: Icon(
                  CupertinoIcons.heart,
                  color: AppColors.onPrimary,
                  size: 16.r,
                ),
                onPressed: () {
                  Utils.showToastCenter(message: AppStrings.notYetImplemented);
                },
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 250.h),
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.w),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(40.r)),
            ),
            child: detailSection(),
          ),
        ],
      ),
    );
  }

  Widget detailSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          text: 'Meatballs',
          textStyle: GoogleFonts.quicksand(
            color: AppColors.blueGrey,
            fontSize: 24.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 8.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                RatingBar.builder(
                  initialRating: 4.0,
                  minRating: 1,
                  itemSize: 14.r,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemPadding: EdgeInsets.symmetric(horizontal: 4.w),
                  itemBuilder:
                      (context, _) => Icon(Icons.star, color: Colors.amber),
                  onRatingUpdate: (rating) {
                    debugPrint('Rating: $rating');
                  },
                ),
                SizedBox(width: 8.w),
                CustomText(
                  text: '4.9',
                  textStyle: GoogleFonts.quicksand(
                    color: AppColors.blueGrey,
                    fontSize: 12.sp,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Icon(Icons.alarm, size: 16.r, color: AppColors.secondary),
                SizedBox(width: 4.w),
                CustomText(
                  text: '10 - 15 min',
                  textStyle: GoogleFonts.quicksand(
                    color: AppColors.blueGrey,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ],
        ),
        SizedBox(height: 8.h),
        CustomText(
          maxLines: 25,
          text: AppConstants.foodDescription,
          textStyle: GoogleFonts.quicksand(
            color: AppColors.blueGrey,
            fontSize: 12.sp,
          ),
        ),
        Spacer(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomText(
              text: 'Rs 22.65',
              textStyle: GoogleFonts.quicksand(
                color: Colors.black,
                fontSize: 24.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 12.h),
                backgroundColor: Colors.amber,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.r),
                ),
              ),
              onPressed: () async {
                // Mock payment method for demo purposes
                try {
                  await Stripe.instance.initPaymentSheet(
                    paymentSheetParameters: SetupPaymentSheetParameters(
                      paymentIntentClientSecret:
                          'sk_test_51QyxSSFmnvNKignLeRMcjgygfOPdYmynSVarU9VjRBBLm4i1YpCXk3aKoX0pyX2bXXF0MqnT2o6d5p2NYk1bJqvZ004TgJYR2d',
                      merchantDisplayName: 'Your App Name',
                    ),
                  );
                  await Stripe.instance.presentPaymentSheet();
                  Utils.showToastCenter(message: 'Payment Successful');
                } catch (e) {
                  Utils.showToastCenter(message: 'Payment Failed');
                }
              },
              child: const Text(
                'Pay Now',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
