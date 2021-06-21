import 'package:do_an_tong_hop/theme/icons_app.dart';
import 'package:do_an_tong_hop/theme/images_app.dart';
import 'package:flutter/material.dart';

import 'comment_widget.dart';

class CommentPage extends StatefulWidget {
  @override
  _CommentPageState createState() => _CommentPageState();
}

class _CommentPageState extends State<CommentPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text('Comments'),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.more_vert), onPressed: (){})
        ],
      ),
      body: Column(
        children: <Widget>[
          CommentWidget(),
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
                  backgroundImage: AssetImage(
                    ImagesApp.logo
                  ),
                  radius: 18,
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(left: 16, right: 8),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Comment as Duong Thanh Tong...',
                        border: InputBorder.none
                      ),
                    ),
                  ),
                ),
                InkWell(
                    onTap: (){},
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
  }
}
