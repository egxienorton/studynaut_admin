import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:studynaut_admin/core/typography/typo.dart';

class ExDialogs {
  static void showSnackbar(BuildContext context, String msg) {
    Get.snackbar('title', msg);
  }
  // static void showSnackbar(BuildContext context, String msg) {
  //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
  //       content: Text(
  //         msg,
  //         style: AppTypography.header5(context).copyWith(color: Colors.white),
  //       ),
  //       backgroundColor: Theme.of(context).primaryColorDark,
  //       behavior: SnackBarBehavior.floating));
  // }

  // static void showProgressBar(BuildContext context) {
  //   showDialog(
  //       context: context,
  //       builder: (_) => const Center(child: CircularProgressIndicator(color: Theme.of(context).progressIndicatorTheme.color,)));
  // }

  // static void showUploadReel(BuildContext context, Function() ontap) {
  //   showDialog(
  //       context: context,
  //       builder: (_) => Container(
  //             width: MediaQuery.of(context).size.width * 0.6,
  //             child: Column(
  //               children: [ElevatedButton(onPressed: BusyBox., child: child)],
  //             ),
  //           ));
  // }
}
