import 'package:do_an_tong_hop/controller/posts_controller.dart';
import 'package:do_an_tong_hop/controller/user_controller.dart';
import 'package:do_an_tong_hop/models/posts_model/comment_model.dart';
import 'package:do_an_tong_hop/theme/icons_app.dart';
import 'package:do_an_tong_hop/theme/images_app.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'comment_widget.dart';

class CommentPage extends StatefulWidget {
  final String idPost;
  final String idOwner;
  final List<CommentModel> comments;

  const CommentPage({Key key, this.idPost, this.idOwner, this.comments}) : super(key: key);
  @override
  _CommentPageState createState() => _CommentPageState();
}

class _CommentPageState extends State<CommentPage> {
  final UserController userController = Get.find();
  final PostsController postsController = Get.find();

  TextEditingController _comment = TextEditingController();

  @override
  void initState() {
    widget.comments.sort((a,b)=>b.timeStamp.compareTo(a.timeStamp));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx((){
      return Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          title: Text('Comments'),
          actions: <Widget>[
            IconButton(icon: Icon(Icons.more_vert), onPressed: (){})
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: widget.comments.map((comment){
              return Container(
                padding: EdgeInsets.symmetric(
                    vertical: 16,
                    horizontal: 16
                ),
                child: Row(
                  children: [
                    CircleAvatar(
                      backgroundImage: AssetImage(ImagesApp.logo),
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
                                    TextSpan(text: comment.idAccount, style: Theme.of(context).textTheme.bodyText2),
                                    TextSpan(text: comment.content, style: Theme.of(context).textTheme.bodyText1),
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
                                      Text('Reply')
                                    ],
                                  )),
                            )
                          ],
                        ),
                      ),
                    )),
                    Container(
                      padding: EdgeInsets.all(8),
                      child: Icon(Icons.favorite, size: 16,),
                    )
                  ],
                ),
              );
            }).toList(),
          ),
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
                    backgroundImage: AssetImage(
                        ImagesApp.logo
                    ),
                    radius: 18,
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(left: 16, right: 8),
                      child: TextField(
                        controller: _comment,
                        decoration: InputDecoration(
                            hintText: 'Comment',
                            border: InputBorder.none
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () async{
                      if(_comment.text.isNotEmpty){
                        await postsController.addComment(userController: userController, idPost: widget.idPost, idOwner: widget.idOwner, mentionList: [], contentHtml: _comment.text);
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
      );
    });
  }
}
