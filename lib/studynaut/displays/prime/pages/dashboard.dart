import 'dart:math';

import 'package:flutter/material.dart';
import 'package:animated_sidebar/animated_sidebar.dart';
import 'package:iconly/iconly.dart';

import '../../../shared_features/AI/chatgpt/chatGPT.dart';

class PrimeDashBoard extends StatefulWidget {
  const PrimeDashBoard({super.key});

  @override
  State<PrimeDashBoard> createState() => _PrimeDashBoardState();
}

class _PrimeDashBoardState extends State<PrimeDashBoard> {
  List<Widget> pages = [
    Center(
      child: Text(
        'Home',
        style: TextStyle(fontFamily: 'Satohis', fontSize: 34),
      ),
    ),
    ChatGPT(),
    Center(
      child: Text(
        'Tools',
        style: TextStyle(fontFamily: 'Satoshis', fontSize: 34),
      ),
    ),
    Center(
      child: Text(
        'ChatCPT',
        style: TextStyle(fontFamily: 'Satoshis', fontSize: 34),
      ),
    ),
    Center(
      child: Text(
        'Screen 2',
        style: TextStyle(fontFamily: 'Satoshis', fontSize: 34),
      ),
    ),
    Center(
      child: Text(
        'Screen 3',
        style: TextStyle(fontFamily: 'Satoshis', fontSize: 34),
      ),
    ),
    Center(
      child: Text(
        'Last CArd',
        style: TextStyle(fontFamily: 'Satoshis', fontSize: 34),
      ),
    ),
    Center(
      child: Text(
        'Last Game',
        style: TextStyle(fontFamily: 'Satoshis', fontSize: 34),
      ),
    ),
  ];
  int activeTab = 0;

  final List<SidebarItem> items = [
    SidebarItem(
      icon: IconlyBold.home,
      text: 'My Dashboard',
    ),
    SidebarItem(
      icon: IconlyLight.notification,
      text: 'Notifications',
    ),
    SidebarItem(
      icon: IconlyBold.user_2,
      text: 'Management',
      children: [
        SidebarChildItem(
          icon: Icons.person,
          text: 'Users',
        ),
        SidebarChildItem(
          icon: Icons.verified_user,
          text: 'Roles',
        ),
        SidebarChildItem(
          icon: Icons.key,
          text: 'ChatGPT',
        ),
      ],
    ),
    SidebarItem(
      icon: Icons.abc,
      text: 'Integrations',
    ),
    SidebarItem(
      icon: Icons.settings,
      text: 'Settings',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: Row(
          children: [
            AnimatedSidebar(
              margin: const EdgeInsets.all(0),
              expanded: MediaQuery.of(context).size.width > 600,
              items: items,
              // use this to set the active tab if you want to control it from outside
              // combined with autoSelectedIndex set to false
              // if you don't set autoSelectedIndex to false, the widget will
              // automatically set the active tab and selected item is used only
              // to set the initial value
              selectedIndex: activeTab,
              autoSelectedIndex: false,
              onItemSelected: (index) => setState(() => activeTab = index),
              duration: const Duration(milliseconds: 1000),
              frameDecoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  tileMode: TileMode.repeated,
                  colors: [
                    Color.fromARGB(255, 210, 115, 108),
                    Color.fromARGB(255, 136, 108, 237),
                  ],
                ),
                // borderRadius: BorderRadius.all(Radius.circular(10)),
                // boxShadow: [
                //   BoxShadow(
                //     color: Color.fromRGBO(14, 119, 219, 0.745),
                //     spreadRadius: 0,
                //     blurRadius: 20,
                //     offset: Offset(0, 10),
                //   ),
                // ],
              ),
              minSize: 90,
              maxSize: 250,
              itemIconSize: 20,
              itemIconColor: Colors.white,
              itemHoverColor: Colors.grey.withOpacity(0.3),
              itemSelectedColor: Colors.grey.withOpacity(0.3),
              itemTextStyle: const TextStyle(
                  color: Colors.white, fontSize: 16, fontFamily: 'Satoshis'),
              itemSelectedBorder: const BorderRadius.all(
                Radius.circular(5),
              ),
              itemMargin: 24,
              itemSpaceBetween: 32,
              headerIcon: IconlyBold.activity,
              headerIconSize: 24,
              headerIconColor: Colors.amberAccent,
              headerTextStyle: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                  fontFamily: 'Satoshis'),
              headerText: ' Studynautz',
            ),
            Expanded(
              child: pages[activeTab],
            ),
          ],
        ),
      ),
    );
  }
}
