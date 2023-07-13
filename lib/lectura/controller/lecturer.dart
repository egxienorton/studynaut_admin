import 'dart:developer' as dev;
import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:uuid/uuid.dart';

import '../../core/utils/dialogs/xDialogs.dart';

class Lectura {
  static final CollectionReference lecturaColllection =
      FirebaseFirestore.instance.collection("teachers");
  static final CollectionReference classCollection =
      FirebaseFirestore.instance.collection("classrooms");

  static FirebaseAuth auth = FirebaseAuth.instance;

  //TODO:Students can either send messages here or to me!!

  static CollectionReference getLecturaMailBox({required String lecturaId}) =>
      lecturaColllection.doc(lecturaId).collection('inbox');

  static void createClass(String className, String classDescription,
      String room, String subject, BuildContext context) async {
    String groupGen = generateRandomString();

    DocumentReference doc = await classCollection.doc().set({
      "classId": '',
      "className": className,
      "classDescription": classDescription,
      "classCode": groupGen.toUpperCase(),
      "room": room,

      "lecturers": [auth.currentUser!.uid],
      "created": DateTime.now().millisecondsSinceEpoch.toString(),
      // "teachers": [auth.],
      "Subject": subject
    }).then((value) => performAsyncOperation(className, context));
    classCollection.doc().update({
      "classId": doc.id,
    });

    Get.back();
  }

  static Future<DocumentReference<Object?>> performAsyncOperation(
      String className, BuildContext context) {
    return Future.delayed(Duration(seconds: 1), () {
      ExDialogs.showSnackbar(context, 'Successfully created ${className}');
      return null;
    }).then<DocumentReference<Object?>>((value) {
      // print('Value received: $value');
      return FirebaseFirestore.instance.collection('classrooms').doc();
    });
  }

  static String generateRandomString() {
    var random = Random();
    var randomString = '';

    // Generate a random letter
    var randomLetter = String.fromCharCode(
        random.nextInt(26) + 65); // Generates a random uppercase letter
    randomString += randomLetter;

    // Generate the remaining random characters (numbers and letters)
    for (var i = 0; i < 4; i++) {
      var randomChar = '';

      // Randomly choose between a letter or a number
      if (random.nextBool()) {
        randomChar = String.fromCharCode(
            random.nextInt(26) + 65); // Generates a random uppercase letter
      } else {
        randomChar = random
            .nextInt(10)
            .toString(); // Generates a random number between 0 and 9
      }

      randomString += randomChar;
    }

    return randomString;
  }

  static void generateRandomUuid(String classUid, BuildContext context) async {
    // const uuid = Uuid();

    String groupGen = generateRandomString();

    await classCollection.doc(classUid).update({
      "classCode": groupGen.toUpperCase(),
    });

    ExDialogs.showSnackbar(
        context, 'New Class Code : ${groupGen.toUpperCase()}');
  }

  static void addColleague(String colleageUid, String classId) async {
    await classCollection.doc(classId).update({
      "lectures": FieldValue.arrayUnion(["${colleageUid}"]),
      // "groupId": groupDocumentReference.id,
    });
  }

  static Future getClasses() async {
    return classCollection
        .where('lecturers', arrayContains: auth.currentUser!.uid)
        //TODO: Add a time to know when the user sent the stuff.
        // .orderBy("time")
        .snapshots();
  }

  //TODO: When a student joins a specific class, add them to the class and to the lectura's 'general class' to prevent too many reads --
  //! Also think of removing them sometime -- maybe in a new semester
  // static CollectionReference getAllStudents({required String lecturaId}) =>
  //     getALecturaReference(lecturaId: lecturaId).collection('studnents');

  // static Future getMails(String lecturaId) async {
  //   return getLecturaMailBox(lecturaId: lecturaId).orderBy("time").snapshots();
  // }

  // static void sendClassStudentAFeedbackMail(
  //     BuildContext context, String userId, String message, String subject) {
  //   studentCollection.doc(userId).collection('inbox').doc().set({
  //     "sender": "STUDY MAZE TEAM",
  //     "message": message,
  //     "read": "", // So once the user reads it. It goes off
  //     "subject": subject,
  //     "time": DateTime.now().millisecondsSinceEpoch.toString(),
  //   }).then((value) async {
  //     String token = await XNotifier.extractUserPushTokenInfo(userId);
  //     XNotifier.sendFeedbackNotification(subject, token);
  //   });
  //   xDialogs.showSnackbar(context, 'Feedback sent');
  // }

  static void makeAPost(String message) {}

  //prevent minimization by LCycle Methods

  static Future<void> uploadAMaterial(File file) async {}

  static void createAClass(String className) {
    try {} catch (e) {}
  }

  static Future<List<String>> fetchAllMyStudents(
      String lecturaUid, String classId) async {
    List<String> studentUIDs = [];

    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('teachers')
          .doc(lecturaUid)
          .collection('classes')
          .doc(classId)
          .collection('students')
          .get();
      querySnapshot.docs.forEach((doc) {
        String uid = doc.id;

        studentUIDs.add(uid);
      });

      dev.log(studentUIDs.toString());
    } catch (e) {
      // Handle any potential errors
      print('Error fetching user UIDs: $e');
    }

    return studentUIDs;
  }

  static void setATest() {}

  static void uploadAQuestionnaire() {}

  static void startLiveStream() {}

  static void makeAPDFMaterial() {}

  static void markAttendance() {
    //XR Code Logic will be implemented here...
  }

  //TODO Traverse to order by name of math number and generate a list from it..
  //! Will pay off for test and score evaluation..
  // static Stream<List<StudentUser>> getUsers() => FirebaseFirestore.instance
  //     .collection('users')
  //     // .orderBy(UserField.lastMessageTime, descending: true)
  //     .snapshots()
  //     .transform(Utils.transformer(StudentUser.fromJson));
}
