import 'package:do_an_tong_hop/theme/dimens.dart';
import 'package:do_an_tong_hop/theme/images_app.dart';
import 'package:do_an_tong_hop/widgets/fade_container.dart';
import 'package:flutter/material.dart';


class AppLogo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final logoSize = Dimens.getLogoSize(context);
    return Padding(
      padding: EdgeInsets.only(top: logoSize),
      child: FadeContainer(child: Image.asset(ImagesApp.logo, width: logoSize,)),
    );
  }
}
