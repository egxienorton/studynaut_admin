import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../constants.dart';
import '../models/video.dart';

class StackOverflowController extends GetxController {
  final Rx<List<StackQuestion>> _questionList = Rx<List<StackQuestion>>([]);

  List<StackQuestion> get questionList => _questionList.value;

  @override
  void onInit() {
    super.onInit();
    _questionList.bindStream(firestore
        .collection('stackoverflow')
        .snapshots()
        .map((QuerySnapshot query) {
      List<StackQuestion> retVal = [];
      for (var element in query.docs) {
        retVal.add(
          StackQuestion.fromSnap(element),
        );
      }
      return retVal;
    }));
  }

  likeQuestion(String id) async {
    DocumentSnapshot doc = await firestore.collection('stackoverflow').doc(id).get();
    // var uid = authController.user.uid;
    var uid = authController.firebaseUser.value!.uid;
    if ((doc.data()! as dynamic)['likes'].contains(uid)) {
      await firestore.collection('stackoverflow').doc(id).update({
        'likes': FieldValue.arrayRemove([uid]),
      });
    } else {
      await firestore.collection('stackoverflow').doc(id).update({
        'likes': FieldValue.arrayUnion([uid]),
      });
    }
  }
}
