import 'dart:io';

import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:do_an_tong_hop/api/api_response.dart';
import 'package:do_an_tong_hop/api/app_api/api_delete_unfollow_account.dart';
import 'package:do_an_tong_hop/api/app_api/api_get_account_by_id_or_username.dart';
import 'package:do_an_tong_hop/api/app_api/api_get_suggested_account_by_id.dart';
import 'package:do_an_tong_hop/api/app_api/api_post_follow_account.dart';
import 'package:do_an_tong_hop/api/app_api/api_post_sign_in.dart';
import 'package:do_an_tong_hop/api/app_api/api_post_sign_up.dart';
import 'package:do_an_tong_hop/api/app_api/api_put_update_avatar.dart';
import 'package:do_an_tong_hop/helpers/cloudinary_helper.dart';
import 'package:do_an_tong_hop/models/user/user.dart';
import 'package:do_an_tong_hop/models/user/user_get_account_by_id.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';

class UserController extends GetxController {
  Rx<User> user = Rx<User>(null);

  Rx<String> errorText = Rx<String>('');

  Rx<bool> isShowLoading = Rx<bool>(false);

  ImagePicker imagePicker = ImagePicker();

  RxList<User> listSuggestedAccount = RxList<User>([]);

  RxList<UserGetById> listFollowers = RxList<UserGetById>([]);
  RxList<UserGetById> listFollowing = RxList<UserGetById>([]);
  List<UserGetById> listUser = [];

  signIn(String email, String password) async {
    isShowLoading.value = true;
    ApiResponse response =
        await SignInApi().signInApi(email: email, password: password);
    if (response.data['error'] == null) {
      user.value = User.fromJson(response.data);
      errorText.value = '';
      final openBox = await Hive.openBox('USER');
      await openBox.put('email', email);
      await openBox.put('password', password);
    } else {
      user.value = null;
      errorText.value=response.data['error'];
    }
    isShowLoading.value =false;
  }

  signUp(String email, String password, String userName, String name,
      String description) async {
    isShowLoading.value =true;
    ApiResponse response = await SignUpApi().signUpApi(
        email: email,
        password: password,
        userName: userName,
        name: name,
        description: description);
    isShowLoading.value =false;
  }

  updateAvatar(String id, String imageSrc) async{
    ApiResponse response = await UpdateAvatarApi().updateAvatarApi(
      id: id,
      imageSrc: imageSrc
    );
  }

  Future choosePhotoFromLibrary() async {
    try{
      var image = await imagePicker.getImage(
          source: ImageSource.gallery, maxHeight: 400, maxWidth: 400);
      if (image != null) {
        isShowLoading.value = true;
        await uploadPhoto(File(image.path));
      }
      isShowLoading.value = false;
    }catch (e){
      print(e);
      isShowLoading.value = false;
    }
  }

  Future takeNewPhoto() async {
    try{
      var image = await imagePicker.getImage(
          source: ImageSource.camera, maxHeight: 400, maxWidth: 400);
      if (image != null) {
        isShowLoading.value = true;
        await uploadPhoto(File(image.path));
      }
      isShowLoading.value = false;
    }catch (e){
      print(e);
      isShowLoading.value = false;
    }
  }

  uploadPhoto(File image) async {
    print(user.value.imgSrc);
    try{
      CloudinaryResponse response = await CloudinaryHelper.cloudinary.uploadFile(
        CloudinaryFile.fromFile(image.path, resourceType: CloudinaryResourceType.Image),
      );
      await updateAvatar(user.value.id, response.secureUrl);
      loadUserData();
    }on CloudinaryException catch(e){
      print(e.message);
      print(e.request);
    }
    print(user.value.imgSrc);
  }

  loadUserData() async{
    final openBox = await Hive.openBox('USER');
    await signIn(openBox.get('email'), openBox.get('password'));
    openBox.close();
  }

  getSuggestedAccount(String id) async {
    ApiResponse response = await GetSuggestedAccountByIdApi().getSuggestedAccountByIdApi(
        id: id,
    );
    List suggested = response.data;
    listSuggestedAccount.assignAll(suggested.map((e) => User.fromJson(e)).toList());

  }

  addFollow(String myId, String followingId) async{
    isShowLoading.value = true;
    ApiResponse response = await FollowAccountApi().followAccountApi(
      myId: myId,
      followingId: followingId
    );
    isShowLoading.value = false;
  }

  getAccountById(String id) async{
    ApiResponse response = await GetAccountByIdOrUserNameApi().getAccountByIdOrUserNameApi(
        id: id,
    );
    UserGetById user = UserGetById.fromJson(response.data);
    return user;
  }

  getListFollowers(){
    isShowLoading.value = true;
    listFollowers.clear();
    user.value.followers.forEach((key, value) async{
      UserGetById userFollowers = await getAccountById(value['id_account']);
      listFollowers.add(userFollowers);
    });
    isShowLoading.value = false;
  }

  getListFollowing() {
    isShowLoading.value = true;
    listFollowing.clear();
    user.value.following.forEach((key, value) async{
      UserGetById userFollowers = await getAccountById(value['id_account']);
      listFollowing.add(userFollowers);
    });
    isShowLoading.value = false;
  }

  unFollow(String myId, String followingId) async{
    isShowLoading.value = true;
    ApiResponse response = await UnFollowAccountApi().unFollowAccountApi(
        myId: myId,
        followingId: followingId
    );
    isShowLoading.value = false;
  }
}
