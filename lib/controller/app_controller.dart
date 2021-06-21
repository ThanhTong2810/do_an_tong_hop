import 'package:do_an_tong_hop/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

class AppController extends GetxController {

  Rx<int> value = Rx<int>(0);

  Rx<bool> isEnglish = Rx<bool>(false);

  Rx<Locale> locale = Rx<Locale>(null);
  void reset() {
    value.value = 0;
  }

  void increment() {
    value.value++;
  }

  void decrement() {
    value.value--;
  }

  getDefaultLanguage() async {
    final openBoxLanguageCode = await Hive.openBox(Constants.LANGUAGE_BOX_NAME);
    String languageCode = await openBoxLanguageCode.get(Constants.LANGUAGE_KEY_NAME);
    switch (languageCode) {
      case "vi":
        locale.value = Locale("vi", 'VN');
        break;
      case "en":
        locale.value = Locale("en", 'US');
        break;
      default:
        locale.value = Locale("en", 'US');
    }
  }

  switchToVietnameseLanguage() async {
    final openBoxLanguageCode = await Hive.openBox(Constants.LANGUAGE_BOX_NAME);
    openBoxLanguageCode.put(Constants.LANGUAGE_KEY_NAME, "vi");
    locale.value = Locale("vi", 'VN');
  }

  switchToEnglishLanguage() async {
    final openBoxLanguageCode = await Hive.openBox(Constants.LANGUAGE_BOX_NAME);
    openBoxLanguageCode.put(Constants.LANGUAGE_KEY_NAME, "en");
    locale.value = Locale("en", 'US');
  }
}

