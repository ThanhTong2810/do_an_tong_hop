

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class PostCreateViewModel extends GetxController {

  List<String> locationSuggest = ['Ha Noi', 'Bac Ninh', 'Hai Phong', 'Bac Giang', 'Que Vo'];

  String currentLocation;

  bool isShareFacebook = false;

  bool isShareTwitter = false;

  bool isShareTumblr = false;

  void setCurrentLocation(String location) {
    currentLocation = location;
  }

  void enableSocialShare(SocialShare type, bool value) {
    switch(type) {
      case SocialShare.FACEBOOK:
        isShareFacebook = value;
        break;
      case SocialShare.TWITTER:
        isShareTwitter = value;
        break;
      case SocialShare.TUMBLR:
        isShareTumblr = value;
        break;
    }
  }
}

enum SocialShare {
  FACEBOOK, TWITTER, TUMBLR
}