import 'package:flutter/material.dart';
import 'package:oasis/components/themes/app_theme.dart';
import 'package:oasis/core/gen/fonts.gen.dart';
import 'package:oasis/common/common.dart';

class AppText extends StatelessWidget {
  const AppText(
    this.text, {
    super.key,
    this.fontSize,
    this.fontWeight,
    this.textAlign,
    this.fontFamily = FontFamily.inter,
    this.letterSpacing,
    this.color = AppColors.white,
    this.decoration,
    this.height,
    this.overflow,
    this.decorationColor,
    this.maxLines,
    this.decorationStyle,
    this.fontFeatures,
  });

  final dynamic text;
  final TextAlign? textAlign;
  final double? fontSize, letterSpacing, height;
  final String? fontFamily;
  final Color? color, decorationColor;
  final int? maxLines;
  final TextOverflow? overflow;
  final TextDecoration? decoration;
  final TextDecorationStyle? decorationStyle;
  final FontWeight? fontWeight;
  final List<FontFeature>? fontFeatures;

  @override
  Widget build(BuildContext context) {
    return Text(
      text is String || text is String?
          ? "${text.toString().isNullOrEmpty ? "" : text}"
          : (text ?? "").toString(),
      textAlign: textAlign ?? TextAlign.start,
      maxLines: maxLines,
      style: TextStyle(
        fontWeight: fontWeight,
        fontSize: fontSize,
        fontFamily: fontFamily,
        letterSpacing: letterSpacing,
        color: color ?? AppColors.black,
        height: height,
        overflow: overflow,
        decoration: decoration,
        decorationStyle: decorationStyle,
        decorationColor: decorationColor,
        fontFeatures: fontFeatures,
      ),
    );
  }
}