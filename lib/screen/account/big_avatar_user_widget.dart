import 'package:do_an_tong_hop/controller/user_controller.dart';
import 'package:do_an_tong_hop/theme/colors.dart';
import 'package:do_an_tong_hop/theme/images_app.dart';
import 'package:do_an_tong_hop/widgets/app_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:developer' as developer;

import 'package:get/get.dart';

class BigAvatarUserWidget extends StatefulWidget {
  @override
  _BigAvatarUserWidgetState createState() => _BigAvatarUserWidgetState();
}

class _BigAvatarUserWidgetState extends State<BigAvatarUserWidget> {
  final UserController userController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Obx((){
      return Container(
        width: 80,
        height: 80,
        child: Stack(
          children: <Widget>[
            Positioned.fill(child: CircleAvatar(
              backgroundImage: NetworkImage(userController.user.value.imgSrc),
            )),
            Positioned(
              child: ClipOval(
                child: GestureDetector(
                  onTap: (){
                    _changeAvatar();
                  },
                  child: Container(
                    decoration: ShapeDecoration(
                        color: Colors.blueAccent,
                        shape: CircleBorder(
                          side: Divider.createBorderSide(context, width: 2, color: Theme.of(context).cardColor),
                        )
                    ),
                    padding: EdgeInsets.all(2),
                    alignment: Alignment.center,
                    child: Icon(Icons.add, size: 12, color: Colors.white,),
                  ),
                ),
              ),
              right: 0,
              bottom: 0,
            )
          ],
        ),
      );
    });
  }

  void _changeAvatar() {
    if (userController.user.value != null) {
      showCupertinoModalPopup(
          context: context,
          builder: (context) => _buildCupertinoActionSheetChangeAvatar());
    }
  }

  Widget _buildCupertinoActionSheetChangeAvatar() {
    return CupertinoActionSheet(
      message: AppText(
          text: 'Change Avatar',
      ),
      actions: <Widget>[
        CupertinoActionSheetAction(
          child: AppText(
            text: 'From Library',
            color: AppColors.clickableText,
          ),
          onPressed: () async {
            userController.choosePhotoFromLibrary();
            Get.back();
          },
        ),
        CupertinoActionSheetAction(
          child: AppText(
            text: 'From Camera',
            color: AppColors.clickableText,
          ),
          onPressed: () async {
            userController.takeNewPhoto();
            Get.back();
          },
        ),
      ],
    );
  }
}
