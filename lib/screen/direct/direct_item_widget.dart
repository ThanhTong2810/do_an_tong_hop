import 'package:do_an_tong_hop/controller/user_controller.dart';
import 'package:do_an_tong_hop/models/chat/conversation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DirectItemWidget extends StatelessWidget {
  final Conversation conversation;
  final UserController userController =Get.find();

  DirectItemWidget(this.conversation);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: 12,
        horizontal: 16
      ).copyWith(
        right: 0
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage(conversation.user.imgSrc),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(conversation.user.userName,
                    style: Theme.of(context).textTheme.subtitle1,),
                  Text(conversation.isActive ? 'Active now' : 'Active 1h ago',
                    style: Theme.of(context).textTheme.caption,),
                ],
              ),
            ),
          ),
          IconButton(
              icon: Icon(Icons.camera_alt),
              onPressed: (){},
          )
        ],
      ),
    );
  }
}
