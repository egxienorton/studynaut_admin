import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:studynautz/BLOC/auth_controller.dart';
import 'package:studynautz/nerdscout/social/reels/tiktok_pro/constants.dart';

import 'package:uuid/uuid.dart';

import '../../../../BLOC/Bindings and Imports/firequickie.dart';
import '../models/post.dart';
import '../resources/storage_methods.dart';
import '../starred/timeline_model.dart';

// please add a firestore method to upload a timeline Event
class FireStoreMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // static Stream<List<UserModel>> getUsers() => FirebaseFirestore.instance
  //     .collection('users')
  //     .snapshots()
  //     .transform(Utils.transformer(UserModel.fromDocumentSnapshot));

  Future<String> uploadPost(String description, Uint8List file, String uid,
      String username, String profImage) async {
    // asking uid here because we dont want to make extra calls to firebase auth when we can just get from our state management
    String res = "Some error occurred";
    try {
      String photoUrl =
          await StorageMethods().uploadImageToStorage('posts', file, true);
      String postId = const Uuid().v1(); // creates unique id based on time
      Post post = Post(
        description: description,
        uid: uid,
        username: username,
        likes: [],
        postId: postId,
        datePublished: DateTime.now(),
        postUrl: photoUrl,
        profImage: profImage,
      );
      _firestore.collection('posts').doc(postId).set(post.toJson());
      res = "success";
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  Future<String> uploadTimelinePost(
      String author,
      String description,
      // Uint8List file,
      // String uid,
      String username,
      // String profImage ,
      String courseName,
      String department,
      String title) async {
    AuthController authController = Get.find<AuthController>();
    // asking uid here because we dont want to make extra calls to firebase auth when we can just get from our state management
    String res = "Some error occurred";
    String uid = auth.currentUser!.uid;
    try {
      // String photoUrl =
      //     await StorageMethods().uploadImageToStorage('posts', file, true);
      String profImage =
          'https://firebasestorage.googleapis.com/v0/b/quizzle-demo-ac8e4.appspot.com/o/e-library%2Fthumbnails%2F13335037._SY475_.jpg?alt=media&token=13a279ff-0cd2-4515-97be-393c785160d3';
      String photoUrl =
          'https://media.istockphoto.com/photos/a-lefthanded-person-solving-math-problem-picture-id1159806988?k=20&m=1159806988&s=612x612&w=0&h=g1OAM8mpoRlrmqXvspE9DKUne-jBWySWnW9sy3xyWec=';
      String timelineId = const Uuid().v1(); // creates unique id based on time
      TimelineModel post = TimelineModel(uid, timelineId, author, title,
          department, description, profImage, [], photoUrl, DateTime.now());

      _firestore
          .collection('colleges')
          .doc()
          .collection('courses')
          .doc(courseName)
          .collection('timeline')
          .doc(timelineId)
          .set(post.toJson());
      res = "success";
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  Future<String> likePost(String postId, String uid, List likes) async {
    String res = "Some error occurred";
    try {
      if (likes.contains(uid)) {
        // if the likes list contains the user uid, we need to remove it
        _firestore.collection('posts').doc(postId).update({
          'likes': FieldValue.arrayRemove([uid])
        });
      } else {
        // else we need to add uid to the likes array
        _firestore.collection('posts').doc(postId).update({
          'likes': FieldValue.arrayUnion([uid])
        });
      }
      res = 'success';
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  Future<String> likeTimelinePost(
      String postId, String courseName, String uid, List likes) async {
    String res = "Some error occurred";
    try {
      if (likes.contains(uid)) {
        // if the likes list contains the user uid, we need to remove it
        _firestore.collection('posts').doc(postId).update({
          'likes': FieldValue.arrayRemove([uid])
        });
      } else {
        // else we need to add uid to the likes array
        _firestore
            .collection('colleges')
            .doc(authController.superUser.value.institution)
            .collection('courses')
            .doc(courseName)
            .collection('timeline')
            .doc(postId)
            .update({
          'likes': FieldValue.arrayUnion([uid])
        });
      }
      res = 'success';
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  // Post comment
  Future<String> postComment(String postId, String text, String uid,
      String name, String profilePic) async {
    String res = "Some error occurred";
    try {
      if (text.isNotEmpty) {
        // if the likes list contains the user uid, we need to remove it
        String commentId = const Uuid().v1();
        _firestore
            .collection('posts')
            .doc(postId)
            .collection('comments')
            .doc(commentId)
            .set({
          'profilePic': profilePic,
          'name': name,
          'uid': uid,
          'text': text,
          'commentId': commentId,
          'datePublished': DateTime.now(),
        });
        res = 'success';
      } else {
        res = "Please enter text";
      }
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  Future<String> postTimelineComment(String postId, String text, String uid,
      String name, String profilePic, String courseName) async {
    String res = "Some error occurred";
    try {
      if (text.isNotEmpty) {
        // if the likes list contains the user uid, we need to remove it
        String commentId = const Uuid().v1();
        _firestore
            .collection('colleges')
            .doc(authController.superUser.value.institution)
            .collection('courses')
            .doc(courseName)
            .collection('timeline')
            .doc(commentId)
            .set({
          'profilePic': profilePic,
          'name': name,
          'uid': uid,
          'text': text,
          'commentId': commentId,
          'datePublished': DateTime.now(),
        });
        res = 'success';
      } else {
        res = "Please enter text";
      }
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  // Delete Post
  Future<String> deletePost(String postId) async {
    String res = "Some error occurred";
    try {
      await _firestore.collection('posts').doc(postId).delete();
      res = 'success';
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  Future<void> followUser(String uid, String followId) async {
    try {
      DocumentSnapshot snap =
          await _firestore.collection('users').doc(uid).get();
      List following = (snap.data()! as dynamic)['following'];

      if (following.contains(followId)) {
        await _firestore.collection('users').doc(followId).update({
          'followers': FieldValue.arrayRemove([uid])
        });

        await _firestore.collection('users').doc(uid).update({
          'following': FieldValue.arrayRemove([followId])
        });
      } else {
        await _firestore.collection('users').doc(followId).update({
          'followers': FieldValue.arrayUnion([uid])
        });

        await _firestore.collection('users').doc(uid).update({
          'following': FieldValue.arrayUnion([followId])
        });
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
