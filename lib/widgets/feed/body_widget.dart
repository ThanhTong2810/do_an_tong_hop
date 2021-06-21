import 'package:do_an_tong_hop/theme/icons_app.dart';
import 'package:do_an_tong_hop/theme/images_app.dart';
import 'package:flutter/material.dart';
import 'dart:developer' as developer;

class BodyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: Image.asset(
        ImagesApp.searchDemo,
        fit: BoxFit.cover,
      ),
    );
  }
}
