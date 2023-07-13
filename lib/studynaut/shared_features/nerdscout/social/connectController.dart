import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SocialController extends GetxController {
  late PageController pageController;

  RxInt currentPage = 0.obs;

  void goToTab(int page) {
    currentPage.value = page;
    pageController.jumpToPage(page);
  }

  void animateToTab(int page) {
    currentPage.value = page;
    pageController.animateToPage(page,
        duration: Duration(microseconds: 300), curve: Curves.ease);
  }

  @override
  void onInit() {
    // TODO: implement onInit
    pageController = PageController(initialPage: 0);

    super.onInit();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    pageController.dispose();

    super.onClose();
  }

  //handles posts ....

  // default tab controller for the bottom navigation bar.
}
