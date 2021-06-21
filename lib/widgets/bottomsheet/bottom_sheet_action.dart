import 'package:flutter/cupertino.dart';

class BottomSheetAction {

  IconData iconData;

  String title;

  int id;

  Function onTap;

  BottomSheetAction({
     this.iconData,
     this.title,
     this.id,
     this.onTap
  });
}