import 'package:async/async.dart';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:do_an_tong_hop/controller/user_controller.dart';
import 'package:do_an_tong_hop/helpers/cloudinary_helper.dart';
import 'package:do_an_tong_hop/screen/sign_up_page/sign_up_page.dart';
import 'package:do_an_tong_hop/theme/colors.dart';
import 'package:do_an_tong_hop/theme/dimens.dart';
import 'package:do_an_tong_hop/theme/icons_app.dart';
import 'package:do_an_tong_hop/screen/main_screen_bottom_nav/bottom_nav_page.dart';
import 'package:do_an_tong_hop/theme/images_app.dart';
import 'package:do_an_tong_hop/widgets/app_text.dart';
import 'package:do_an_tong_hop/widgets/loading_container.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final UserController userController =Get.find();

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final inputBorder =
    OutlineInputBorder(borderSide: Divider.createBorderSide(context));
    return Obx((){
      return LoadingContainer(
        child: Scaffold(
          body: SafeArea(
            child: SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 32),
                width: double.infinity,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Flexible(
                      child: Container(),
                      flex: 1,
                    ),
                    Image(
                      image: AssetImage(
                        ImagesApp.logoBanQuanLy,
                      ),
                    ),
                    Flexible(
                      child: Container(),
                      flex: 1,
                    ),
                    Text(
                      'Sign in and use more feature',
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                    SizedBox(
                      height: 64,
                    ),
                    TextFormField(
                      controller: email,
                      decoration: InputDecoration(
                        hintText: 'email or username',
                        border: inputBorder,
                        focusedBorder: inputBorder,
                        enabledBorder: inputBorder,
                        filled: true,
                        contentPadding: EdgeInsets.all(8),
                      ),
                    ),
                    SizedBox(
                      height: 24,
                    ),
                    TextFormField(
                      controller: password,
                      decoration: InputDecoration(
                          hintText: 'password',
                          border: inputBorder,
                          focusedBorder: inputBorder,
                          enabledBorder: inputBorder,
                          filled: true,
                          contentPadding: EdgeInsets.all(8)),
                      obscureText: true,
                    ),
                    userController.errorText.value.isEmpty?SizedBox(
                      height: 24,
                    ):Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.0),
                      child: AppText(
                        textAlign: TextAlign.center,
                        text: userController.errorText.value,
                        color: AppColors.red,
                        textSize: Dimens.errorTextSize,
                      ),
                    ),
                    InkWell(
                      child: Container(
                        child: Text(
                          'Sign in',
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1
                              ?.copyWith(color: Colors.white),
                        ),
                        width: double.infinity,
                        alignment: Alignment.center,
                        padding: EdgeInsets.symmetric(vertical: 12),
                        decoration: ShapeDecoration(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(Radius.circular(4)),
                            ),
                            gradient: LinearGradient(colors: [
                              Color(0xFF405de6),
                              Color(0xFF833ab4),
                              Color(0xFFe1306c),
                            ])),
                      ),
                      onTap: () async{
                        await userController.signIn(email.text, password.text);
                        if(userController.user.value !=null){
                          userController.errorText.value = '';
                          await Get.off(()=>BottomNavPage());
                        }
                      },
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Text(
                      'Forgot for login details? get help signing in',
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1
                          ?.copyWith(fontSize: 10),
                    ),
                    Flexible(
                      child: Container(),
                      flex: 2,
                    ),
                    GestureDetector(
                      onTap: (){
                        userController.errorText.value = '';
                        Get.offAll(()=>SignUpPage());
                      },
                      child: Container(
                        child: Text(
                          'Don\'t have an account? sign up',
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                        padding: EdgeInsets.symmetric(vertical: 8),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        isLoading: userController.isShowLoading.value,
        isShowIndicator: true,
      );
    });
  }
}
