import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

class DatabaseService {
  final String? uid;
  DatabaseService({this.uid});

  //! remaster the ID of the group
  //TODO also the name and the group photo and info can be changed anytime
  //files too
  //TODO Group wall? like status or post wall

  // reference for our collections
  static final CollectionReference userCollection =
      FirebaseFirestore.instance.collection("users");
  static final CollectionReference groupCollection =
      FirebaseFirestore.instance.collection("groups");

  // getting user data
  Future gettingUserData(String email) async {
    QuerySnapshot snapshot =
        await userCollection.where("email", isEqualTo: email).get();
    return snapshot;
  }

  // get user groups
  getUserGroups() async {
    return userCollection.doc(uid).snapshots();
  }

  // creating a group
  // TODO
  Future createGroup(String userName, String id, String groupName) async {
    const uuid = Uuid();

    String groupGen = uuid.v1();
    String autoGenString = groupGen.replaceAll('-', '').trim().substring(0, 5);

    DocumentReference groupDocumentReference = await groupCollection.add({
      "groupName": groupName,
      "groupAvatar": "",
      "groupCover": "",
      "admins": [id], //? Already been implemented
      "members": [id],
      "inviteID": autoGenString,
      "locked": false, // when this is on, only admins can send messages
      "closed": false, // when this is on no one can enter with a sharedId
      "banned": [],
      "groupId": "",
      "recentMessage": "",
      "recentMessageSender": "",
    });
    // update the members
    await groupDocumentReference.update({
      "members": FieldValue.arrayUnion(["${uid}"]),
      "groupId": groupDocumentReference.id,
    });

    DocumentReference userDocumentReference = userCollection.doc(uid);
    return await userDocumentReference.update({
      "groups": FieldValue.arrayUnion(["${groupDocumentReference.id}"])
    });
  }

  static Future<bool> checkIfAdmin(
      String groupId, String userInQuestion) async {
    DocumentReference d = groupCollection.doc(groupId);
    DocumentSnapshot documentSnapshot = await d.get();
    List<dynamic> admins = await documentSnapshot['admins'];

    if (admins.contains(userInQuestion)) {
      return true;
    } else {
      return false;
    }
  }

  addMember(String numberOrEmail) {
    //build the logic to search for either of these

    //!Check if they exist
  }
  //TODO
  makeMemberAdmin(String groupId, String userIdInQuestion) async {
    //! check if adder is admin first
    DocumentReference groupDocumentReference = groupCollection.doc(groupId);
    await groupDocumentReference.update({
      "admins": FieldValue.arrayUnion(["${uid}"]),
    });
  }

  //! crucial -- Not detonated yet
  exitGroup(String groupId, String userIdInQuestion) async {
    //! Show dialog first o
    DocumentReference groupDocumentReference = groupCollection.doc(groupId);
    DocumentReference userDocumentReference =
        userCollection.doc(userIdInQuestion);

    await groupDocumentReference.update({
      "members": FieldValue.arrayRemove(["${uid}"]),
      // "groupId": groupDocumentReference.id,
    });

    await userDocumentReference.update({
      "groups": FieldValue.arrayRemove(["${groupDocumentReference.id}"])
    });
  }

  static Future<String> getNamesFromUid(String userIdInQuestion) async {
    DocumentReference userDocumentReference =
        userCollection.doc(userIdInQuestion);

    DocumentSnapshot documentSnapshot = await userDocumentReference.get();

    String name = await documentSnapshot.get('firstName');

    return name;
  }

  static Future<String> getGroupNamesFromUid(String groupInQuestion) async {
    DocumentReference groupDocumentReference =
        groupCollection.doc(groupInQuestion);

    DocumentSnapshot documentSnapshot = await groupDocumentReference.get();

    String name = await documentSnapshot['groupName'];

    return name;
  }

  //TODO
  updateGroupName() {}

  updateInfo() {}

  //! only admins
  updateGroupCover() {}

  updateAvatar() {}

  // getting the chats
  getChats(String groupId) async {
    return groupCollection
        .doc(groupId)
        .collection("messages")
        .orderBy("time")
        .snapshots();
  }

  Future<List> getGroupAdmin(String groupId) async {
    DocumentReference d = groupCollection.doc(groupId);
    DocumentSnapshot documentSnapshot = await d.get();

    List<dynamic> admins = await documentSnapshot['admins'];

    return admins;
  }

  //! This methods has a competitor
  Future<List> getMembersInGroup(String groupId) async {
    DocumentReference d = groupCollection.doc(groupId);
    DocumentSnapshot documentSnapshot = await d.get();

    List<dynamic> members = await documentSnapshot['members'];

    return members;
  }

  // get group members
  // getGroupMembers(groupId) async {
  //   return groupCollection.doc(groupId).snapshots();
  // }

  // search
  searchByName(String groupName) {
    return groupCollection.where("groupName", isEqualTo: groupName).get();
  }

  //TODO new
  searchById(String groupName) {
    return groupCollection.where("groupId", isEqualTo: groupName).get();
  }

  // function -> bool
  Future<bool> isUserJoined(
      String groupName, String groupId, String userName) async {
    DocumentReference userDocumentReference = userCollection.doc(uid);
    DocumentSnapshot documentSnapshot = await userDocumentReference.get();

    List<dynamic> groups = await documentSnapshot['groups'];
    if (groups.contains("${groupId}_$groupName")) {
      return true;
    } else {
      return false;
    }
  }

  // toggling the group join/exit
  Future toggleGroupJoin(
      String groupId, String userName, String groupName) async {
    // doc reference
    DocumentReference userDocumentReference = userCollection.doc(uid);
    DocumentReference groupDocumentReference = groupCollection.doc(groupId);

    DocumentSnapshot documentSnapshot = await userDocumentReference.get();
    List<dynamic> groups = await documentSnapshot['groups'];

    // if user has our groups -> then remove then or also in other part re join
    if (groups.contains("${groupId}")) {
      await userDocumentReference.update({
        "groups": FieldValue.arrayRemove(["${groupId}_$groupName"])
      });
      await groupDocumentReference.update({
        "members": FieldValue.arrayRemove(["${uid}_$userName"])
      });
    } else {
      await userDocumentReference.update({
        "groups": FieldValue.arrayUnion(["${groupId}_$groupName"])
      });
      await groupDocumentReference.update({
        "members": FieldValue.arrayUnion(["${uid}_$userName"])
      });
    }
  }

  // send message
  sendMessage(String groupId, Map<String, dynamic> chatMessageData) async {
    groupCollection.doc(groupId).collection("messages").add(chatMessageData);
    groupCollection.doc(groupId).update({
      "recentMessage": chatMessageData['message'],
      "recentMessageSender": chatMessageData['sender'],
      "recentMessageTime": chatMessageData['time'].toString(),
    });
  }
}
