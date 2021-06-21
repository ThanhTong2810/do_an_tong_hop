import 'dart:developer' as developer;

import 'package:do_an_tong_hop/controller/user_controller.dart';
import 'package:do_an_tong_hop/widgets/bottomsheet/bottom_sheet_action.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:do_an_tong_hop/widgets/app_context.dart';
import 'package:get/get.dart';

class AppBarAccountDelegate extends SliverPersistentHeaderDelegate {
  final UserController userController = Get.find();
  final double topPadding;

  AppBarAccountDelegate(this.topPadding);
  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Obx((){
      return Material(
        color: Theme.of(context).primaryColor,
        child: Container(
          height: kToolbarHeight + topPadding,
          padding: EdgeInsets.only(top: topPadding),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                padding: EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 12
                ),
                child: Row(
                  children: <Widget>[
                    Text('${userController.user.value.userName} ${userController.user.value.name}', style: Theme.of(context).primaryTextTheme.subtitle2,),
                    Icon(Icons.keyboard_arrow_down, size: 16,)
                  ],
                ),
              ),
              IconButton(
                icon: Icon(Icons.menu),
                onPressed: (){
                  context.showBottomSheet(
                      [
                        BottomSheetAction(iconData: Icons.archive, title: 'Archive', id: 1,onTap: (){}),
                        BottomSheetAction(iconData: Icons.show_chart, title: 'Insights', id: 2,onTap: (){}),
                        BottomSheetAction(iconData: Icons.history, title: 'Your activity', id: 3,onTap: (){}),
                        BottomSheetAction(iconData: Icons.scanner, title: 'QR Code', id: 4,onTap: (){}),
                        BottomSheetAction(iconData: Icons.bookmark_border, title: 'Saved', id: 5,onTap: (){}),
                        BottomSheetAction(iconData: Icons.group_add, title: 'Discover People', id: 6,onTap: (){}),
                      ]
                  );
                },
              )
            ],
          ),
        ),
        elevation: (overlapsContent || (shrinkOffset > maxExtent - minExtent)) ? 4: 0,
      );
    });
  }

  @override
  double get maxExtent => kToolbarHeight + topPadding;

  @override
  double get minExtent => kToolbarHeight + topPadding;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }


}