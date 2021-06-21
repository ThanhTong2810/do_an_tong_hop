import 'package:do_an_tong_hop/theme/icons_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class FooterWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: <Widget>[
          IconButton(icon: SvgPicture.asset(IconsApp.icFavorite,
            color: Theme.of(context).colorScheme.onPrimary,), onPressed: (){}),
          IconButton(
              icon: SvgPicture.asset(
                IconsApp.icComment,
                color: Theme.of(context).colorScheme.onPrimary,),
              onPressed: (){}),
          IconButton(
              icon: SvgPicture.asset(
                IconsApp.icSend,
                color: Theme.of(context).colorScheme.onPrimary,),
              onPressed: (){}),
          Expanded(child: Align(
            alignment: Alignment.bottomRight,
            child: IconButton(icon: Icon(Icons.bookmark_border), onPressed: (){}),
          ))
        ],
      ),
    );
  }
}
