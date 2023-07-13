import 'package:get/get.dart';

class ChattyController extends GetxController {
  var isUploading = false.obs;

  var showEmoji = false.obs;

  void toogleEmoji() {
    showEmoji.value = !showEmoji.value;
  }

  void toggleUploading() {
    isUploading.value = !isUploading.value;
  }
}
