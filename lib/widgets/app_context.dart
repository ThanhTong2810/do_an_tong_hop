import 'dart:developer' as developer;

import 'package:do_an_tong_hop/widgets/bottomsheet/bottom_sheet_action.dart';
import 'package:do_an_tong_hop/widgets/bottomsheet/bottom_sheet_scrollable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

extension AppContext on BuildContext {

  ColorScheme get colorScheme => Theme.of(this).colorScheme;

  TextTheme get textTheme => Theme.of(this).textTheme;


  Future<BottomSheetAction> showBottomSheet(List<BottomSheetAction> actions) {
    return showModalBottomSheet(
        context: this,
        backgroundColor: Colors.transparent,
        builder: (context) {
          return DraggableScrollableSheet(
              expand: false,
              builder: (context, scrollController) {
                return BottomSheetScrollable(
                  actions: actions,
                  scrollController: scrollController,
                );
              }
          );
        }
    );
  }
}