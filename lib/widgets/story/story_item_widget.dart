import 'package:do_an_tong_hop/screen/story/story_page.dart';
import 'package:flutter/material.dart';
import 'dart:developer' as developer;

class StoryItemWidget extends StatefulWidget {
  @override
  _StoryItemWidgetState createState() => _StoryItemWidgetState();
}

class _StoryItemWidgetState extends State<StoryItemWidget> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: FittedBox(
        child: Container(
          width: 80,
          height: 96,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                width: 72,
                child: AspectRatio(
                  aspectRatio: 1,
                  child: ClipOval(
                    child: Stack(
                      children: <Widget>[
                        Container(
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [Colors.red[500], Colors.pink],
                              )
                          ),
                          padding: EdgeInsets.all(2),
                          child: CircleAvatar(
                              radius: 34,
                              backgroundImage : AssetImage('lib/res/images/logo.jpg')
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 4),
                child: Text('dangngocduc', style: Theme.of(context).textTheme.caption?.copyWith(
                    color: Theme.of(context).colorScheme.onBackground
                ),),
              )
            ],
          ),
        ),
        fit: BoxFit.scaleDown,
      ),
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => StoryPage(),
        ));
      },
    );
  }
}
