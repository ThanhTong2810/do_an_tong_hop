import 'package:flutter/material.dart';

class WriteCaptionWidget extends StatefulWidget {
  @override
  _WriteCaptionWidgetState createState() => _WriteCaptionWidgetState();
}

class _WriteCaptionWidgetState extends State<WriteCaptionWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: 12,
        horizontal: 16
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundImage: AssetImage('lib/res/images/logo.jpg'),
          ),
          Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: TextField(
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Write a caption',
                    hintStyle: Theme.of(context).textTheme.bodyText1?.copyWith(
                      color: Theme.of(context).hintColor
                    )
                  ),
                ),
              )
          ),
        ],
      ),
    );
  }
}
