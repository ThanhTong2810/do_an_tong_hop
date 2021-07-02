import 'package:do_an_tong_hop/controller/chat_controller.dart';
import 'package:do_an_tong_hop/controller/posts_controller.dart';
import 'package:do_an_tong_hop/controller/user_controller.dart';
import 'package:do_an_tong_hop/utils/utils.dart';
import 'package:do_an_tong_hop/widgets/feed/feed_widget.dart';
import 'package:do_an_tong_hop/widgets/story/home_story_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'header_widget.dart';

class HomePage extends StatefulWidget {

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PostsController postsController = Get.find();
  final UserController userController = Get.find();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HeaderWidget(),
      body: RefreshIndicator(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                // HomeStoryWidget(),
                FeedWidget(),
              ],
            ),
          ),
          onRefresh: () async {
            await postsController.getPosts(userController);
          }),
    );
  }
}
