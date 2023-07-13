import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:studynaut_admin/core/models/superUser.dart';

// import '../../../../../../BLOC/Bindings and Imports/firequickie.dart';
import '../../../stack_overflow/constants.dart';
// import '../../../Models/superUser.dart';

class FriendController extends GetxController {
  // Rx<List<NoobieModel>> courselist = Rx<List<NoobieModel>>([]);
  Rx<List<SuperUser>> courselist = Rx<List<SuperUser>>([]);
  var isLoading = false.obs;
  final TextEditingController _search = TextEditingController();

  void onSearch() async {
    isLoading.value = true;

    await firestore
        .collection('users')
        .where("firstName", isEqualTo: _search.text)
        .get()
        .then((value) {
      // userMap = value.docs[0].data();

      isLoading.value = false;

      // print(userMap);
    });
  }
}
