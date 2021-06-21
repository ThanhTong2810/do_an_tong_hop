import 'package:do_an_tong_hop/theme/colors.dart';
import 'package:do_an_tong_hop/theme/dimens.dart';
import 'package:do_an_tong_hop/widgets/app_text.dart';
import 'package:flutter/material.dart';



class AndroidDialog extends StatefulWidget {
  final String title;
  final String content;
  final Function cancel;
  final Function confirm;

  const AndroidDialog(
      {Key key, this.title, this.content, this.cancel, this.confirm})
      : super(key: key);

  @override
  _AndroidDialogState createState() => _AndroidDialogState();
}

class _AndroidDialogState extends State<AndroidDialog> {
  bool enable;

  @override
  void initState() {
    enable = true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: AppText(
        text: widget.title ?? '',
        color: AppColors.black,
      ),
      content: AppText(
        text: widget.content ?? '',
        color: AppColors.black,
        textSize: Dimens.errorTextSize,
      ),
      actions: <Widget>[
        widget.cancel != null
            ? TextButton(
                onPressed: (){
                  widget.cancel();
                },
                child: AppText(
                  text: 'cancel',
                  color: AppColors.red,
                ))
            : SizedBox(),
        widget.confirm != null
            ? TextButton(
                onPressed: () {
                  if (enable) {
                    widget.confirm();
                  }
                  setState(() {
                    enable = false;
                  });
                },
                child: AppText(
                  text: 'confirm',
                  color: AppColors.clickableText,
                ))
            : SizedBox()
      ],
    );
  }
}
