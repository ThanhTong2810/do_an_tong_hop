import 'package:do_an_tong_hop/screen/post/location_selector_widget.dart';
import 'package:do_an_tong_hop/screen/post/post_create_view_model.dart';
import 'package:do_an_tong_hop/screen/post/write_caption_widget.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

class SettingPostPage extends StatefulWidget {
  @override
  _SettingPostPageState createState() => _SettingPostPageState();
}

class _SettingPostPageState extends State<SettingPostPage> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    ModalRoute.of(context).overlayEntries.forEach((element) {

    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New Post'),
        actions: [
          TextButton(
              onPressed: (){
                Navigator.popUntil(context, (route) => route.isFirst);
              },
              child: Text('Share', style: Theme.of(context).primaryTextTheme.subtitle1?.copyWith(
                  color: Colors.blue
              ),))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            WriteCaptionWidget(),
            Divider(height: 1,),
            ListTile(
              title: Text('Tag People'),
              dense: true,
            ),
            Divider(height: 1,),
            if (context.watch<PostCreateViewModel>().currentLocation == null)
              ListTile(
                title: Text('Add Location'),
                dense: true,),
            if (context.watch<PostCreateViewModel>().currentLocation != null)
              ColorFiltered(
                colorFilter: ColorFilter.mode(
                    Theme.of(context).toggleableActiveColor,
                    BlendMode.srcATop),
                child: ListTile(
                  title: Text('${context.watch<PostCreateViewModel>().currentLocation}'),
                  leading: Icon(Icons.pin_drop),
                  trailing: IconButton(
                      icon: Icon(Icons.close),
                      onPressed: () {
                        context.read<PostCreateViewModel>().setCurrentLocation(
                            null
                        );
                      }),
                  dense: true,),
              ),
            Divider(height: 1,),
            if(context.watch<PostCreateViewModel>().currentLocation == null) LocationSelectorWidget(),
            if(context.watch<PostCreateViewModel>().currentLocation == null) Divider(height: 1,),
            SwitchListTile(
              value: context.watch<PostCreateViewModel>().isShareFacebook,
              onChanged: (value) {
                context.read<PostCreateViewModel>().enableSocialShare(SocialShare.FACEBOOK, value);
              },
              title: Text('Facebook'),
            ),
            SwitchListTile(
              value: context.watch<PostCreateViewModel>().isShareTwitter,
              onChanged: (value) {
                context.read<PostCreateViewModel>().enableSocialShare(SocialShare.TWITTER, value);
              },
              title: Text('Twitter'),
            ),
            SwitchListTile(
              value: context.watch<PostCreateViewModel>().isShareTumblr,
              onChanged: (value) {
                context.read<PostCreateViewModel>().enableSocialShare(SocialShare.TUMBLR, value);
              },
              title: Text('Tumblr'),
            ),
          ],
        ),
      ),
    );
  }
}
