import 'dart:collection';
import 'dart:io';
import 'package:do_an_tong_hop/widgets/android_dialog.dart';
import 'package:do_an_tong_hop/widgets/ios_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

/// This method is used when we need to call a method after build() function is completed.
void onWidgetBuildDone(function) {
  SchedulerBinding.instance.addPostFrameCallback((_) {
    function();
  });
}

double getScreenWidth(BuildContext context) {
  return MediaQuery.of(context).size.width;
}

double getScreenHeight(BuildContext context) {
  return MediaQuery.of(context).size.height;
}

String addCountryCode(String phoneNumber) {
  String phoneNumberWithCountryCode = phoneNumber.replaceFirst('0', '+84', 0);
  return phoneNumberWithCountryCode;
}

String removeCountryCode(String phoneNumber) {
  String phoneNumberWithoutCountryCode;
  if (phoneNumber != null) {
    phoneNumberWithoutCountryCode = phoneNumber.replaceFirst('+84', '0', 0);
  } else {
    phoneNumberWithoutCountryCode = 'Guest';
  }

  return phoneNumberWithoutCountryCode;
}

void hideKeyboard(BuildContext context) {
  FocusScope.of(context).requestFocus(new FocusNode());
}

String formatDateToHours(DateTime dateTime) {
  var formatter = DateFormat('H:mm');
  String formatted = formatter.format(dateTime);
  return formatted;
}

String formatBillDateTime(DateTime dateTime) {
  var formatter = DateFormat('H:mm * dd-MM-yyyy');
  String formatted = formatter.format(dateTime);
  return formatted;
}

String formatDate(DateTime dateTime) {
  var formatter = DateFormat('EEEE, MMM d yyy');
  var formatted = formatter.format(dateTime);
  return formatted;
}

String formatDateTime(DateTime dateTime) {
  var formatter = DateFormat('yyyy-MM-dd');
  var formatted = formatter.format(dateTime);
  return formatted;
}

DateTime formatStringToDateTime(String dateTime) {
  var formatter = DateFormat('yyyy-MM-dd');
  var formatted = formatter.parse(dateTime);
  return formatted;
}

String formatMonth(DateTime dateTime) {
  var formatter = DateFormat('yyyy-MM');
  var formatted = formatter.format(dateTime);
  return formatted;
}

String formatMonthToString(DateTime dateTime) {
  var formatter = DateFormat('MM_yyyy');
  var formatted = formatter.format(dateTime);
  return formatted;
}

List removeDuplicateElement(List list) {
  List finalList = [];
  var uniqueList = LinkedHashMap<String, bool>();
  for (var i in list) {
    uniqueList[i] = true;
  }
  for (var i in uniqueList.keys) {
    finalList.add(i);
  }
  return finalList;
}

convertPrice(num price) {
  var formatted = NumberFormat.simpleCurrency(decimalDigits: 0, locale: 'vi')
      .format(price.round());
  return formatted;
}

showConfirmDialog(BuildContext context,
    {String title, String content, Function cancel, Function confirm}) {
  if (Platform.isIOS) {
    showCupertinoDialog(
        context: context,
        builder: (context) {
          return IOSDialog(
            title: title,
            content: content,
            cancel: cancel,
            confirm: () {
              Get.back();
              confirm();
            },
          );
        });
  } else {
    showDialog(
        context: context,
        builder: (context) {
          return AndroidDialog(
            title: title,
            content: content,
            cancel: cancel,
            confirm: () {
              Get.back();
              confirm();
            },
          );
        });
  }
}

num subTotal(List<num> prices) {
  var subTotal;
  if (prices != null) {
    if (prices.isNotEmpty) {
      subTotal = prices.reduce((a, b) => a + b);
      return subTotal;
    } else
      subTotal = 0;
  } else
    subTotal = 0;
  return subTotal;
}
