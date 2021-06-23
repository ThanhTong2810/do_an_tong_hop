import 'package:do_an_tong_hop/controller/chat_controller.dart';
import 'package:do_an_tong_hop/controller/user_controller.dart';
import 'package:do_an_tong_hop/models/chat/chat_messages_model.dart';
import 'package:do_an_tong_hop/models/individual_chat/individual_chat.dart';
import 'package:do_an_tong_hop/models/user/user_get_account_by_id.dart';
import 'package:do_an_tong_hop/theme/colors.dart';
import 'package:do_an_tong_hop/theme/dimens.dart';
import 'package:do_an_tong_hop/theme/icons_app.dart';
import 'package:do_an_tong_hop/theme/images_app.dart';
import 'package:do_an_tong_hop/utils/utils.dart';
import 'package:do_an_tong_hop/widgets/app_button.dart';
import 'package:do_an_tong_hop/widgets/app_text.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class MessagesScreen extends StatefulWidget {
  final String name;
  final String imgSrc;
  final bool isGroup;

  const MessagesScreen({Key key, this.name, this.imgSrc, this.isGroup}) : super(key: key);
  @override
  _MessagesScreenState createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> {
  final ChatController chatController = Get.find();
  final UserController userController = Get.find();
  TextEditingController _content = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx((){
      return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          flexibleSpace: SafeArea(
            child: Container(
              padding: EdgeInsets.only(right: 16),
              child: Row(
                children: <Widget>[
                  IconButton(
                    onPressed: () {
                      Get.back();
                    },
                    icon: Icon(Icons.arrow_back, color: Colors.black,),
                  ),
                  SizedBox(width: 2,),
                  CircleAvatar(
                    backgroundImage: NetworkImage(widget.imgSrc),
                    maxRadius: 20,
                  ),
                  SizedBox(width: 12,),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(widget.name, style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600),overflow: TextOverflow.ellipsis,),
                        SizedBox(height: 6,),
                        Text("Online", style: TextStyle(
                            color: Colors.grey.shade600, fontSize: 13),),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        body: Column(
          children: <Widget>[
            Expanded(
              child: StreamBuilder(
                stream: FirebaseDatabase.instance.reference().child("chat_messages/${chatController.roomSelected.value}").orderByChild('time').onValue,
                builder: (context,snapshot){
                  List<ChatMessages> chatMessages = [];
                  if(!snapshot.hasData || snapshot.hasError || snapshot.data.snapshot.value == null){
                    return Center(
                      child: AppText(
                        text:"No Messages!!!",
                      ),
                    );
                  }
                  snapshot.data.snapshot.value.forEach((k,v){
                    chatMessages.add(ChatMessages.fromJson(v));
                  });
                  chatMessages.sort((a,b)=> b.time.compareTo(a.time));
                  return ListView.builder(
                    reverse: true,
                    itemCount: chatMessages.length,
                    itemBuilder: (context, index){
                      return SingleChildScrollView(
                        child: Container(
                          padding: EdgeInsets.only(left: 14,right: 14,top: 10,bottom: 10),
                          child: Align(
                            alignment: (chatMessages[index].idUser != userController.user.value.id?Alignment.topLeft:Alignment.topRight),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                chatMessages[index].idUser != userController.user.value.id?CircleAvatar(
                                  backgroundImage: NetworkImage(chatMessages[index].imageSender),
                                  maxRadius: 15,
                                ):SizedBox(),
                                Dimens.width10,
                                Container(
                                  constraints: BoxConstraints(maxWidth: getScreenWidth(context)/1.5),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: (chatMessages[index].idUser != userController.user.value.id?Colors.grey.shade200:Colors.blue[200]),
                                  ),
                                  padding: EdgeInsets.all(12),
                                  child: Text(chatMessages[index].content, style: TextStyle(fontSize: 15),),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                } ,
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 10,bottom: 10,top: 10),
              height: 60,
              width: double.infinity,
              color: Colors.white,
              child: Row(
                children: <Widget>[
                  GestureDetector(
                    onTap: (){},
                    child: Container(
                      height: 30,
                      width: 30,
                      decoration: BoxDecoration(
                        color: Colors.lightBlue,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Icon(Icons.add, color: Colors.white, size: 20, ),
                    ),
                  ),
                  SizedBox(width: 15,),
                  Expanded(
                    child: TextField(
                      controller: _content,
                      decoration: InputDecoration(
                          hintText: "Write message...",
                          hintStyle: TextStyle(color: Colors.black54),
                          border: InputBorder.none
                      ),
                    ),
                  ),
                  SizedBox(width: 15,),
                  FloatingActionButton(
                    onPressed: () async{
                      if(_content.text.isNotEmpty){
                        await chatController.addChatMessages(userController, _content);
                        _content.text = '';
                      }
                    },
                    child: Icon(Icons.send,color: Colors.white,size: 18,),
                    backgroundColor: Colors.blue,
                    elevation: 0,
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    });
  }
}