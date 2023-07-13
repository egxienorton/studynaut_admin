import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import 'package:studynautz/core/typography/typo.dart';
import 'package:studynautz/nerdscout/social/connectController.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

import 'feeds/screens/feed_screen.dart';
import 'feeds/social_me.dart';
import 'groupy/start_page.dart';
import 'reels/tiktok.dart';
import 'reels/tiktok_pro/video_screen.dart';

class SocialMain extends StatelessWidget {
  //  SocialMain({super.key}); //Params to parse here....

  SocialController socialController = Get.put(SocialController());

  final int index = 0;

  List<Widget> demoPages = [
    Center(
      child: Text(
        'Feeds',
        style: TextStyle(fontFamily: 'Aspira', fontSize: 43),
      ),
    ),
    Center(
      child: Text(
        'Chats',
        style: TextStyle(fontFamily: 'Aspira', fontSize: 43),
      ),
    ),
    Center(
      child: Text(
        'Groups',
        style: TextStyle(fontFamily: 'Aspira', fontSize: 43),
      ),
    ),
    Center(
      child: Text(
        'Reels',
        style: TextStyle(fontFamily: 'Aspira', fontSize: 43),
      ),
    )
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
          physics: NeverScrollableScrollPhysics(),
          controller: socialController.pageController,
          onPageChanged: socialController.animateToTab,
          children: [
            FeedScreen(),
            Center(
              child: Text(
                'Chats',
                style: TextStyle(fontFamily: 'Aspira', fontSize: 43),
              ),
            ),
            GroupyMain(),
            // TikReels()
            VideoScreen()
          ]),
      bottomNavigationBar: BottomAppBar(
        notchMargin: 10, //!
        elevation: 0,
        child: Container(
            padding: EdgeInsets.symmetric(horizontal: 35, vertical: 10),
            child: Obx(
              () => Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _bottomAppBarItem(context,
                      icon: IconlyLight.notification, page: 0, label: "Feeds"),
                  _bottomAppBarItem(context,
                      icon: IconlyLight.chat, page: 1, label: "Chats"),
                  _bottomAppBarItem(context,
                      icon: IconlyLight.user_1, page: 2, label: "Groups"),
                  // _bottomAppBarItem(context,
                  //     icon: IconlyLight.bookmark, page: 0, label: "Library"),
                  _bottomAppBarItem(context,
                      icon: IconlyLight.video, page: 3, label: "Reels")
                ],
              ),
            )),
      ),
    );
  }

  Widget _bottomAppBarItem(BuildContext context,
      {required icon, required page, required label}) {
    return ZoomTapAnimation(
      onTap: () {
        socialController.goToTab(page);
      },
      child: Container(
        color: Colors.transparent,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: socialController.currentPage == page
                  ? Colors.purpleAccent
                  : Colors.blueGrey,
            ),
            Text(label,
                style: TextStyle(
                    fontFamily: 'Aspira',
                    fontSize: socialController.currentPage == page ? 16 : 12))
          ],
        ),
      ),
    );
  }
}
