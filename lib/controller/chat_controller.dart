import 'package:do_an_tong_hop/controller/user_controller.dart';
import 'package:do_an_tong_hop/models/user/user.dart';
import 'package:do_an_tong_hop/screen/chats/message_screen.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ChatController extends GetxController{
  RxMap<dynamic, dynamic> listRoomContainId = RxMap<dynamic, dynamic>({});
  RxList<dynamic> listGroupChat = RxList<dynamic>([]);
  Rx<String> roomSelected = Rx<String>(null);
  RxList<bool> listCheck = RxList<bool>([]);
  RxList<UserFollow> listCheckCreateGroup = RxList<UserFollow>([]);

  getAllRoomContainMyId(String myId) async{
   DataSnapshot db =await  FirebaseDatabase.instance.reference().child("chat_info").orderByChild('containId/$myId/id').equalTo(myId).once();
   Map<dynamic, dynamic> data = db.value;
   if(data != null){
     listRoomContainId.assignAll(data);
     listGroupChat.assignAll(listRoomContainId.values.where((element) => element['containId'].length>2).toList());
   }else{
     listRoomContainId.clear();
     listGroupChat.clear();
   }
  }

  createNewRoomChat(UserFollow user, UserController userController) async{
    roomSelected.value = null;
    String idRoom = FirebaseDatabase.instance.reference().child("chat_info").push().key;
    Map containId ={};
    containId.addAll({
      "${user.id}":{
        "id":user.idAccount,
        "imageSrc": user.imageSrc,
        "name": user.name,
        "username":user.username
      },
    });
    containId.addAll({
      "${userController.user.value.id}":{
        "id":userController.user.value.id,
        "imageSrc": userController.user.value.imgSrc,
        "name": userController.user.value.name,
        "username":userController.user.value.userName
      },
    });
    Map dataChatInfo = {
      "imageSrc": "",
      "name": "",
      "idRoom": idRoom,
      "containId": containId,
    };
    listRoomContainId.addAll(dataChatInfo);
    roomSelected.value = idRoom;
    await FirebaseDatabase.instance.reference().child("chat_info/$idRoom").set(dataChatInfo);
    await getAllRoomContainMyId(userController.user.value.id);
  }

  createNewGroupChat(List<UserFollow> userGetById, UserController userController) async{
    roomSelected.value = null;
    String idRoom = FirebaseDatabase.instance.reference().child("chat_info").push().key;
    Map containId ={};
    userGetById.forEach((user) {
      containId.addAll({
        "${user.id}":{
          "id":user.id,
          "image": user.imageSrc,
          "name": user.name,
          "username":user.username
        },
      });
    });
    containId.addAll({
      "${userController.user.value.id}":{
        "id":userController.user.value.id,
        "image": userController.user.value.imgSrc,
        "name": userController.user.value.name,
        "username":userController.user.value.userName
      },
    });
    Map dataChatInfo = {
      "imageSrc": "https://images.vexels.com/media/users/3/132363/isolated/preview/a31cc22b4b43c6dacdf885948f886f7c-support-blue-circle-icon-by-vexels.png",
      "name": "Duc And Friend",
      "idRoom": idRoom,
      "containId": containId,
    };
    listRoomContainId.addAll(dataChatInfo);
    roomSelected.value = idRoom;
    await FirebaseDatabase.instance.reference().child("chat_info/$idRoom").set(dataChatInfo);
    await getAllRoomContainMyId(userController.user.value.id);
  }

  addChatMessages(UserController userController, TextEditingController content) async{
    Map<String, dynamic> dataMessages = {
      "content":content.text,
      "idUser": userController.user.value.id,
      "name": userController.user.value.name,
      "imageSender":userController.user.value.imgSrc,
      "time": DateTime.now().millisecondsSinceEpoch,
      "username": userController.user.value.userName
    };

    await FirebaseDatabase.instance.reference().child("chat_messages/${roomSelected.value}").push().set(dataMessages);
  }

  // Stream getChatMessages(String roomSelected){
  //   return FirebaseDatabase.instance.reference().child("chat_messages/-MccpSBqlEVHFnWLXb-E");
  // }
}