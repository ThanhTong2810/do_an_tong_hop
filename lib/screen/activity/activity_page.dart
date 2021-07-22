import 'package:do_an_tong_hop/controller/user_controller.dart';
import 'package:do_an_tong_hop/models/notify/notify_model.dart';
import 'package:do_an_tong_hop/theme/colors.dart';
import 'package:do_an_tong_hop/theme/images_app.dart';
import 'package:do_an_tong_hop/utils/utils.dart';
import 'package:do_an_tong_hop/widgets/app_text.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'activity_item_widget.dart';

class ActivityPage extends StatefulWidget {
  @override
  _ActivityPageState createState() => _ActivityPageState();
}

class _ActivityPageState extends State<ActivityPage> {
  final UserController userController = Get.find();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Activity'),
        centerTitle: false,
      ),
      body: userController.user.value.id != null ? Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Expanded(
            child: StreamBuilder(
              stream: FirebaseDatabase.instance.reference().child("social_network/notifications").orderByChild('key').equalTo(userController.user.value.id).onValue,
              builder: (context,snapshot){
                List<Notify> notifications = [];
                if(!snapshot.hasData || snapshot.hasError || snapshot.data.snapshot.value == null){
                  return Center(
                    child: AppText(
                      text:"No Messages!!!",
                      color: AppColors.black,
                    ),
                  );
                }
                snapshot.data.snapshot.value.forEach((k,v){
                  if(v['notification']!=null){
                    v['notification'].forEach((k,v){
                      print(v);
                      notifications.add(Notify.fromJson(v));
                    });
                  }
                });
                notifications.sort((a,b)=> a.timestamp.compareTo(b.timestamp));
                return ListView.builder(
                  itemCount: notifications.length,
                  itemBuilder: (context, index){
                    return SingleChildScrollView(
                      child: Container(
                        padding: EdgeInsets.only(left: 14,right: 14,top: 10,bottom: 10),
                        child: Row(
                          children: <Widget>[
                            CircleAvatar(
                                maxRadius: 16,
                                backgroundImage : NetworkImage(
                                  userController.user.value.imgSrc
                                ),
                            ),
                            Expanded(child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 8
                                ),
                                child: RichText(text: TextSpan(
                                    children: [
                                      TextSpan(text: notifications[index].username,
                                          style: Theme.of(context).textTheme.subtitle1?.copyWith(
                                              fontWeight: FontWeight.bold
                                          )),
                                      TextSpan(text: ' ${notifications[index].message}\n', style: Theme.of(context).textTheme.subtitle1),
                                      TextSpan(text: ' 2h', style: Theme.of(context).textTheme.subtitle1?.copyWith(
                                          color: Theme.of(context).colorScheme.onBackground.withOpacity(0.56)
                                      ))
                                    ]
                                ))
                            )),
                            Container(
                              width: 56,
                              height: 56,
                              decoration: ShapeDecoration(
                                  image: DecorationImage(image: notifications[index].imageSrc.isEmpty?AssetImage(ImagesApp.logo):NetworkImage(notifications[index].imageSrc), fit: BoxFit.cover),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(Radius.circular(4))
                                  )
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                );
              } ,
            ),
          ),
        ],
      ) : SizedBox(),
    );
  }
}
