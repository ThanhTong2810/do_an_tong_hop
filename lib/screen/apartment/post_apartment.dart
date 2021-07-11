import 'package:do_an_tong_hop/controller/apartment_controller.dart';
import 'package:do_an_tong_hop/theme/colors.dart';
import 'package:do_an_tong_hop/theme/dimens.dart';
import 'package:do_an_tong_hop/theme/icons_app.dart';
import 'package:do_an_tong_hop/theme/images_app.dart';
import 'package:do_an_tong_hop/utils/utils.dart';
import 'package:do_an_tong_hop/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class PostApartmentScreen extends StatefulWidget {
  const PostApartmentScreen({Key key}) : super(key: key);

  @override
  _PostApartmentScreenState createState() => _PostApartmentScreenState();
}

class _PostApartmentScreenState extends State<PostApartmentScreen> {
  final ApartmentController apartmentController = Get.find();

  @override
  void initState() {
    onWidgetBuildDone(getPostsApartment);
    super.initState();
  }

  getPostsApartment() async{
    await apartmentController.getPostsApartment();
  }

  @override
  Widget build(BuildContext context) {
    return Obx((){
      return Scaffold(
        appBar: AppBar(
          title: AppText(
            text: 'Post Apartment',
            color: AppColors.black,
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: apartmentController.postsApartment.map((post) {
              return Column(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 16,
                    ).copyWith(right: 0),
                    child: Row(
                      children: <Widget>[
                        CircleAvatar(
                            radius: 16,
                            backgroundImage : AssetImage(ImagesApp.logoBanQuanLy)
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
                                  'Viet Nam ${formatBillDateTime(DateTime.fromMillisecondsSinceEpoch(post.ngayDang))}',
                                  style:
                                  Theme.of(context).textTheme.caption,
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  post.hinhAnh.isNotEmpty
                      ? AspectRatio(
                    aspectRatio: 1,
                    child: PageView(
                      children: post.hinhAnh.map((image) {
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
                            onPressed: () async{}),
                        IconButton(
                            icon: SvgPicture.asset(
                              IconsApp.icComment,
                              color:
                              Theme.of(context).colorScheme.onPrimary,
                            ),
                            onPressed: () {}),
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
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: RichText(
                      text: TextSpan(children: [
                        TextSpan(
                            text: post.username,
                            style: Theme.of(context)
                                .textTheme
                                .bodyText2),
                        TextSpan(
                            text: '  ${post.noiDung2}',
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1
                                ?.copyWith(
                                fontWeight: FontWeight.w400)),
                      ]),
                    ),
                  )
                ],
              );
            }).toList(),
          ),
          // child: Column(
          //   mainAxisSize: MainAxisSize.min,
          //   children: apartmentController.postsApartment.map((post){
          //     return Padding(
          //       padding: EdgeInsets.symmetric(vertical: 10.0),
          //       child: Card(
          //         child: Padding(
          //           padding: EdgeInsets.all(10.0),
          //           child: Column(
          //             mainAxisSize: MainAxisSize.min,
          //             crossAxisAlignment: CrossAxisAlignment.start,
          //             children: <Widget>[
          //               AspectRatio(
          //                 aspectRatio: 1,
          //                 child: PageView(
          //                   children: post.hinhAnh.map((image) {
          //                     return Image.network(
          //                       image,
          //                       fit: BoxFit.cover,
          //                     );
          //                   }).toList(),
          //                   onPageChanged: (index) {},
          //                 ),
          //               ),
          //               Dimens.height10,
          //               _buildTitleContentCard('Thể Loại:', post.theLoai),
          //               Dimens.height10,
          //               _buildTitleContentCard('Nội Dung:', post.noiDung2),
          //               Dimens.height10,
          //               _buildTitleContentCard('Ngày Đăng:', '${DateTime.fromMillisecondsSinceEpoch(post.ngayDang)}'),
          //               Dimens.height10,
          //               _buildTitleContentCard('__V:', '${post.v}'),
          //               Dimens.height10,
          //               _buildTitleContentCard('Tên:', post.username),
          //             ],
          //           ),
          //         ),
          //       ),
          //     );
          //   }).toList(),
          // ),
        ),
      );
    });
  }

  Widget _buildTitleContentCard(String title, String content){
    return Row(
      children: <Widget>[
        Expanded(
          child: AppText(
            text: title,
            color: AppColors.black,
          ),
        ),
        Expanded(
          child: AppText(
            text: content,
            color: AppColors.black,
          ),
        ),
      ],
    );
  }
}
