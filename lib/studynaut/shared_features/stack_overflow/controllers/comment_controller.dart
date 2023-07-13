import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:studynautz/BLOC/Bindings%20and%20Imports/firequickie.dart'
    as auth2;

import '../constants.dart';
import '../models/comment.dart';

class CommentController extends GetxController {
  final Rx<List<Comment>> _comments = Rx<List<Comment>>([]);
  List<Comment> get comments => _comments.value;

  String _questionId = "";

  updatePostId(String id) {
    _questionId = id;
    getComment();
  }

  getComment() async {
    _comments.bindStream(
      firestore
          .collection('stackOverflow')
          .doc(_questionId)
          .collection('comments')
          .snapshots()
          .map(
        (QuerySnapshot query) {
          List<Comment> retValue = [];
          for (var element in query.docs) {
            retValue.add(Comment.fromSnap(element));
          }
          return retValue;
        },
      ),
    );
  }

  postComment(String commentText) async {
    try {
      if (commentText.isNotEmpty) {
        DocumentSnapshot userDoc = await firestore
            .collection('users')
            // .doc(authController.user.uid)
            .doc(auth2.auth.currentUser!.uid)
            .get();
        var allDocs = await firestore
            .collection('videos')
            .doc(_questionId)
            .collection('comments')
            .get();
        int len = allDocs.docs.length;

        Comment comment = Comment(
          username: (userDoc.data()! as dynamic)['nickname'],
          comment: commentText.trim(),
          datePublished: DateTime.now(),
          likes: [],
          profilePhoto: (userDoc.data()! as dynamic)['profilePhoto'],
          // uid: authController.user.uid,
          uid: authController.firebaseUser.value!.uid,
          id: 'Comment $len',
        );
        await firestore
            .collection('stackoverflow')
            .doc(_questionId)
            .collection('comments')
            .doc('Comment $len')
            .set(
              comment.toJson(),
            );
        DocumentSnapshot doc =
            await firestore.collection('stackoverflow').doc(_questionId).get();
        await firestore.collection('stackoverflow').doc(_questionId).update({
          'commentCount': (doc.data()! as dynamic)['commentCount'] + 1,
        });
      }
    } catch (e) {
      Get.snackbar(
        'Error While Commenting',
        e.toString(),
      );
    }
  }

  likeComment(String id) async {
    // var uid = authController.user.uid;
    var uid = authController.firebaseUser.value!.uid;
    DocumentSnapshot doc = await firestore
        .collection('stackoverflow')
        .doc(_questionId)
        .collection('comments')
        .doc(id)
        .get();

    if ((doc.data()! as dynamic)['likes'].contains(uid)) {
      await firestore
          .collection('stackoverflow')
          .doc(_questionId)
          .collection('comments')
          .doc(id)
          .update({
        'likes': FieldValue.arrayRemove([uid]),
      });
    } else {
      await firestore
          .collection('stackoverflow')
          .doc(_questionId)
          .collection('comments')
          .doc(id)
          .update({
        'likes': FieldValue.arrayUnion([uid]),
      });
    }
  }
}
