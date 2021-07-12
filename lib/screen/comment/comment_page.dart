import 'package:do_an_tong_hop/controller/posts_controller.dart';
import 'package:do_an_tong_hop/controller/user_controller.dart';
import 'package:do_an_tong_hop/models/posts_model/comment_model.dart';
import 'package:do_an_tong_hop/models/user/user.dart';
import 'package:do_an_tong_hop/theme/colors.dart';
import 'package:do_an_tong_hop/theme/dimens.dart';
import 'package:do_an_tong_hop/theme/icons_app.dart';
import 'package:do_an_tong_hop/theme/images_app.dart';
import 'package:do_an_tong_hop/utils/utils.dart';
import 'package:do_an_tong_hop/widgets/app_text.dart';
import 'package:do_an_tong_hop/widgets/loading_container.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'comment_widget.dart';

class CommentPage extends StatefulWidget {
  final String idPost;
  final String idOwner;

  const CommentPage({Key key, this.idPost, this.idOwner}) : super(key: key);
  @override
  _CommentPageState createState() => _CommentPageState();
}

class _CommentPageState extends State<CommentPage> {
  final UserController userController = Get.find();
  final PostsController postsController = Get.find();

  FocusNode focusNode = FocusNode();
  TextEditingController _comment = TextEditingController();

  @override
  void initState() {
    postsController.idComment.value = null;
    postsController.idOwnerComment.value = null;
    super.initState();
  }

  @override
  void dispose() {
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Obx((){
      return LoadingContainer(
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          appBar: AppBar(
            leading: IconButton(icon: Icon(Icons.arrow_back_ios_sharp), onPressed: (){
              Get.back();
            },),
            title: Text('Comments'),
            actions: <Widget>[
              IconButton(icon: Icon(Icons.more_vert), onPressed: (){})
            ],
          ),
          body: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Expanded(
                child: StreamBuilder(
                  stream: FirebaseDatabase.instance.reference().child("social_network/posts/${widget.idPost}/comments").onValue,
                  builder: (context,snapshot){
                    List<CommentModel> comments = [];
                    if(!snapshot.hasData || snapshot.hasError || snapshot.data.snapshot.value == null){
                      return Center(
                        child: AppText(
                          text:"No Comments!!!",
                          color: AppColors.black,
                        ),
                      );
                    }
                    snapshot.data.snapshot.value.forEach((k,v){
                      comments.add(CommentModel.fromJson(v, k));
                    });
                    comments.sort((a,b)=>a.timeStamp.compareTo(b.timeStamp));
                    return ListView(
                      reverse: true,
                      children: comments.map((comment) {
                        return FutureBuilder(
                          future: userController.getAccountById(comment.idAccount),
                          builder: (context, snapshot){
                            if (!snapshot.hasData) {
                              return SizedBox();
                            } else {
                              User user = snapshot.data;
                              List<ReplyModel> replies = [];
                              comment.reply.forEach((key, value) {
                                replies.add(ReplyModel.fromJson(value, key));
                              });
                              return Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: 16,
                                    horizontal: 16
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Row(
                                      children: [
                                        CircleAvatar(
                                          backgroundImage: NetworkImage(user.imgSrc),
                                          radius: 18,
                                        ),
                                        Expanded(child: Container(
                                          child: Padding(
                                            padding: EdgeInsets.only(left: 16),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                RichText(
                                                  text: TextSpan(
                                                      children: [
                                                        TextSpan(text: user.userName, style: Theme.of(context).textTheme.bodyText2),
                                                        TextSpan(text: '   ${comment.content}', style: Theme.of(context).textTheme.bodyText1),
                                                      ]
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(top: 4),
                                                  child: DefaultTextStyle(
                                                      style: Theme.of(context).textTheme.caption.copyWith(
                                                          fontSize: 12,
                                                          fontWeight: FontWeight.w400
                                                      ),
                                                      child: Row(
                                                        children: [
                                                          Text('5d'),
                                                          SizedBox(width: 24,),
                                                          Text('3 likes'),
                                                          SizedBox(width: 24,),
                                                          GestureDetector(
                                                            child: Text('Reply'),
                                                            onTap: (){
                                                              focusNode.requestFocus();
                                                              postsController.isReply.value = true;
                                                              postsController.idComment.value = comment.id;
                                                              postsController.idOwnerComment.value = comment.idAccount;
                                                            },
                                                          ),
                                                        ],
                                                      )),
                                                )
                                              ],
                                            ),
                                          ),
                                        )),
                                        Container(
                                          padding: EdgeInsets.all(8),
                                          child: Icon(Icons.favorite, size: 16, color: AppColors.red,),
                                        )
                                      ],
                                    ),
                                    Dimens.height10,
                                    comment.reply.isEmpty?SizedBox():Padding(
                                      padding: EdgeInsets.only(left: getScreenWidth(context)/8),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: replies.map((reply){
                                          return FutureBuilder(
                                            future: userController.getAccountById(reply.idAccount),
                                            builder: (context, snapshot){
                                              if (!snapshot.hasData) {
                                                return SizedBox();
                                              } else {
                                                User userReply = snapshot.data;
                                                return Padding(
                                                  padding:  EdgeInsets.only(bottom: 10.0),
                                                  child: Row(
                                                    children: [
                                                      CircleAvatar(
                                                        backgroundImage: NetworkImage(userReply.imgSrc),
                                                        radius: 18,
                                                      ),
                                                      Expanded(child: Container(
                                                        child: Padding(
                                                          padding: EdgeInsets.only(left: 16),
                                                          child: Column(
                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                            mainAxisAlignment: MainAxisAlignment.center,
                                                            children: [
                                                              RichText(
                                                                text: TextSpan(
                                                                    children: [
                                                                      TextSpan(text: userReply.userName, style: Theme.of(context).textTheme.bodyText2),
                                                                      TextSpan(text: '   ${reply.content}', style: Theme.of(context).textTheme.bodyText1),
                                                                    ]
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      )),
                                                      Container(
                                                        padding: EdgeInsets.all(8),
                                                        child: Icon(Icons.favorite_border, size: 16,),
                                                      )
                                                    ],
                                                  ),
                                                );
                                              }
                                            },
                                          );
                                        }).toList(),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }
                          },
                        );
                      }).toList(),
                    );
                  } ,
                ),
              ),
            ],
          ),
          bottomNavigationBar: Material(
            type: MaterialType.canvas,
            child: SafeArea(
              child: Container(
                height: kToolbarHeight,
                margin: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom
                ),
                padding: EdgeInsets.only(
                    left: 16,
                    right: 8
                ),
                child: Row(
                  children: [
                    CircleAvatar(
                      backgroundImage: NetworkImage(
                          userController.user.value.imgSrc
                      ),
                      radius: 18,
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(left: 16, right: 8),
                        child: TextField(
                          focusNode: focusNode,
                          controller: _comment,
                          decoration: InputDecoration(
                              hintText: postsController.isReply.value == true?'Reply':'Comment',
                              border: InputBorder.none
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () async{
                        if(_comment.text.isNotEmpty){
                          if(postsController.isReply.value == true){
                            postsController.isShowLoading.value = true;
                            await postsController.addReplyComment(userController, postsController.idOwnerComment.value, widget.idPost, postsController.idComment.value, _comment.text, []);
                            postsController.idComment.value = null;
                            postsController.idOwnerComment.value = null;
                            postsController.isReply.value = false;
                            _comment.text='';
                            postsController.isShowLoading.value = false;
                          }else{
                            postsController.isShowLoading.value = true;
                            await postsController.addComment(userController: userController, idPost: widget.idPost, idOwner: widget.idOwner, mentionList: [], contentHtml: _comment.text);
                            postsController.isShowLoading.value = false;
                            _comment.text='';
                          }
                        }
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            vertical: 8,
                            horizontal: 8
                        ),
                        child: Text('Post', style: Theme.of(context).primaryTextTheme.bodyText2?.copyWith(
                            color: Colors.blue
                        ),),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
        isLoading: postsController.isShowLoading.value,
        isShowIndicator: true
      );
    });
  }
}
