import 'package:flutter/material.dart';

import 'package:swipe_to/swipe_to.dart';

import '../helpers/message.dart';
import '../helpers/xBase.dart';
import 'message_widget.dart';

class MessagesWidget extends StatelessWidget {
  final String idUser;
  final ValueChanged<Message> onSwipedMessage;

  const MessagesWidget({
    required this.idUser,
    required this.onSwipedMessage,
    Key? key,
  }) : super(key: key);

  @override
  // Widget build(BuildContext context) => StreamBuilder<List<Message>>(
  Widget build(BuildContext context) => StreamBuilder(
        stream: XBase.getAllMessages2(idUser),
        builder: (context, snapshot) {
          // if(snapshot.connectionState == ConnectionState.waiting){

          // }else if(snapshot.connectionState == ConnectionState.done){

          // }
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return const Center(child: CircularProgressIndicator());
            default:
              // final messages = snapshot.data;
              // print(messages);
              // return messages!.isEmpty
              //     ? buildText('Say Hi..')
              //     : ListView.builder(
              //         physics: BouncingScrollPhysics(),
              //         reverse: true,
              //         itemCount: messages.length,
              //         itemBuilder: (context, index) {
              //           final message = messages[index];

              //           return SwipeTo(
              //             onRightSwipe: () => onSwipedMessage(message),
              //             child: MessageWidget(
              //               message: message,
              //               isMe: message.id == myId,
              //             ),
              //           );
              //         },
              //       );
              // final messages = snapshot.data;
              if (snapshot.hasData) {
                final messages = snapshot.data;
                // Map nMap = List.from(snapshot.data);
                return messages!.isEmpty
                    ? buildText('Say Hi..')
                    : ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        reverse: true,
                        itemCount: messages.length,
                        itemBuilder: (context, index) {
                          final message = messages[index];

                          return SwipeTo(
                            onRightSwipe: () => onSwipedMessage(message),
                            child: MessageWidget(
                              message: message,
                              //! Watch what is happening here...
                              // isMe: message.id == myId,
                              isMe: message.fromId == idUser,
                            ),
                          );
                        },
                      );
              } else if (snapshot.hasError) {
                // print('Fetching the messages');

                return buildText(snapshot.error.toString());
              } else {
                return buildText('Error E-32 has occured');
              }
          }
        },
      );

  Widget buildText(String text) => Center(
        child: Text(
          text,
          style: const TextStyle(fontSize: 24, fontFamily: 'Product Sans'),
        ),
      );
}
