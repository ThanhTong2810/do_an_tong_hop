import 'package:flutter/material.dart';

import 'activity_item_widget.dart';

class ActivityPage extends StatefulWidget {
  @override
  _ActivityPageState createState() => _ActivityPageState();
}

class _ActivityPageState extends State<ActivityPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Activity'),
        centerTitle: false,
      ),
      body: RefreshIndicator(
          child: ListView.builder(
            physics: BouncingScrollPhysics(),
            itemBuilder: (context, index) => ActivityItemWidget(),
            itemCount: 5,
          ),
          onRefresh: () async {}),
    );
  }
}
