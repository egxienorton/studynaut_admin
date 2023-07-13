import 'dart:developer';
import 'dart:io';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:studynaut_admin/core/models/superUser.dart';
// import 'package:studynautz/Modelz/superUser2.dart';
// import 'package:studynautz/Models/superUser.dart';
import 'package:studynautz/nerdscout/chatty/widget/socialGX.dart';

import '../helpers/api.dart';
import '../helpers/message.dart';
import 'reply_message_widget.dart';

class NewMessageWidget extends StatefulWidget {
  final FocusNode focusNode;
  final SuperUser superUser;
  final Message? replyMessage;
  final VoidCallback onCancelReply;
  final bool showEmoji;
  final bool isUploading;

  NewMessageWidget({
    required this.focusNode,
    required this.superUser,
    this.replyMessage = null,
    required this.onCancelReply,
    required this.showEmoji,
    required this.isUploading,
    Key? key,
  }) : super(key: key);

  @override
  _NewMessageWidgetState createState() => _NewMessageWidgetState();
}

class _NewMessageWidgetState extends State<NewMessageWidget> {
  late var mq;
  final _controller = TextEditingController();

  ChattyController chattyController = Get.find<ChattyController>();

  String message = '';
  // bool _showEmoji = false, _isUploading = false;

  static const inputTopRadius = Radius.circular(12);
  static const inputBottomRadius = Radius.circular(24);

  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.of(context).size;
    final isReplying = widget.replyMessage != null;

    return Column(
      children: [
        _chatInput(isReplying),
        //show emojis on keyboard emoji button click & vice versa
        if (chattyController.showEmoji.value)
          SizedBox(
            height: mq.height * .35,
            child: EmojiPicker(
              textEditingController: _controller,
              config: Config(
                bgColor: const Color.fromARGB(255, 234, 248, 255),
                columns: 8,
                emojiSizeMax: 32 * (Platform.isIOS ? 1.30 : 1.0),
              ),
            ),
          )
      ],
    );
    // final isReplying = false;

    // return Container(
    //   // color: Colors.white,
    //   // padding: const EdgeInsets.all(),
    //   child: Row(
    //     children: <Widget>[
    //       Expanded(
    //         child: Column(
    //           children: [
    //             if (isReplying) buildReply(),
    //             TextField(
    //               focusNode: widget.focusNode,
    //               controller: _controller,
    //               textCapitalization: TextCapitalization.sentences,
    //               autocorrect: true,
    //               enableSuggestions: true,
    //               decoration: InputDecoration(
    //                 filled: true,
    //                 fillColor: Colors.grey[100],
    //                 hintText: 'Type a message',
    //                 border: OutlineInputBorder(
    //                   borderSide: BorderSide.none,
    //                   borderRadius: BorderRadius.only(
    //                     topLeft: isReplying ? Radius.zero : inputBottomRadius,
    //                     topRight: isReplying ? Radius.zero : inputBottomRadius,
    //                     bottomLeft: inputBottomRadius,
    //                     bottomRight: inputBottomRadius,
    //                   ),
    //                 ),
    //               ),
    //               onChanged: (value) => setState(() {
    //                 message = value;
    //               }),
    //             ),
    //           ],
    //         ),
    //       ),
    //       const SizedBox(width: 10),
    //       GestureDetector(
    //         // onTap: message.trim().isEmpty ? null : sendMessage,
    //         onTap: () async {
    //           if (message.trim().isEmpty) {
    //             return;
    //           } else {
    //             //right now we hard coding text
    //             XAPIs.sendMessage(widget.superUser, message, Type.text,
    //                 widget.replyMessage, context).then((value) => _controller.clear());
    //           }
    //           // message.trim().isEmpty
    //         },
    //         child: Container(
    //           padding: const EdgeInsets.all(8),
    //           decoration: BoxDecoration(
    //             borderRadius: BorderRadius.circular(8),
    //             // color: Colors.blue,
    //           ),
    //           child: const Icon(
    //             Icons.send,
    //             color: Colors.white,
    //             size: 24,
    //           ),
    //         ),
    //       ),
    //     ],
    //   ),
    // );
  }

  Widget _chatInput(isReplying) {
    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: mq.height * .01, horizontal: mq.width * .025),
      child: Column(
        //! This column wasn't present
        children: [
          if (isReplying) buildReply(), //TODO : newly added
          Row(
            children: [
              //input field & buttons
              Expanded(
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  child: Row(
                    children: [
                      //emoji button
                      IconButton(
                          onPressed: () {
                            FocusScope.of(context).unfocus();
                            chattyController.showEmoji.value =
                                !chattyController.showEmoji.value;
                            // setState(() => widget.showEmoji = !widget.showEmoji);
                          },
                          icon: const Icon(Icons.emoji_emotions,
                              color: Colors.blueAccent, size: 25)),

                      Expanded(
                          child: TextField(
                        controller: _controller,
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        onTap: () {
                          // if (_showEmoji) setState(() => _showEmoji = !_showEmoji);
                          if (chattyController.showEmoji.value)
                            !chattyController.showEmoji.value;
                        },
                        decoration: const InputDecoration(
                            hintText: 'Type Something...',
                            hintStyle: TextStyle(color: Colors.blueAccent),
                            border: InputBorder.none),
                      )),

                      //pick image from gallery button
                      IconButton(
                          onPressed: () async {
                            final ImagePicker picker = ImagePicker();

                            // Picking multiple images
                            final List<XFile> images =
                                await picker.pickMultiImage(imageQuality: 70);

                            // uploading & sending image one by one
                            for (var i in images) {
                              log('Image Path: ${i.path}');
                              // setState(() => _isUploading = true);
                              chattyController.isUploading.value = true;
                              await XAPIs.sendChatImage(widget.superUser,
                                  File(i.path), widget.replyMessage, context);
                              // setState(() => _isUploading = false);
                              chattyController.toggleUploading();
                            }
                          },
                          icon: const Icon(Icons.image,
                              color: Colors.blueAccent, size: 26)),

                      //take image from camera button
                      IconButton(
                          onPressed: () async {
                            final ImagePicker picker = ImagePicker();

                            // Pick an image
                            final XFile? image = await picker.pickImage(
                                source: ImageSource.camera, imageQuality: 70);
                            if (image != null) {
                              log('Image Path: ${image.path}');
                              setState(() =>
                                  chattyController.isUploading.value = true);
                              // setState(() => _isUploading = true);

                              await XAPIs.sendChatImage(
                                  widget.superUser,
                                  File(image.path),
                                  widget.replyMessage,
                                  context);
                              setState(() =>
                                  chattyController.isUploading.value = false);
                            }
                          },
                          icon: const Icon(Icons.camera_alt_rounded,
                              color: Colors.blueAccent, size: 26)),

                      //adding some space
                      SizedBox(width: mq.width * .02),
                    ],
                  ),
                ),
              ),

              //send message button
              MaterialButton(
                onPressed: () {
                  if (_controller.text.isNotEmpty) {
                    XAPIs.sendMessage(widget.superUser, _controller.text,
                        Type.text, widget.replyMessage, context);
                    //TODO: Check back later
                    // if (_list.isEmpty) {
                    //   //on first message (add user to my_user collection of chat user)
                    //   APIs.sendFirstMessage(
                    //       widget.user, _textController.text, Type.text);
                    // } else {
                    //   //simply send message
                    //   APIs.sendMessage(
                    //       widget.user, _textController.text, Type.text);
                    // }
                    _controller.text = '';
                  }
                },
                minWidth: 0,
                padding: const EdgeInsets.only(
                    top: 10, bottom: 10, right: 5, left: 10),
                shape: const CircleBorder(),
                color: Colors.green,
                child: const Icon(Icons.send, color: Colors.white, size: 28),
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget buildReply() => Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.2),
          borderRadius: BorderRadius.only(
            topLeft: inputTopRadius,
            topRight: inputTopRadius,
          ),
        ),
        child: ReplyMessageWidget(
          message: widget.replyMessage!,
          onCancelReply: widget.onCancelReply,
        ),
      );
}
