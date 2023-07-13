import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';

class ProfileHeaderWidget extends StatelessWidget {
  final String name;

  const ProfileHeaderWidget({
    required this.name,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Container(
        height: MediaQuery.of(context).size.height / 10,
        padding: const EdgeInsets.all(0).copyWith(right: 0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // BackButton(color: Colors.white),
                IconButton(
                    onPressed: () {
                      Get.back();
                    },
                    icon: const Icon(
                      IconlyBold.arrow_left_3,
                      color: Colors.white,
                    )),
                GestureDetector(
                  onTap: () {
                    Get.snackbar('title', 'message');

                    Get.to(() => ChatInfo(name: name));
                  },
                  child: Expanded(
                    child: Text(
                      name,
                      style: const TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          // fontWeight: FontWeight.bold,
                          fontFamily: 'Product Sans'),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    buildIcon(IconlyBold.call),
                    const SizedBox(width: 12),
                    buildIcon(IconlyBold.voice_2),
                  ],
                ),
                // const SizedBox(width: 4),
              ],
            )
          ],
        ),
      );

  Widget buildIcon(IconData icon) => Container(
        padding: const EdgeInsets.all(5),
        margin: const EdgeInsets.only(right: 5),
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          // color: Colors.white54,
          color: Colors.black38,
        ),
        child: Icon(icon, size: 20, color: Colors.white),
      );
}

class ChatInfo extends StatelessWidget {
  final String name;

  const ChatInfo({Key? key, required this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        Container(
          padding: const EdgeInsets.all(20),
          height: 120,
          color: Colors.blueAccent,
          child: Align(alignment: Alignment.bottomLeft, child: Text(name)),
        ),
        Expanded(
            child: ListView(
          children: const [
            ListTile(
              leading: Text("Department"),
            )
          ],
        ))
      ]),
    );
  }
}
