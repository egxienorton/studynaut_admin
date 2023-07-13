// import 'package:carbon_icons/carbon_icons.dart';
import 'package:flutter/material.dart';
import 'package:studynaut_admin/core/models/superUser.dart';
// import 'package:studynautz/Models/superUser.dart';

import '../page/chat_page.dart';
import 'chatCard.dart';

class ChatBodyWidget extends StatelessWidget {
  final List<SuperUser> users;

  const ChatBodyWidget({
    required this.users,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Expanded(
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25),
              topRight: Radius.circular(25),
            ),
          ),
          child: buildChats(),
        ),
      );

  Widget buildChats() => ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          final user = users[index];

          //! Update
          return ChatUserCard(
            user: user,
          );
          //TODO: OLD CODE return ListTile(
          //   onTap: () {
          //     Navigator.of(context).push(MaterialPageRoute(
          //       builder: (context) => ChatPage(user: user),
          //     ));
          //   },
          //   // leading: CircleAvatar(
          //   //   radius: 25,
          //   //   backgroundImage: NetworkImage(user.avatarUrl),
          //   // ),

          //   leading: user.avatarUrl != ''
          //       ? CircleAvatar(
          //           child: Image.network(user.avatarUrl),
          //         )
          //       : const CircleAvatar(
          //           backgroundColor: Colors.grey,
          //           child: Icon(
          //             CarbonIcons.user,
          //           ),
          //         ),
          //   title: Text(
          //     user.firstName,
          //     style: const TextStyle(fontFamily: 'Product Sans'),
          //   ),

          //   subtitle: const Text('Start chatting! '),

          //   trailing: Column(
          //       mainAxisAlignment: MainAxisAlignment.spaceAround,
          //       children: [
          //         const Text("12:15 PM"),
          //         const Spacer(),
          //         const CircleAvatar(
          //           backgroundColor: Colors.greenAccent,
          //           radius: 10,
          //           child: Text(
          //             "1",
          //             style: TextStyle(
          //                 color: Colors.white, fontWeight: FontWeight.bold),
          //           ),
          //         )
          //       ]),
          // );
        },
        itemCount: users.length,
      );
}
