import 'package:do_an_tong_hop/controller/posts_controller.dart';
import 'package:do_an_tong_hop/controller/user_controller.dart';
import 'package:do_an_tong_hop/screen/account/follow_page.dart';
import 'package:do_an_tong_hop/widgets/feed/feed_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:developer' as developer;

import 'big_avatar_user_widget.dart';
import 'menu_item_widget.dart';

class HeaderAccountWidget extends StatefulWidget {
  @override
  _HeaderAccountWidgetState createState() => _HeaderAccountWidgetState();
}

class _HeaderAccountWidgetState extends State<HeaderAccountWidget> {
  final UserController userController= Get.find();
  final PostsController postsController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).cardColor,
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(
              vertical: 16,
              horizontal: 16,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    BigAvatarUserWidget(),
                    Padding(
                      padding: EdgeInsets.only(top: 8),
                      child: Text('${userController.userDisplayPersonal.value.userName}', style: Theme.of(context).textTheme.bodyText2,),
                    )
                  ],
                ),
                Expanded(
                    child: Container(
                      alignment: Alignment.center,
                      child: Row(
                        children: <Widget>[
                          Expanded(child: MenuItemWidget(title: '${postsController.myPost.length}', content: 'Post',)),
                          Expanded(child: GestureDetector(child: MenuItemWidget(title: '${userController.userDisplayPersonal.value.followers.length}', content: 'Followers',),onTap: (){
                            Get.to(()=>FollowPage(initialIndex: 0,));
                          },)),
                          Expanded(child: GestureDetector(
                            onTap: (){
                              Get.to(()=>FollowPage(initialIndex: 1,));
                            },
                              child: MenuItemWidget(title: '${userController.userDisplayPersonal.value.following.length}', content: 'Following',)
                          ))
                        ],
                      ),
                    )
                )
              ],
            ),
          ),
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(
              horizontal: 16,
            ),
            child: Text('Mastering B&W: The Art of B&W \nEditor: ${userController.userDisplayPersonal.value.email} \nMod: ${userController.userDisplayPersonal.value.email} \nFounder: ${userController.userDisplayPersonal.value.email}',
              style: Theme.of(context).textTheme.bodyText1,),
          ),
          Container(
            padding: EdgeInsets.symmetric(
              vertical: 4,
              horizontal: 16
            ),
            width: double.infinity,
            child: OutlineButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(4))
              ),
              onPressed: (){},
              child: Text('Edit Profile', style: Theme.of(context).textTheme.subtitle2,),
            ),
          )
        ],
      ),
    );
  }
}
