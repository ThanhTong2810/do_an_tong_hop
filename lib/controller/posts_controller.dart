import 'dart:io';

import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:do_an_tong_hop/api/api_response.dart';
import 'package:do_an_tong_hop/api/app_api/api_get_posts.dart';
import 'package:do_an_tong_hop/api/app_api/api_post_comment.dart';
import 'package:do_an_tong_hop/api/app_api/api_post_reply_comment.dart';
import 'package:do_an_tong_hop/api/app_api/api_post_save_posts.dart';
import 'package:do_an_tong_hop/controller/user_controller.dart';
import 'package:do_an_tong_hop/helpers/cloudinary_helper.dart';
import 'package:do_an_tong_hop/models/posts_model/comment_model.dart';
import 'package:do_an_tong_hop/models/posts_model/posts_model.dart';
import 'package:flutter_absolute_path/flutter_absolute_path.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_image_picker/multi_image_picker.dart';

class PostsController extends GetxController{
  RxList<PostsModel> newFeedPosts = RxList<PostsModel>([]);
  RxList<File> imagesPicker = RxList<File>([]);
  Rx<bool> isShowLoading = Rx<bool>(false);
  Rx<bool> isReply = Rx<bool>(false);
  Rx<String> idComment = Rx<String>(null);
  Rx<String> idOwnerComment = Rx<String>(null);

  getPosts(UserController userController) async{
    ApiResponse response =
        await GetPostsApi().getPostsApi(id: userController.user.value.id);
    List posts = response.data;
    newFeedPosts.assignAll(posts.map((e) => PostsModel.fromJson(e)).toList());
    newFeedPosts.sort((a,b)=>b.timeStamp.compareTo(a.timeStamp));
  }

  Future choosePhoto() async {
    imagesPicker.clear();
    List<Asset> arrayImage = List<Asset>();
    arrayImage=await MultiImagePicker.pickImages(
      maxImages :  5,
      enableCamera: true,
    );
    for(var imageAsset in arrayImage){
      var path=await FlutterAbsolutePath.getAbsolutePath(imageAsset.identifier);
      imagesPicker.add(File(path));
    }
  }

  uploadPhoto(File image) async {
    try{
      CloudinaryResponse response = await CloudinaryHelper.cloudinary.uploadFile(
        CloudinaryFile.fromFile(image.path, resourceType: CloudinaryResourceType.Image),
      );
      return response.secureUrl;
    }on CloudinaryException catch(e){
      print(e.message);
      print(e.request);
    }
  }

  savePost(UserController userController, String caption) async{
    List<String> imagesUrl = [];
    isShowLoading.value = true;
    for(var image in imagesPicker){
      String url = await uploadPhoto(image);
      imagesUrl.add(url);
    }
    ApiResponse response =
        await SavePostsApi().savePostsApi(id: userController.user.value.id, content: caption, images: imagesUrl);
    await getPosts(userController);
    isShowLoading.value = false;
  }

  addComment({UserController userController, String idPost, String idOwner, String contentHtml, List<String> mentionList}) async{
    ApiResponse response =
        await CommentPostsApi().commentPostsApi(idAccount: userController.user.value.id, idOwner: idOwner, idPost: idPost, contentHtml: contentHtml, mentionList: mentionList);
  }

  addReplyComment(UserController userController, String idOwner, String idPost, String idComment, String contentHtml, List<String> mentionList) async{
    ApiResponse response =
        await ReplyCommentApi().replyCommentApi(idAccount: userController.user.value.id,idOwner: idOwner,idPost: idPost,idComment: idComment,mentionList: mentionList,contentHtml: contentHtml);
  }
}