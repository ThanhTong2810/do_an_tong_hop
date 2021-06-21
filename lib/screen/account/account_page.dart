import 'package:do_an_tong_hop/controller/user_controller.dart';
import 'package:do_an_tong_hop/screen/account/app_bar_account.dart';
import 'package:do_an_tong_hop/screen/account/tab_bar_sliver_persistent_header_delegate.dart';
import 'package:do_an_tong_hop/theme/images_app.dart';
import 'package:do_an_tong_hop/widgets/bottomsheet/bottom_sheet_action.dart';
import 'package:do_an_tong_hop/widgets/loading_container.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:developer' as developer;

import 'header_account_widget.dart';

class AccountPage extends StatefulWidget {
  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  final UserController userController = Get.find();

  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Obx((){
        return LoadingContainer(
          child: Scaffold(
            body: NestedScrollView(
                headerSliverBuilder: (context, innerBoxIsScrolled) {
                  return [
                    AppBarAccount(),
                    SliverToBoxAdapter(
                      child: HeaderAccountWidget(),
                    ),
                    SliverPersistentHeader(
                      pinned: true,
                      delegate: TabBarSliverPersistentHeaderDelegate(
                          child: Container(
                            height: 48,
                            child: TabBar(
                              indicatorColor: Theme.of(context).colorScheme.onBackground,
                              tabs: [
                                Tab(icon: Icon(Icons.grid_on),),
                                Tab(icon: Icon(Icons.person_outline),)
                              ],
                            ),
                          )
                      ),
                    )
                  ];
                },
                body: TabBarView(
                    children: [
                      GridView.builder(
                          padding: EdgeInsets.all(2),
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              crossAxisSpacing: 2,
                              mainAxisSpacing: 2
                          ),
                          itemCount: 5,
                          itemBuilder: (context, index) {
                            return Image.asset(ImagesApp.searchDemo, fit: BoxFit.cover,);
                          }),
                      GridView.builder(
                          padding: EdgeInsets.all(2),
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 4,
                              crossAxisSpacing: 2,
                              mainAxisSpacing: 2
                          ),
                          itemCount: 5,
                          itemBuilder: (context, index) {
                            return Image.asset(ImagesApp.searchDemo, fit: BoxFit.cover,);
                          })
                    ]
                )),
          ),
          isLoading: userController.isShowLoading.value,
          isShowIndicator: true,
        );
      }),
    );
  }
}
