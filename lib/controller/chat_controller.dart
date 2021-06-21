import 'package:do_an_tong_hop/controller/user_controller.dart';
import 'package:do_an_tong_hop/models/user/user_get_account_by_id.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';

class ChatController extends GetxController{
  RxMap<dynamic, dynamic> listRoomContainId = RxMap<dynamic, dynamic>({});
  Rx<String> roomSelected = Rx<String>(null);

  getAllRoomContainMyId(String myId) async{
   DataSnapshot db =await  FirebaseDatabase.instance.reference().child("chat_info").orderByChild('containId/$myId/id').equalTo(myId).once();
   Map<dynamic, dynamic> data = db.value;
   if(data != null){
     listRoomContainId.assignAll(data);
   }else{
     listRoomContainId.clear();
   }
  }

  createNewRoomChat(UserGetById userGetById, UserController userController) async{
    roomSelected.value = null;
    String idRoom = FirebaseDatabase.instance.reference().child("chat_info").push().key;
    Map containId ={};
    containId.addAll({
      "${userGetById.id}":{
        "id":userGetById.id,
        "image": userGetById.imgSrc,
        "name": userGetById.name,
        "username":userGetById.userName
      },
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
      "imageSrc": "",
      "name": "",
      "idRoom": idRoom,
      "containId": containId,
    };
    listRoomContainId.addAll(dataChatInfo);
    roomSelected.value = idRoom;
    await FirebaseDatabase.instance.reference().child("chat_info/$idRoom").set(dataChatInfo);
    FirebaseDatabase.instance.reference().child("chat_messages/$idRoom").push();
    await getAllRoomContainMyId(userController.user.value.id);
  }

  // Stream getChatMessages(String roomSelected){
  //   return FirebaseDatabase.instance.reference().child("chat_messages/-MccpSBqlEVHFnWLXb-E");
  // }
}