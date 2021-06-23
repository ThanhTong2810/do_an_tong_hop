import 'package:do_an_tong_hop/controller/chat_controller.dart';
import 'package:do_an_tong_hop/controller/user_controller.dart';
import 'package:do_an_tong_hop/models/chat/conversation.dart';
import 'package:do_an_tong_hop/models/user/user.dart';
import 'package:do_an_tong_hop/screen/chats/message_screen.dart';
import 'package:do_an_tong_hop/theme/colors.dart';
import 'package:do_an_tong_hop/theme/dimens.dart';
import 'package:do_an_tong_hop/theme/icons_app.dart';
import 'package:do_an_tong_hop/theme/images_app.dart';
import 'package:do_an_tong_hop/widgets/app_button.dart';
import 'package:do_an_tong_hop/widgets/app_text.dart';
import 'package:do_an_tong_hop/widgets/loading_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import 'direct_item_widget.dart';

class DirectPage extends StatefulWidget {
  @override
  _DirectPageState createState() => _DirectPageState();
}

class _DirectPageState extends State<DirectPage> {
  final UserController userController = Get.find();
  final ChatController chatController = Get.find();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return LoadingContainer(
          child: Scaffold(
            appBar: AppBar(
              title: Text(userController.user.value.userName),
              actions: [
                GestureDetector(
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 10.0),
                      child: AppText(
                        text: 'Create Group',
                        textSize: 12,
                        color: AppColors.clickableText,
                      ),
                    ),
                  ),
                  onTap: () {
                    chatController.listCheckCreateGroup.clear();
                    chatController.listCheck.assignAll(List<bool>.filled(
                        userController.listFollowing.length, false));
                    addGroupDialog();
                  },
                ),
              ],
            ),
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: AppText(
                      text: 'Following',
                      color: AppColors.black,
                    ),
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: userController.listFollowing.map((following) {
                      return GestureDetector(
                        child: Card(
                          elevation: 0,
                          child: ListTile(
                            leading: CircleAvatar(
                              radius: 20,
                              backgroundImage: NetworkImage(following.imgSrc),
                            ),
                            title: AppText(
                              text: '${following.userName}',
                              color: AppColors.black,
                            ),
                            trailing: SvgPicture.asset(
                              IconsApp.icSend,
                              color: Theme.of(context).colorScheme.onPrimary,
                            ),
                          ),
                        ),
                        onTap: () async {
                          Map containId = {};
                          if (chatController.listRoomContainId.isNotEmpty &&
                              chatController.listRoomContainId.values
                                      .where((element) =>
                                          element['containId'][following.id] !=
                                              null &&
                                          element['containId'].length == 2)
                                      .length ==
                                  1) {
                            containId = chatController.listRoomContainId.values
                                .where((element) =>
                                    element['containId'][following.id] !=
                                        null &&
                                    element['containId'].length == 2)
                                .first;
                          }
                          if (containId.isEmpty) {
                            print('Create New Room');
                            await chatController.createNewRoomChat(
                                following, userController);
                            Get.to(() => MessagesScreen(
                                name: following.userName,
                                imgSrc: following.imgSrc,
                                isGroup: false));
                          } else {
                            print('Already Has Room');
                            chatController.roomSelected.value =
                                containId['idRoom'];
                            Get.to(() => MessagesScreen(
                                name: containId['containId'][following.id]
                                    ['username'],
                                imgSrc: containId['containId'][following.id]
                                    ['imageSrc'],
                                isGroup: false));
                          }
                        },
                      );
                    }).toList(),
                  ),
                  Dimens.height10,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
                        child: AppText(
                          text: 'Group chat',
                          color: AppColors.black,
                        ),
                      ),
                      Dimens.height10,
                      Column(
                        children: chatController.listGroupChat.map((group) {
                          return GestureDetector(
                            child: Card(
                              elevation: 0,
                              child: ListTile(
                                leading: CircleAvatar(
                                  radius: 20,
                                  backgroundImage:
                                      NetworkImage(group['imageSrc']),
                                ),
                                title: AppText(
                                  text: '${group['name']}',
                                  color: AppColors.black,
                                ),
                                trailing: SvgPicture.asset(
                                  IconsApp.icSend,
                                  color:
                                      Theme.of(context).colorScheme.onPrimary,
                                ),
                              ),
                            ),
                            onTap: () {
                              chatController.roomSelected.value =
                                  group['idRoom'];
                              Get.to(() => MessagesScreen(
                                  name: group['name'],
                                  imgSrc: group['imageSrc'],
                                  isGroup: true));
                            },
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          isShowIndicator: true,
          isLoading: userController.isShowLoading.value);
    });
  }

  addGroupDialog() {
    return showDialog(
        context: context,
        builder: (addGroupContext) {
          return Obx(() {
            return Dialog(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: userController.listFollowing.map((following) {
                      return Row(
                        children: <Widget>[
                          Expanded(
                            child: Card(
                              elevation: 0,
                              child: ListTile(
                                leading: CircleAvatar(
                                  radius: 20,
                                  backgroundImage:
                                      NetworkImage(following.imgSrc),
                                ),
                                title: AppText(
                                  text: '${following.userName}',
                                  color: AppColors.black,
                                ),
                              ),
                            ),
                          ),
                          Checkbox(
                            value: chatController.listCheck[userController
                                .listFollowing
                                .indexOf(following)],
                            onChanged: (value) {
                              if (value == true) {
                                chatController.listCheck[userController
                                    .listFollowing
                                    .indexOf(following)] = true;
                                chatController.listCheckCreateGroup
                                    .add(following);
                              } else {
                                chatController.listCheck[userController
                                    .listFollowing
                                    .indexOf(following)] = false;
                                chatController.listCheckCreateGroup.removeWhere(
                                    (element) => element.id == following.id);
                              }
                            },
                          ),
                          Dimens.width20,
                        ],
                      );
                    }).toList(),
                  ),
                  AppButton(
                    'Create',
                    widthButton: 100,
                    textColor: AppColors.clickableText,
                    color: AppColors.transparent,
                    onTap: () async {
                      Get.back();
                      await chatController.createNewGroupChat(
                          chatController.listCheckCreateGroup, userController);
                      Get.to(
                          () => MessagesScreen(
                                imgSrc:
                                    "https://images.vexels.com/media/users/3/132363/isolated/preview/a31cc22b4b43c6dacdf885948f886f7c-support-blue-circle-icon-by-vexels.png",
                                name: "Duc And Friend",
                                isGroup: true,
                              ),
                          preventDuplicates: true);
                    },
                  ),
                  Dimens.height10,
                ],
              ),
            );
          });
        });
  }
}
