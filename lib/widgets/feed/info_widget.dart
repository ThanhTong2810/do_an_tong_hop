import 'package:do_an_tong_hop/screen/comment/comment_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InfoWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final onOpenComment = () {

    };

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 16
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          DefaultTextStyle(
              style: Theme.of(context).textTheme.subtitle2.copyWith(
                fontWeight: FontWeight.w800
              ),
              child: Text('1,102 likes', style: Theme.of(context).textTheme.bodyText2,)),
          Container(
            width: double.infinity,
            padding: EdgeInsets.only(
              top: 8,
            ),
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(text: 'Duong Thanh Tong', style: Theme.of(context).textTheme.bodyText2),
                  TextSpan(text: '  how to rear mount pec dec instal slideshow. Note: the hite-rite v1 dropper post makes for a great linkage point for extra strap when overloading 🚚 :: fabs chest pre order june 1st :::..',
                      style: Theme.of(context).textTheme.bodyText1?.copyWith(
                        fontWeight: FontWeight.w400
                      )),
                ]
              ),
            ),
          ),
          InkWell(
            child: Container(
              child: Text(
                'View all 4 comment',
                style: Theme.of(context).textTheme.caption,
              ),
              padding: EdgeInsets.symmetric(
                vertical: 4
              ),
            ),
            onTap: onOpenComment,
          )
        ],
      ),
    );
  }
}
