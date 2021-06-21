import 'package:do_an_tong_hop/theme/images_app.dart';
import 'package:flutter/material.dart';

class NoConnectionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            ImagesApp.no_connection,
            fit: BoxFit.cover,
          ),
          Positioned.fill(
            bottom: 100,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: FlatButton(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50)),
                onPressed: () {},
                child: Text("Please check your connection"),
              ),
            ),
          )
        ],
      ),
    );
  }
}