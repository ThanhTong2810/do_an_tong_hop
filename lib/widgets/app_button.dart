
import 'package:do_an_tong_hop/theme/colors.dart';
import 'package:do_an_tong_hop/utils/utils.dart';
import 'package:flutter/material.dart';

import 'app_text.dart';

class AppButton extends StatelessWidget {
  final String titleButton;
  final double widthButton;
  final double heightButton;
  final Color color;
  final Color textColor;
  final Function onTap;

  const AppButton(this.titleButton,
      {this.widthButton, this.heightButton, this.color, this.textColor, this.onTap});

  @override
  Widget build(BuildContext context) {
    return _buildAppButton(
        context, titleButton, widthButton, heightButton, textColor, color);
  }

  Widget _buildAppButton(BuildContext context, String titleButton,
      double widthButton, double heightButton, textColor, Color color) {
    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: Container(
        width:
            widthButton != null ? widthButton : getScreenWidth(context) / 1.8,
        height:
            heightButton != null ? heightButton : getScreenWidth(context) / 8,
        decoration: BoxDecoration(
            color: color!=null?color:AppColors.white,
            borderRadius: BorderRadius.circular(15)),
        child: Align(
          alignment: Alignment.center,
          child: AppText(
            color: textColor != null ? textColor : AppColors.white,
            text: titleButton,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
