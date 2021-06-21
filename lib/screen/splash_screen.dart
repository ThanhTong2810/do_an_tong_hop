import 'dart:async';
import 'dart:io';
import 'package:do_an_tong_hop/controller/user_controller.dart';
import 'package:do_an_tong_hop/screen/main_screen_bottom_nav/bottom_nav_page.dart';
import 'package:do_an_tong_hop/screen/sign_in_page/sign_in_page.dart';
import 'package:do_an_tong_hop/theme/colors.dart';
import 'package:do_an_tong_hop/theme/images_app.dart';
import 'package:do_an_tong_hop/utils/utils.dart';
import 'package:do_an_tong_hop/widgets/fade_container.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final UserController userController = Get.find();
  Timer timer;

  ///~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~///
  ///           OVERRIDE METHODS           ///
  ///~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~///
  @override
  void initState() {
    super.initState();
    onWidgetBuildDone(onBuildDone);
  }


  @override
  void dispose() {
    if (timer != null) {
      timer.cancel();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final logoSize = getScreenWidth(context) / 2;
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Center(
        child: FadeContainer(
          child: Image.asset(
            ImagesApp.logo,
            width: logoSize,
            height: logoSize,
          ),
        ),
      ),
    );
  }

  ///~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~///
  ///           BUILD METHODS              ///
  ///~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~///

  ///~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~///
  ///             OTHER METHODS            ///
  ///~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~///
  onBuildDone() async {
    /// Delay 3 seconds, then navigate to Login screen
    timer = Timer.periodic(Duration(seconds: 2), (timer) async {
      await loadUserData();
    });
  }

  loadUserData() async{
    final openBox = await Hive.openBox('USER');
    if(openBox.get('email') != null && openBox.get('password') != null){
      await userController.signIn(openBox.get('email'), openBox.get('password'));
      if(userController.user.value!=null){
        userController.errorText.value = '';
        await Get.off(()=>BottomNavPage());
        await userController.getSuggestedAccount(userController.user.value.id);
      }else{
        await Get.to(()=>SignInPage());
      }
    }else{
      await Get.to(()=>SignInPage());
    }
  }
}
