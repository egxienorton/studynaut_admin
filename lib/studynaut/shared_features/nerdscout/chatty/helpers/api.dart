import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:studynautz/Modelz/superUser2.dart';
// import 'package:studynautz/Models/superUser.dart';
import 'package:studynautz/core/wizzy/xDialogs.dart';

import 'message.dart';

class XAPIs {
  static FirebaseAuth auth = FirebaseAuth.instance;
  static FirebaseFirestore firestore = FirebaseFirestore.instance;
  static FirebaseStorage storage = FirebaseStorage.instance;
  static User get user => auth.currentUser!;
  static FirebaseMessaging fMessaging = FirebaseMessaging.instance;

  // static late TeacherModel me;
  static late SuperUser me;

  static String getConversationID(String id) => user.uid.hashCode <= id.hashCode
      ? '${user.uid}_$id'
      : '${id}_${user.uid}';

  // for getting specific user info
  static Stream<QuerySnapshot<Map<String, dynamic>>> getUserInfo(
      SuperUser superUser) {
    return firestore
        .collection('users')
        .where('id', isEqualTo: superUser.id)
        .snapshots();
  }

  // for getting current user info
  static Future<void> getSelfInfo() async {
    await firestore.collection('users').doc(user.uid).get().then((user) async {
      if (user.exists) {
        me = SuperUser.fromJson(user.data()!);
        await getFirebaseMessagingToken();

        //for setting user status to active
        XAPIs.updateActiveStatus(true);
        log('My Data: ${user.data()}');
      } else {
        // await createUser().then((value) => getSelfInfo());

        log('omo');
      }
    });
  }

  // update online or last active status of user
  static Future<void> updateActiveStatus(bool isOnline) async {
    firestore.collection('users').doc(user.uid).update({
      'is_online': isOnline,
      'last_active': DateTime.now().millisecondsSinceEpoch.toString(),
      'push_token': me.pushToken,
    });
  }

  // for getting firebase messaging token
  static Future<void> getFirebaseMessagingToken() async {
    await fMessaging.requestPermission();

    await fMessaging.getToken().then((t) {
      if (t != null) {
        me.pushToken = t;
        log('Push Token: $t');
      }
    });

    // for handling foreground messages
    // FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    //   log('Got a message whilst in the foreground!');
    //   log('Message data: ${message.data}');

    //   if (message.notification != null) {
    //     log('Message also contained a notification: ${message.notification}');
    //   }
    // });
  }

  static Future<bool> checkIfThereIsInternet(BuildContext context) async {
    try {
      await InternetAddress.lookup('google.com');
      return true;
    } catch (e) {
      ExDialogs.showSnackbar(context, 'Check your Network Connection');
      return false;
    }
  }

  //get only last message of a specific chat
  static Stream<QuerySnapshot<Map<String, dynamic>>> getLastMessage(
      SuperUser user) {
    return firestore
        .collection('chats/${getConversationID(user.id)}/messages/')
        .orderBy('sent', descending: true)
        .limit(1)
        .snapshots();
  }

  // for sending message
  static Future<void> sendMessage(SuperUser superUser, String message,
      Type type, Message? replyMessage, BuildContext ctx) async {
    //message sending time (also used as id)
    final time = DateTime.now().millisecondsSinceEpoch.toString();

    //message to send
    final Message messenger = Message(
        toId: superUser.id,
        message: message,
        // createdAt: time,
        read: '',
        type: type,
        fromId: user.uid,
        replyMessage: replyMessage == null ? null : replyMessage,
        sent: time);

    final ref = firestore
        .collection('chats/${getConversationID(superUser.id)}/messages/');
    await ref.doc(time).set(messenger.toJson()).then(
        (value) => ExDialogs.showSnackbar(ctx, 'Implement Firebase Messaging')
        // sendPushNotification(superUser, type == Type.text ? message : 'image')

        );
  }

  //! send chat image
  static Future<void> sendChatImage(SuperUser superUser, File file,
      Message? replyMessage, BuildContext ctx) async {
    //getting image file extension
    final ext = file.path.split('.').last;

    //storage file ref with path
    final ref = storage.ref().child(
        'images/${getConversationID(superUser.id)}/${DateTime.now().millisecondsSinceEpoch}.$ext');

    //uploading image
    await ref
        .putFile(file, SettableMetadata(contentType: 'image/$ext'))
        .then((p0) {
      log('Data Transferred: ${p0.bytesTransferred / 1000} kb');
    });

    //updating image in firestore database
    final imageUrl = await ref.getDownloadURL();
    await sendMessage(superUser, imageUrl, Type.image, replyMessage, ctx);
  }

  // for getting firebase messaging token
  // static Future<void> getFirebaseMessagingToken() async {
  //   await fMessaging.requestPermission();

  //   await fMessaging.getToken().then((t) {
  //     if (t != null) {
  //       me.pushToken = t;
  //       log('Push Token: $t');
  //     }
  //   });

  // for handling foreground messages
  // FirebaseMessaging.onMessage.listen((RemoteMessage message) {
  //   log('Got a message whilst in the foreground!');
  //   log('Message data: ${message.data}');

  //   if (message.notification != null) {
  //     log('Message also contained a notification: ${message.notification}');
  //   }
  // });
  // }

  // for sending push notification
  // static Future<void> sendPushNotification(
  //     TeacherModel teacher, String msg) async {
  //   try {
  //     final body = {
  //       "to": teacher.pushToken,
  //       "notification": {
  //         "title": me.firstName, //our name should be send
  //         "body": msg,
  //         "android_channel_id":
  //             "streams" // watch out for platform channel id for studymaze too
  //       },
  //       // "data": {
  //       //   "some_data": "User ID: ${me.id}",
  //       // },
  //     };

  //     var res = await post(Uri.parse('https://fcm.googleapis.com/fcm/send'),
  //         headers: {
  //           HttpHeaders.contentTypeHeader: 'application/json',
  //           HttpHeaders.authorizationHeader:
  //               'key=AAAA2iQKfmI:APA91bHwM52n93mqJGN7FDVowrZ_L-r43CZ3UgcjtMJdi0wBrFb30YlQk3N0fBaZSNH5xb3MrZcMp2uo9bvq9IEVkdeT1XT861e4ST6mqwI0JsLjOaeMkChpNN3ogPry34766G9AAq50'
  //         },
  //         body: jsonEncode(body));
  //     log('Response status: ${res.statusCode}');
  //     log('Response body: ${res.body}');
  //   } catch (e) {
  //     log('\nsendPushNotificationE: $e');
  //   }
  // }
}
