import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:stackbuffer_test/src/core/custom_elements/app_colors.dart';

import 'app_loadings.dart';


Widget customImage({
  required String? url, // Allow nullable URL
  required double height,
  required double width,
  Color? svgColor,
  double borderRadius = 8,
}) {
  if (url == null || url.isEmpty) {
    url =
    "https://www.pngall.com/wp-content/uploads/5/User-Profile-PNG.png"; // Default URL
  }

  bool isNetworkImage = Uri.tryParse(url)?.hasAbsolutePath ?? false;
  bool isSvg = url.toLowerCase().endsWith('.svg');

  debugPrint("The image is SVG: $isSvg");
  debugPrint("The image url is: $url");

  return SizedBox(
    height: height,
    width: width,
    child: ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: isSvg
          ? _safeSvgAsset(
        url: url,
        height: height,
        width: width,
        svgColor: svgColor,
        borderRadius: borderRadius,
      )
          : (isNetworkImage
          ? CachedNetworkImage(
        imageUrl: url,
        fit: BoxFit.cover,
        placeholder: (context, url) => Center(
          child: AppLoadings.loadingWidgetInkDrop(
            size: 24.r,
            color:
            AppColors.onPrimary,
          ),
        ),
        errorWidget: (context, url, error) => Icon(
          Icons.person,
          color:  AppColors.onPrimary,
          size: (width / 3).r,
        ),
      )
          : _safeImageAsset(
        url: url,
        height: height,
        width: width,
        borderRadius: borderRadius,
      )),
    ),
  );
}

Widget _safeSvgAsset({
  required String url,
  required double height,
  required double width,
  Color? svgColor,
  double borderRadius = 8,
}) {

  try {
    return SvgPicture.asset(
      url,
      fit: BoxFit.cover,
      height: height,
      width: width,
      colorFilter: ColorFilter.mode(
        svgColor ??  AppColors.onPrimary,
        BlendMode.srcIn,
      ),
    );
  } catch (e) {
    debugPrint('SVG Asset Error: $e');
    return Icon(
      Icons.error,
      color:  AppColors.onPrimary,
      size: (width / 3).r,
    );
  }
}

Widget _safeImageAsset({
  required String url,
  required double height,
  required double width,
  double borderRadius = 8,
}) {
 try {
    return Image.asset(
      url,
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) {
        return Icon(
          Icons.error,
          color:  AppColors.onPrimary,
          size: (width / 3).r,
        );
      },
    );
  } catch (e) {
    debugPrint('Image Asset Error: $e');
    return Icon(
      Icons.error,
      color:  AppColors.onPrimary,
    
      size: (width / 3).r,
    );
  }
}
