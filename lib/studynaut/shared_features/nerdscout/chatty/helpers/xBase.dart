import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:studynaut_admin/core/models/superUser.dart';
import 'package:studynautz/BLOC/Bindings%20and%20Imports/firequickie.dart';
import 'package:studynautz/BLOC/auth_controller.dart';
// import 'package:studynautz/Models/superUser.dart';
// import 'package:studynautz/Modelz/superUser2.dart';

import '../../../core/utils/util.dart';

import 'message.dart';

class XBase {
  static Stream<List<SuperUser>> getUsers() => FirebaseFirestore.instance
      .collection('users')
      .orderBy(UserField.lastMessageTime, descending: true)
      .snapshots()
      .transform(Utils.transformer(SuperUser.fromJson));

  static Stream<List<SuperUser>> getFriends() => FirebaseFirestore.instance
      .collection('users')
      .doc(auth.currentUser!.uid)
      .collection('friends')
      // .orderBy(UserField.lastMessageTime, descending: true)
      .snapshots()
      .transform(Utils.transformer(SuperUser.fromJson));

  static Future uploadMessage(
      String idUser, String message, Message? replyMessage) async {
    print('2 / 2');

    // final refMessages =
    //     FirebaseFirestore.instance.collection('chats/$idUser/messages');
    AuthController authController = Get.find<AuthController>();
    final time = DateTime.now().millisecondsSinceEpoch.toString();
    final newMessage = Message(
      fromId: authController.superUser.value.id,
      read: '',
      sent: DateTime.now().millisecondsSinceEpoch.toString(),
      toId: idUser,
      // avatarUrl: myUrlAvatar,
      // firstName: myUsername,
      message: message,
      type: Type.text,
      // createdAt: DateTime.now(),
      // createdAt: DateTime.now().millisecondsSinceEpoch.toString(),
      replyMessage: replyMessage == null ? null : replyMessage,
    );

    // await refMessages.add(newMessage.toJson());

    final ref =
        firestore.collection('chats/${getConversationID(idUser)}/messages/');
    await ref.doc(time).set(newMessage.toJson()).then((value) =>
        // sendPushNotification(chatUser, type == Type.text ? msg : 'image')

        Get.snackbar('hmm', 'message sent'));

    // final refUsers = FirebaseFirestore.instance.collection('users');
    // await refUsers
    //     .doc(idUser)
    //     .update({UserField.lastMessageTime: DateTime.now()});
  }

  //! This method is deprecated
  static Stream<List<Message>> getMessages(String idUser) {
    return FirebaseFirestore.instance
        .collection('chats/$idUser/messages')
        // .orderBy(MessageField.createdAt, descending: true)
        .snapshots()
        .map((QuerySnapshot<Map<String, dynamic>> query) {
      List<Message> retVal = [];
      query.docs.forEach((element) {
        retVal.add(Message.fromDocumentSnapshot(element));
      });

      return retVal;
    });
  }

  static Stream<List<Message>> getAllMessages2(userID) {
    return firestore
        .collection('chats/${getConversationID(userID)}/messages/')
        .orderBy('sent', descending: true)
        .snapshots()
        .map((QuerySnapshot<Map<String, dynamic>> query) {
      List<Message> retVal = [];
      query.docs.forEach((element) {
        retVal.add(Message.fromDocumentSnapshot(element));
      });

      return retVal;
    });
  }

  // for sending message
  static Future<void> sendMessage(
      SuperUser chatUser, String messg, Type type) async {
    //message sending time (also used as id)
    final time = DateTime.now().millisecondsSinceEpoch.toString();

    //message to send
    final Message message = Message(
        toId: chatUser.id,
        message: messg,
        read: '',
        type: type,
        fromId: user.uid,
        sent: time);

    final ref = firestore
        .collection('chats/${getConversationID(chatUser.id)}/messages/');
    await ref.doc(time).set(message.toJson()).then((value) =>
        // sendPushNotification(chatUser, type == Type.text ? msg : 'image')

        Get.snackbar('hmm', 'message sent'));
  }

  // NEW -- Still in trial mode and A/B testing

  // for authentication
  static FirebaseAuth auth = FirebaseAuth.instance;

  // to return current user
  static User get user => auth.currentUser!;
  // useful for getting conversation id

  static String getConversationID(String id) => user.uid.hashCode <= id.hashCode
      ? '${user.uid}_$id'
      : '${id}_${user.uid}';
}
