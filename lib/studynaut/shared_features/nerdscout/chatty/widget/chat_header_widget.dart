import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:studynaut_admin/core/models/superUser.dart';

// import 'package:studynautz/Models/superUser.dart';

import '../page/chat_page.dart';

class ChatHeaderWidget extends StatelessWidget {
  final List<SuperUser> users;

  const ChatHeaderWidget({
    required this.users,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 24),
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.75,
              child: const Text(
                'ChatsApp',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 12),
            Container(
              height: 60,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: users.length,
                itemBuilder: (context, index) {
                  final user = users[index];
                  if (index == 0) {
                    return Container(
                      margin: const EdgeInsets.only(right: 12),
                      child: const CircleAvatar(
                        radius: 24,
                        child: Icon(Icons.search),
                      ),
                    );
                  } else {
                    return Container(
                      margin: const EdgeInsets.only(right: 12),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => ChatPage(user: users[index]),
                          ));
                        },

                        child: const Icon(IconlyBold.info_circle),
                        // child: CircleAvatar(
                        //   radius: 24,
                        //   backgroundImage: NetworkImage(user.avatarUrl),
                        // ),
                      ),
                    );
                  }
                },
              ),
            )
          ],
        ),
      );
}
