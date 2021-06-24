import 'package:do_an_tong_hop/screen/post/setting_post_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PostPage extends StatefulWidget {
  @override
  _PostPageState createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  @override
  Widget build(BuildContext context) {
    final decoration = BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.black54
    );
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.close),
          onPressed: () {
            Get.back();
          },
        ),
        actions: [
          FlatButton(
              onPressed: (){
                Get.to(()=>SettingPostPage());
              },
              child: Text('Next', style: Theme.of(context).primaryTextTheme.subtitle1?.copyWith(
                color: Colors.blue
              ),))
        ],
      ),
      body: Column(
        children: [
          AspectRatio(
            aspectRatio: 1,
            child: Container(
              color: Colors.grey,
              child: Stack(
                children: [
                  Positioned.fill(child: Image.asset(
                    'lib/res/sample/search_demo1.jpg',
                    fit: BoxFit.cover,)),
                  Positioned(
                    child: Container(
                      padding: EdgeInsets.all(8),
                      child: Row(
                        children: [
                          Container(
                            child: IconButton(
                                icon: Icon(Icons.zoom_out_map, size: 16, color: Colors.white,),
                                onPressed: (){}),
                            decoration: decoration
                          ),
                          Expanded(child: Container()),
                          Container(
                            child: IconButton(
                                icon: Icon(Icons.camera, size: 16, color: Colors.white),
                                onPressed: (){}),
                              decoration: decoration

                          ),
                          SizedBox(width: 16,),
                          Container(
                            child: IconButton(
                                icon: Icon(Icons.format_shapes, size: 16, color: Colors.white),
                                onPressed: (){}),
                              decoration: decoration
                          ),
                          SizedBox(width: 16,),
                          Container(
                            child: IconButton(
                                icon: Icon(Icons.content_copy, size: 16, color: Colors.white),
                                onPressed: (){}),
                              decoration: decoration

                          )
                        ],
                      ),
                    ),
                    bottom: 0,
                    left: 0,
                    right: 0,
                  )
                ],
              ),
            ),
          ),
          Expanded(
            child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    crossAxisSpacing: 2,
                    mainAxisSpacing: 2
                ),
                itemCount: 8,
                itemBuilder: (context, index) {
                  return InkResponse(
                    child: Image.asset('lib/res/sample/feed_1.jpg', fit: BoxFit.cover,),
                    onTap: () {
//                      Navigator.of(context).push(
//                          MaterialPageRoute(builder: (context) => ExplorePage())
//                      );
                    },
                  );
                })
          )
        ],
      ),
    );
  }
}
