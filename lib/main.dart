import 'dart:io';
import 'package:do_an_tong_hop/app/app.dart';
import 'package:do_an_tong_hop/helpers/notification_helper.dart';
import 'package:do_an_tong_hop/theme/colors.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await NotificationHelper.requestPermission();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: AppColors.black, statusBarBrightness: Brightness.light));
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]).then((_) async {
    Directory directory= await getTemporaryDirectory();
    Hive.init('${directory.path}/DoAnCaches');
    print('path for hive caches---> ${directory.path}/DoAnCaches');
    runApp(DoAnApp());
  });
}
