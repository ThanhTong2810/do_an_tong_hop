import 'package:do_an_tong_hop/theme/colors.dart';
import 'package:do_an_tong_hop/theme/dimens.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppText extends StatelessWidget {
  final String text;
  final double textSize;
  final Color color;
  final FontWeight fontWeight;
  final TextAlign textAlign;
  final int maxLines;
  final TextOverflow textOverflow;
  final FontStyle fontStyle;

  AppText(
      { this.text,
      this.textSize,
      this.color,
      this.fontStyle,
      this.fontWeight,
      this.textAlign,
      this.maxLines,
      this.textOverflow});

  @override
  Widget build(BuildContext context) {
    return Text(text,
        overflow: textOverflow,
        textAlign: textAlign,
        maxLines: maxLines,
        style: GoogleFonts.quicksand(
            fontStyle: fontStyle,
            fontSize: textSize == null ? Dimens.descriptionTextSize : textSize,
            color: color == null ? AppColors.white : color,
            fontWeight: fontWeight));
  }
}
