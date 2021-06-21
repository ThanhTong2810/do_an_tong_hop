import 'package:do_an_tong_hop/widgets/bottomsheet/bottom_sheet_action.dart';
import 'package:flutter/material.dart';
import 'package:do_an_tong_hop/widgets/app_context.dart';


class BottomSheetActionWidget extends StatelessWidget {

  final BottomSheetAction action;

  BottomSheetActionWidget(this.action);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      highlightColor: Colors.blue.withOpacity(0.1),
      splashColor: Colors.blue.withOpacity(0.3),
      child: Container(
        padding: EdgeInsets.symmetric(
            vertical: 12,
            horizontal: 16
        ),
        child: Row(
          children: [
            Icon(action.iconData),
            SizedBox(width: 16,),
            Text(action.title, style: context.textTheme.subtitle1,)
          ],
        ),
      ),
      onTap: () {
        Navigator.pop(context, action);
      },
    );
  }
}
