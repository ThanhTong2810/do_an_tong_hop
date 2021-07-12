import 'package:do_an_tong_hop/theme/colors.dart';
import 'package:do_an_tong_hop/theme/icons_app.dart';
import 'package:do_an_tong_hop/screen/camera/camera_page.dart';
import 'package:do_an_tong_hop/screen/direct/direct_page.dart';
import 'package:do_an_tong_hop/theme/images_app.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class HeaderWidget extends StatelessWidget with PreferredSizeWidget {

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).primaryColor,
      elevation: 2,
      child: SafeArea(
        child: Container(
          child: Row(
            children: <Widget>[
              IconButton(icon: SvgPicture.asset(IconsApp.icCamera,
                color: Theme.of(context).colorScheme.onPrimary,), onPressed: (){
                Get.to(()=>CameraPage());
              }),
              Expanded(child: Container(
                child: Image(
                  image: AssetImage(
                    ImagesApp.logoBanQuanLy,
                  ),
                ),
              )),
              IconButton(icon: SvgPicture.asset(IconsApp.icSend,
                color: Theme.of(context).colorScheme.onPrimary,), onPressed: (){
                Get.to(() => DirectPage());
              })
            ],
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(50);
}
