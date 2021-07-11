import 'dart:developer' as developer;

import 'package:do_an_tong_hop/controller/user_controller.dart';
import 'package:do_an_tong_hop/screen/apartment/bill_apartment.dart';
import 'package:do_an_tong_hop/screen/apartment/cost_apartment.dart';
import 'package:do_an_tong_hop/screen/apartment/post_apartment.dart';
import 'package:do_an_tong_hop/screen/sign_in_page/sign_in_page.dart';
import 'package:do_an_tong_hop/theme/colors.dart';
import 'package:do_an_tong_hop/theme/dimens.dart';
import 'package:do_an_tong_hop/widgets/app_text.dart';
import 'package:do_an_tong_hop/widgets/bottomsheet/bottom_sheet_action.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:do_an_tong_hop/widgets/app_context.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

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
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              userController.userDisplayPersonal.value.id == userController.user.value.id ? SizedBox() : IconButton(icon: Icon(Icons.arrow_back_ios_sharp), onPressed: (){
                Get.back();
              }),
              Dimens.height10,
              Container(
                padding: EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 12
                ),
                child: Row(
                  children: <Widget>[
                    Text('${userController.userDisplayPersonal.value.userName}', style: Theme.of(context).primaryTextTheme.subtitle2,),
                    Icon(Icons.keyboard_arrow_down, size: 16,)
                  ],
                ),
              ),
              Expanded(child: SizedBox()),
              userController.userDisplayPersonal.value.id == userController.user.value.id ?IconButton(
                icon: Icon(Icons.menu),
                onPressed: () async{
                  showModalBottomSheet(
                      context: context,
                    builder: (BuildContext contextOptions){
                        return Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            GestureDetector(
                              child: Card(
                                elevation: 0,
                                child: ListTile(
                                  leading: Icon(Icons.logout, color: AppColors.black,),
                                  title: AppText(
                                    text: 'Logout',
                                    color: AppColors.black,
                                  ),
                                ),
                              ),
                              onTap: () async{
                                print('--->Logout<---');
                                Get.back();
                                Get.off(()=>SignInPage());
                                final openBox = await Hive.openBox('USER');
                                await openBox.clear();
                                await userController.logOut();
                                userController.user.value = null;

                              },
                            ),
                            GestureDetector(
                              child: Card(
                                elevation: 0,
                                child: ListTile(
                                  leading: Icon(Icons.article_outlined, color: AppColors.black,),
                                  title: AppText(
                                    text: 'Post Apartment',
                                    color: AppColors.black,
                                  ),
                                ),
                              ),
                              onTap: () async{
                                Get.back();
                                Get.to(()=>PostApartmentScreen());
                              },
                            ),
                            GestureDetector(
                              child: Card(
                                elevation: 0,
                                child: ListTile(
                                  leading: Icon(Icons.monetization_on_outlined, color: AppColors.black,),
                                  title: AppText(
                                    text: 'Bill Apartment',
                                    color: AppColors.black,
                                  ),
                                ),
                              ),
                              onTap: () async{
                                Get.back();
                                Get.to(()=>BillApartmentScreen());
                              },
                            ),
                          ],
                        );
                    },
                  );
                },
              ):SizedBox()
            ],
          ),
        ),
        elevation: 0,
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