import 'package:do_an_tong_hop/controller/chat_controller.dart';
import 'package:do_an_tong_hop/controller/user_controller.dart';
import 'package:do_an_tong_hop/models/chat/conversation.dart';
import 'package:do_an_tong_hop/models/user/user.dart';
import 'package:do_an_tong_hop/screen/chats/message_screen.dart';
import 'package:do_an_tong_hop/theme/colors.dart';
import 'package:do_an_tong_hop/theme/icons_app.dart';
import 'package:do_an_tong_hop/theme/images_app.dart';
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
    return Obx((){
      return LoadingContainer(
        child: Scaffold(
          appBar: AppBar(
            title: Text(userController.user.value.userName),
            actions: [
              IconButton(
                icon: Icon(Icons.video_call),
                onPressed: (){},)
            ],
          ),
          body: ListView(
            children: userController.listFollowing.map((following){
              return GestureDetector(
                child: Card(
                  elevation: 0,
                  child: ListTile(
                    leading:  CircleAvatar(
                      radius: 20,
                      backgroundImage: NetworkImage(following.imgSrc),
                    ),
                    title: AppText(
                      text: '${following.userName}',
                      color: AppColors.black,
                    ),
                    trailing: SvgPicture.asset(IconsApp.icSend,
                      color: Theme.of(context).colorScheme.onPrimary,),
                  ),
                ),
                onTap: () async{
                  Map containId = {};
                  if(chatController.listRoomContainId.isNotEmpty){
                    containId = chatController.listRoomContainId.values.where((element) => element['containId'][following.id] != null && element['containId'].length == 2).first;
                  }
                  if(containId.isEmpty){
                    print('Create New Room');
                    await chatController.createNewRoomChat(following, userController);
                    Get.to(()=>MessagesScreen(name: following.userName, imgSrc:  following.imgSrc,));
                  }else{
                    print('Already Has Room');
                    chatController.roomSelected.value = containId['idRoom'];
                    Get.to(()=>MessagesScreen(name: containId['containId'][following.id]['username'], imgSrc: containId['containId'][following.id]['image'],));
                  }
                },
              );
            }).toList(),
          ),
        ),
        isShowIndicator: true,
        isLoading: userController.isShowLoading.value
      );
    });
  }
}
