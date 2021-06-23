import 'package:do_an_tong_hop/controller/chat_controller.dart';
import 'package:do_an_tong_hop/controller/posts_controller.dart';
import 'package:do_an_tong_hop/controller/user_controller.dart';
import 'package:do_an_tong_hop/helpers/notification_helper.dart';
import 'package:do_an_tong_hop/theme/icons_app.dart';
import 'package:do_an_tong_hop/screen/account/account_page.dart';
import 'package:do_an_tong_hop/screen/activity/activity_page.dart';
import 'package:do_an_tong_hop/screen/home/home_page.dart';
import 'package:do_an_tong_hop/screen/post/post_page.dart';
import 'package:do_an_tong_hop/screen/search/search_pages.dart';
import 'package:do_an_tong_hop/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:tuple/tuple.dart';

import 'bottom_navigation_item.dart';

class BottomNavPage extends StatefulWidget {
  @override
  _BottomNavPageState createState() => _BottomNavPageState();
}

class _BottomNavPageState extends State<BottomNavPage> {
  final UserController userController =Get.find();
  final ChatController chatController = Get.find();
  final PostsController postsController = Get.find();

  int _currentTabIndex = 0;
  PageController _pageController = PageController(initialPage: 0);

  List<Tuple2<String, String>> tabsIcons = [
    Tuple2(IconsApp.icHome,  IconsApp.icHomeSelected),
    Tuple2(IconsApp.icSearch,  IconsApp.icSearchSelected),
    Tuple2(IconsApp.icCreatePost,  IconsApp.icCreatePost),
    Tuple2(IconsApp.icFavorite,  IconsApp.icFavoriteSelected),
    Tuple2(IconsApp.icAccount, IconsApp.icAccountSelected),
  ];

  @override
  void initState() {
    NotificationHelper.handleNotification(context);
    onWidgetBuildDone(getSuggestedAndFollow);
    super.initState();
  }

  getSuggestedAndFollow() async{
    userController.listSuggestedAccount.clear();
    userController.listFollowers.clear();
    userController.listFollowing.clear();
    await postsController.getPosts(userController);
    await userController.getSuggestedAccount(userController.user.value.id);
    await userController.getListFollowers();
    await userController.getListFollowing();
    await chatController.getAllRoomContainMyId(userController.user.value.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          if(index <= 1) {
            setState(() {
              _currentTabIndex = index;
            });
          } else {
            setState(() {
              _currentTabIndex = index + 1;
            });
          }
        },
        children: <Widget>[
          HomePage(),
          SearchPages(),
          ActivityPage(),
          AccountPage()
        ],
      ),
      bottomNavigationBar: Material(
        elevation: 4,
        color: Theme.of(context).bottomAppBarColor,
        child: SafeArea(
          child: Container(
            decoration: BoxDecoration(
              border: Border(
                top: Divider.createBorderSide(context)
              )
            ),
            height: 56,
            child: Row(
              children: <Widget>[
                Expanded(child: BottomNavigationItem(
                    tabsIcons[0],
                    0 == _currentTabIndex,
                    onPress: () {
                      setState(() {
                        _currentTabIndex = 0;
                        _pageController.jumpToPage(0);
                      });
                    }
                )),
                Expanded(child: BottomNavigationItem(
                    tabsIcons[1],
                    1 == _currentTabIndex,
                    onPress: () {
                      setState(() {
                        _currentTabIndex = 1;
                        _pageController.jumpToPage(1);
                      });
                    }
                ),),
                Expanded(child: BottomNavigationItem(
                    tabsIcons[2],
                    2 == _currentTabIndex,
                    onPress: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => PostPage())
                      );
                    }
                )),
                Expanded(child: BottomNavigationItem(
                    tabsIcons[3],
                    3 == _currentTabIndex,
                    onPress: () {
                      setState(() {
                        _currentTabIndex = 3;
                        _pageController.jumpToPage(2);
                      });
                    }
                )),
                Expanded(child: BottomNavigationItem(
                    tabsIcons[4],
                    4 == _currentTabIndex,
                    onPress: () {
                      setState(() {
                        _currentTabIndex = 4;
                        _pageController.jumpToPage(3);
                      });
                    }
                )),
              ],
            ),
          ),
          bottom: true,
        ),
      ),
    );
  }
}
