import 'package:do_an_tong_hop/controller/posts_controller.dart';
import 'package:do_an_tong_hop/controller/user_controller.dart';
import 'package:do_an_tong_hop/screen/account/account_page.dart';
import 'package:do_an_tong_hop/screen/comment/comment_page.dart';
import 'package:do_an_tong_hop/theme/icons_app.dart';
import 'package:do_an_tong_hop/theme/images_app.dart';
import 'package:do_an_tong_hop/widgets/feed/body_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class FeedWidget extends StatefulWidget {
  @override
  _FeedWidgetState createState() => _FeedWidgetState();
}

class _FeedWidgetState extends State<FeedWidget> {
  final PostsController postsController = Get.find();
  final UserController userController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).cardColor,
      child: Container(
        decoration: BoxDecoration(
            border: Border(top: Divider.createBorderSide(context))),
        padding: EdgeInsets.only(bottom: 8),
        child: Obx(() {
          return postsController.newFeedPosts.isEmpty
              ? Center(
                  child: RefreshProgressIndicator(),
                )
              : Column(
                  mainAxisSize: MainAxisSize.min,
                  children: postsController.newFeedPosts.map((post) {
                    return Column(
                      children: <Widget>[
                        GestureDetector(
                          onTap: () async{
                            if(post.idAccount != userController.user.value.id){
                              postsController.myPost.clear();
                              userController.userAnother.value = await userController.getAccountById(post.idAccount);
                              userController.userDisplayPersonal.value = userController.userAnother.value;
                              postsController.getPostByID(userController);
                              Get.to(()=>AccountPage());
                            }
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              vertical: 4,
                              horizontal: 16,
                            ).copyWith(right: 0),
                            child: Row(
                              children: <Widget>[
                                CircleAvatar(
                                    radius: 16,
                                    backgroundImage : NetworkImage(post.accountImage)
                                ),
                                SizedBox(),
                                Expanded(
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                      left: 8,
                                    ),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        DefaultTextStyle(
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText2,
                                          child: Text(post.username),
                                        ),
                                        Text(
                                          'Viet Nam',
                                          style:
                                              Theme.of(context).textTheme.caption,
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {
                                    showDialog(
                                      useRootNavigator: false,
                                      context: context,
                                      builder: (context) {
                                        return Dialog(
                                          child: ListView(
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 16),
                                              shrinkWrap: true,
                                              children: [
                                                'Report...',
                                                'Turn on Post notification',
                                                'Copy Link',
                                                'Share to...',
                                                'Mute'
                                              ]
                                                  .map((e) => InkWell(
                                                        child: Container(
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                                  vertical: 12,
                                                                  horizontal: 16),
                                                          child: Text(e),
                                                        ),
                                                        onTap: () {
                                                          Navigator.pop(context);
                                                        },
                                                      ))
                                                  .toList()),
                                        );
                                      },
                                    );
                                  },
                                  icon: Icon(Icons.more_vert),
                                )
                              ],
                            ),
                          ),
                        ),
                        post.imageSrc.isNotEmpty
                            ? AspectRatio(
                                aspectRatio: 1,
                                child: PageView(
                                  children: post.imageSrc.map((image) {
                                    return Image.network(
                                      image,
                                      fit: BoxFit.cover,
                                    );
                                  }).toList(),
                                  onPageChanged: (index) {},
                                ),
                              )
                            : SizedBox(),
                        Container(
                          child: Row(
                            children: <Widget>[
                              IconButton(
                                  icon: SvgPicture.asset(
                                    IconsApp.icFavorite,
                                    color:
                                        Theme.of(context).colorScheme.onPrimary,
                                  ),
                                  onPressed: () async{
                                    await postsController.likePost(userController, post.idAccount, post.idPost);
                                  }),
                              IconButton(
                                  icon: SvgPicture.asset(
                                    IconsApp.icComment,
                                    color:
                                        Theme.of(context).colorScheme.onPrimary,
                                  ),
                                  onPressed: () {
                                    Get.to(() => CommentPage(
                                          idOwner: post.idAccount,
                                          idPost: post.idPost,
                                        ));
                                  }),
                              IconButton(
                                  icon: SvgPicture.asset(
                                    IconsApp.icSend,
                                    color:
                                        Theme.of(context).colorScheme.onPrimary,
                                  ),
                                  onPressed: () {}),
                              Expanded(
                                  child: Align(
                                alignment: Alignment.bottomRight,
                                child: IconButton(
                                    icon: Icon(Icons.bookmark_border),
                                    onPressed: () {}),
                              ))
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              DefaultTextStyle(
                                  style: Theme.of(context)
                                      .textTheme
                                      .subtitle2
                                      .copyWith(fontWeight: FontWeight.w800),
                                  child: Text(
                                    '${post.like.length} likes',
                                    style:
                                        Theme.of(context).textTheme.bodyText2,
                                  )),
                              Container(
                                width: double.infinity,
                                padding: EdgeInsets.only(
                                  top: 8,
                                ),
                                child: RichText(
                                  text: TextSpan(children: [
                                    TextSpan(
                                        text: post.username,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText2),
                                    TextSpan(
                                        text: '  ${post.content}',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1
                                            ?.copyWith(
                                                fontWeight: FontWeight.w400)),
                                  ]),
                                ),
                              ),
                              InkWell(
                                child: Container(
                                  child: Text(
                                    'View all ${post.comments} comment',
                                    style: Theme.of(context).textTheme.caption,
                                  ),
                                  padding: EdgeInsets.symmetric(vertical: 4),
                                ),
                                onTap: () {
                                  Get.to(() => CommentPage(
                                        idOwner: post.idAccount,
                                        idPost: post.idPost,
                                      ));
                                },
                              )
                            ],
                          ),
                        )
                      ],
                    );
                  }).toList(),
                );
        }),
      ),
    );
  }
}
