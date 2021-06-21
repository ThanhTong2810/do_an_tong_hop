import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:developer' as developer;

import 'package:google_fonts/google_fonts.dart';

class CameraPage extends StatefulWidget {
  @override
  _CameraPageState createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: Icon(Icons.close), onPressed: (){
          Get.back();
        },),
      ),
      body: Container(
        alignment: Alignment.center,
        child: Text(
          'Story Preview',
          style: GoogleFonts.pacificoTextTheme(Theme.of(context).textTheme).headline5,
        ),
      ),
    );
  }
}
