import 'package:do_an_tong_hop/controller/user_controller.dart';
import 'package:do_an_tong_hop/models/user/user_get_account_by_id.dart';
import 'package:do_an_tong_hop/theme/colors.dart';
import 'package:do_an_tong_hop/theme/dimens.dart';
import 'package:do_an_tong_hop/utils/utils.dart';
import 'package:do_an_tong_hop/widgets/app_text.dart';
import 'package:do_an_tong_hop/widgets/loading_container.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FollowPage extends StatefulWidget {
  final int initialIndex;
  const FollowPage({Key key, this.initialIndex}) : super(key: key);

  @override
  _FollowPageState createState() => _FollowPageState();
}

class _FollowPageState extends State<FollowPage> {
  final UserController userController =Get.find();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx((){
      return LoadingContainer(
        child: Scaffold(
          appBar: AppBar(
            elevation: 0,
            leading: GestureDetector(child: Icon(Icons.arrow_back_ios_sharp,color: AppColors.black,),onTap: (){Get.back();},),
            title: AppText(
              text: '${userController.user.value.userName}',
              color: AppColors.black,
            ),
          ),
          body: DefaultTabController(
            initialIndex: widget.initialIndex,
            length: 2,
            child: Column(
              children: <Widget>[
                TabBar(
                  tabs: <Widget>[
                    Tab(
                      child: AppText(
                        text: 'Followers',
                        color: AppColors.black,
                      ),
                    ),
                    Tab(
                      child: AppText(
                        text: 'Following',
                        color: AppColors.black,
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: TabBarView(
                    children: <Widget>[
                      ///Followers
                      userController.listFollowers.isNotEmpty?ListView(
                        padding: EdgeInsets.zero,
                        children: userController.listFollowers.map((followers){
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: <Widget>[
                                CircleAvatar(
                                  radius: 20,
                                  backgroundImage: NetworkImage(followers.imgSrc),
                                ),
                                Dimens.width10,
                                AppText(
                                  text: '${followers.userName}',
                                  color: AppColors.black,
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      ):Center(
                        child: AppText(
                          text: 'Not Found',
                          color: AppColors.black,
                        ),
                      ),
                      ///Following
                      SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              AppText(
                                text: 'List Following',
                                color: AppColors.black,
                              ),
                              userController.listFollowing.isNotEmpty?Column(
                                children: userController.listFollowing.map((following){
                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: <Widget>[
                                        Expanded(
                                          child: Row(
                                            children: <Widget>[
                                              CircleAvatar(
                                                radius: 20,
                                                backgroundImage: NetworkImage(following.imgSrc),
                                              ),
                                              Dimens.width10,
                                              AppText(
                                                text: '${following.userName}',
                                                color: AppColors.black,
                                              ),
                                            ],
                                          ),
                                        ),
                                        GestureDetector(
                                          child: Container(
                                            decoration: BoxDecoration(
                                                border: Border.all(color: AppColors.clickableText),
                                                borderRadius: BorderRadius.circular(20),
                                                color: AppColors.clickableText
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: AppText(
                                                text: 'UnFollow',
                                              ),
                                            ),
                                          ),
                                          onTap: ()async{
                                            await userController.unFollow(userController.user.value.id, following.id);
                                            userController.listFollowing.removeWhere((element) => element.id == following.id);
                                          },
                                        ),
                                      ],
                                    ),
                                  );
                                }).toList(),
                              ):Center(
                                child: AppText(
                                  text: 'Not Found',
                                  color: AppColors.black,
                                ),
                              ),
                              AppText(
                                text: 'Suggested Following',
                                color: AppColors.black,
                              ),
                              userController.listSuggestedAccount.isNotEmpty?Column(
                                children: userController.listSuggestedAccount.map((suggested){
                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: <Widget>[
                                        Expanded(
                                          child: Row(
                                            children: <Widget>[
                                              CircleAvatar(
                                                radius: 30,
                                                backgroundImage: NetworkImage(suggested.imgSrc),
                                              ),
                                              Dimens.width10,
                                              AppText(
                                                text: '${suggested.userName}',
                                                color: AppColors.black,
                                              ),
                                            ],
                                          ),
                                        ),
                                        GestureDetector(
                                          child: Container(
                                            decoration: BoxDecoration(
                                                border: Border.all(color: AppColors.clickableText),
                                                borderRadius: BorderRadius.circular(20),
                                                color: AppColors.clickableText
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: AppText(
                                                text: 'Follow',
                                              ),
                                            ),
                                          ),
                                          onTap: ()async{
                                            await userController.addFollow(userController.user.value.id, suggested.id);
                                            UserGetById user = await userController.getAccountById(suggested.id);
                                            userController.listFollowing.add(user);
                                            userController.listSuggestedAccount.removeWhere((element) => element.id == suggested.id);
                                          },
                                        ),
                                        Dimens.width10,
                                        GestureDetector(
                                          child: Icon(Icons.clear,color: AppColors.black,),
                                          onTap: (){
                                            userController.listSuggestedAccount.removeWhere((element) => element.id == suggested.id);
                                          },
                                        ),
                                      ],
                                    ),
                                  );
                                }).toList(),
                              ):Center(
                                child: AppText(
                                  text: 'Not Found',
                                  color: AppColors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        isLoading: userController.isShowLoading.value,
        isShowIndicator: true
      );
    });
  }
}
