import 'package:do_an_tong_hop/theme/colors.dart';
import 'package:do_an_tong_hop/utils/utils.dart';
import 'package:flutter/material.dart';


class GradientBackground extends StatelessWidget {
  final Widget child;

  GradientBackground({Key key,  this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          width: getScreenWidth(context),
          height: getScreenHeight(context),
          decoration: BoxDecoration(
          gradient: LinearGradient(colors: AppColors.gradientColorPrimary)
          ),
          child: this.child),
    );
  }
}
