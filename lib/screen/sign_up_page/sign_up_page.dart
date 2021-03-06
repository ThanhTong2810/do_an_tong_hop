import 'package:async/async.dart';
import 'package:do_an_tong_hop/controller/user_controller.dart';
import 'package:do_an_tong_hop/screen/sign_in_page/sign_in_page.dart';
import 'package:do_an_tong_hop/theme/colors.dart';
import 'package:do_an_tong_hop/theme/dimens.dart';
import 'package:do_an_tong_hop/theme/icons_app.dart';
import 'package:do_an_tong_hop/screen/main_screen_bottom_nav/bottom_nav_page.dart';
import 'package:do_an_tong_hop/theme/images_app.dart';
import 'package:do_an_tong_hop/utils/utils.dart';
import 'package:do_an_tong_hop/widgets/app_text.dart';
import 'package:do_an_tong_hop/widgets/loading_container.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final UserController userController= Get.find();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController userName = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController description = TextEditingController();

  @override
  void initState() {
    userController.errorText.value = '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final inputBorder =
    OutlineInputBorder(borderSide: Divider.createBorderSide(context));
    return Obx((){
      return LoadingContainer(
        child: Scaffold(
          body: SafeArea(
            child: Container(
              height: getScreenHeight(context),
              padding: EdgeInsets.symmetric(horizontal: 32),
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Image(
                        image: AssetImage(
                          ImagesApp.logoBanQuanLy,
                        ),
                        height: 32
                      ),
                      Text(
                        'Sign up and use more feature',
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                      SizedBox(
                        height: 64,
                      ),
                      TextFormField(
                        controller: email,
                        decoration: InputDecoration(
                          hintText: 'email',
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
                      SizedBox(
                        height: 24,
                      ),
                      TextFormField(
                        controller: userName,
                        decoration: InputDecoration(
                            hintText: 'username',
                            border: inputBorder,
                            focusedBorder: inputBorder,
                            enabledBorder: inputBorder,
                            filled: true,
                            contentPadding: EdgeInsets.all(8)),
                      ),
                      SizedBox(
                        height: 24,
                      ),
                      TextFormField(
                        controller: name,
                        decoration: InputDecoration(
                            hintText: 'name',
                            border: inputBorder,
                            focusedBorder: inputBorder,
                            enabledBorder: inputBorder,
                            filled: true,
                            contentPadding: EdgeInsets.all(8)),
                      ),
                      SizedBox(
                        height: 24,
                      ),
                      TextFormField(
                        controller: description,
                        decoration: InputDecoration(
                            hintText: 'description',
                            border: inputBorder,
                            focusedBorder: inputBorder,
                            enabledBorder: inputBorder,
                            filled: true,
                            contentPadding: EdgeInsets.all(8)),
                      ),
                      SizedBox(
                        height: 24,
                        child: AppText(
                          text: userController.errorText.value.isEmpty?'':userController.errorText.value,
                          color: AppColors.red,
                          textSize: Dimens.errorTextSize,
                        ),
                      ),
                      InkWell(
                        child: Container(
                          child: Text(
                            'Sign up',
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
                          if(email.text.isNotEmpty && password.text.isNotEmpty && userName.text.isNotEmpty && name.text.isNotEmpty && description.text.isNotEmpty){
                            await userController.signUp(email.text, password.text, userName.text, name.text, description.text);
                            Get.off(()=>SignInPage());
                            userController.errorText.value = '';
                          }else{
                            userController.errorText.value = 'Please Input Information';
                          }
                        },
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      GestureDetector(
                        onTap: (){
                          Get.offAll(()=>SignInPage());
                        },
                        child: Container(
                          child: Text(
                            'Already have an account? sign in',
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
        ),
        isLoading: userController.isShowLoading.value,
        isShowIndicator: true
      );
    });
  }
}
