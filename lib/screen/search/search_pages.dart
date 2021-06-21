import 'package:do_an_tong_hop/theme/icons_app.dart';
import 'package:do_an_tong_hop/screen/explore/explore_page.dart';
import 'package:do_an_tong_hop/theme/images_app.dart';
import 'package:do_an_tong_hop/widgets/chip_widget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tuple/tuple.dart';

class SearchPages extends StatefulWidget {
  @override
  _SearchPagesState createState() => _SearchPagesState();
}

class _SearchPagesState extends State<SearchPages> {

  List<Tuple2<String, String>> categories = [
    Tuple2(IconsApp.icShop, 'Shop'),
    Tuple2(IconsApp.icFood, 'Food'),
    Tuple2(IconsApp.icStyle, 'Style'),
    Tuple2(IconsApp.icTravel, 'Travel'),
    Tuple2(IconsApp.icArt, 'Art'),
    Tuple2(IconsApp.icMusic, 'Music'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.search),
        title: Text('Search'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.leak_add),
            onPressed: (){},
          )
        ],
        bottom: PreferredSize(
            child: Container(
              height: 48,
              child: ListView.separated(
                padding: EdgeInsets.symmetric(
                  vertical: 8,
                  horizontal: 16
                ),
                physics: BouncingScrollPhysics(),
                separatorBuilder: (context, index) => SizedBox(width: 16,),
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) => ChipWidget(
                  SvgPicture.asset(
                    categories[index].item1,
                    color: Theme.of(context).colorScheme.onBackground,
                    width: 18,
                  ),
                  Text(categories[index].item2)
                ),
                itemCount: categories.length,
              ),
            ),
            preferredSize: Size.fromHeight(48)),
      ),
      body: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            crossAxisSpacing: 2,
            mainAxisSpacing: 2
          ),
          itemCount: 8,
          itemBuilder: (context, index) {
            return InkResponse(
              child: Image.asset(ImagesApp.feed1, fit: BoxFit.cover,),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => ExplorePage())
                );
              },
            );
          }),
    );

  }
}
