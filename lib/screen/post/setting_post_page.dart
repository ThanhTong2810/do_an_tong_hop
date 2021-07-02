import 'package:do_an_tong_hop/controller/posts_controller.dart';
import 'package:do_an_tong_hop/controller/user_controller.dart';
import 'package:do_an_tong_hop/screen/post/location_selector_widget.dart';
import 'package:do_an_tong_hop/screen/post/post_create_view_model.dart';
import 'package:do_an_tong_hop/screen/post/write_caption_widget.dart';
import 'package:do_an_tong_hop/theme/colors.dart';
import 'package:do_an_tong_hop/theme/dimens.dart';
import 'package:do_an_tong_hop/widgets/app_text.dart';
import 'package:do_an_tong_hop/widgets/loading_container.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

class SettingPostPage extends StatefulWidget {
  @override
  _SettingPostPageState createState() => _SettingPostPageState();
}

class _SettingPostPageState extends State<SettingPostPage> {
  final PostsController postsController = Get.find();
  final UserController userController = Get.find();

  TextEditingController _caption = TextEditingController();

  @override
  void initState() {
    postsController.imagesPicker.clear();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    ModalRoute.of(context).overlayEntries.forEach((element) {

    });
  }

  @override
  Widget build(BuildContext context) {
    return Obx((){
      return LoadingContainer(
        child: Scaffold(
          appBar: AppBar(
            title: Text('New Post'),
            actions: [
              TextButton(
                  onPressed: () async{
                    if(_caption.text.isNotEmpty && postsController.imagesPicker.isNotEmpty){
                      await postsController.savePost(userController, _caption.text);
                      Get.back();
                    }
                  },
                  child: Text('Share', style: Theme.of(context).primaryTextTheme.subtitle1?.copyWith(
                      color: Colors.blue
                  ),))
            ],
          ),
          body: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Dimens.height20,
                postsController.imagesPicker.isEmpty?GestureDetector(
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Center(
                        child: AppText(
                          text: '+ Add Images',
                          color: AppColors.clickableText,
                        ),
                      ),
                    ),
                  ),
                  onTap: (){
                    postsController.choosePhoto();
                  },
                ):AspectRatio(
                  aspectRatio: 1,
                  child: PageView(
                    children: postsController.imagesPicker.map((image){
                      return Image.file(
                        image,
                        fit: BoxFit.cover,
                      );
                    }).toList(),
                    onPageChanged: (index){
                    },
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                      vertical: 12,
                      horizontal: 16
                  ),
                  child: Row(
                    children: [
                      CircleAvatar(
                        backgroundImage: NetworkImage(userController.user.value.imgSrc),
                      ),
                      Expanded(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16),
                            child: TextField(
                              controller: _caption,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Write a caption',
                                  hintStyle: Theme.of(context).textTheme.bodyText1?.copyWith(
                                      color: Theme.of(context).hintColor
                                  )
                              ),
                            ),
                          )
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        isLoading: postsController.isShowLoading.value,
        isShowIndicator: true,
      );
    });
  }
}
