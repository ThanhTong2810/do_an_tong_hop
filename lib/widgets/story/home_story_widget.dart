import 'package:do_an_tong_hop/widgets/story/story_item_widget.dart';
import 'package:flutter/material.dart';
import 'dart:developer' as developer;

class HomeStoryWidget extends StatefulWidget {
  @override
  _HomeStoryWidgetState createState() => _HomeStoryWidgetState();
}

class _HomeStoryWidgetState extends State<HomeStoryWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 96,
      color: Theme.of(context).cardColor,
      child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) => StoryItemWidget(),
          separatorBuilder: (context, index) => SizedBox(width: 8, height: 0,),
          itemCount: 1,
          padding: EdgeInsets.symmetric(
            vertical: 8,
            horizontal: 16
          ),
        physics: BouncingScrollPhysics(),
      )
    );
  }
}
