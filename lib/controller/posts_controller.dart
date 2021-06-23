import 'package:do_an_tong_hop/api/api_response.dart';
import 'package:do_an_tong_hop/api/app_api/api_get_posts.dart';
import 'package:do_an_tong_hop/controller/user_controller.dart';
import 'package:get/get.dart';

class PostsController extends GetxController{

  getPosts(UserController userController) async{
    ApiResponse response =
        await GetPostsApi().getPostsApi(id: userController.user.value.id);
    print(response.data);
  }
}