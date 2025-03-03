import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

class CustomText extends StatelessWidget {
  final String text;
  final double fontSize;
  final Color textColor;
  final String? fontFamily;
  final FontWeight fontWeight;
  final TextAlign textAlign;
  final bool? lineThrough;
  final double? lineSpacing;
  final int? maxLines;
  final TextOverflow? overflow;
  final TextStyle? textStyle;

  // Constructor with optional parameters
  const CustomText(
      {super.key,
        required this.text,
        this.overflow,
        this.textStyle,
        this.fontSize = 18.0,
        this.textColor = Colors.black,
        this.fontFamily,
        this.maxLines,
        this.fontWeight = FontWeight.normal,
        this.textAlign = TextAlign.left,
        this.lineThrough,
        this.lineSpacing});

  @override
  Widget build(BuildContext context) {
    Rx<TextStyle?> rxTextStyle = textStyle.obs;
    return Obx(() {
      return Text(
        text,
        overflow: overflow ?? TextOverflow.ellipsis,
        style: rxTextStyle.value ??
            TextStyle(
                fontSize: fontSize,
                color: textColor,
                fontFamily: fontFamily,
                fontWeight: fontWeight,
                decoration: lineThrough == null || lineThrough == false
                    ? TextDecoration.none
                    : TextDecoration.lineThrough,
                height: lineSpacing ?? 1),
        maxLines: maxLines ?? 2,
        textAlign: textAlign,
      );
    });
  }
}
