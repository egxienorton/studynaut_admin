import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../social/feeds/models/user.dart' as model;
// import '../providers/user_provider.dart';
import '../../social/feeds/resources/firestore_methods.dart';

import '../../social/feeds/utils/utils.dart';
import 'details_page.dart';

class NewsCard extends StatefulWidget {
  final snap;
  const NewsCard({
    Key? key,
    required this.snap,
  }) : super(key: key);

  @override
  State<NewsCard> createState() => _NewsCardState();
}

class _NewsCardState extends State<NewsCard> {
  int commentLen = 0;
  bool isLikeAnimating = false;

  @override
  void initState() {
    super.initState();
    fetchCommentLen();
  }

  fetchCommentLen() async {
    try {
      QuerySnapshot snap = await FirebaseFirestore.instance
          .collection('news')
          .doc(widget.snap['postId'])
          .collection('comments')
          .get();
      commentLen = snap.docs.length;
    } catch (err) {
      showSnackBar(
        context,
        err.toString(),
      );
    }
    setState(() {});
  }

  deletePost(String postId) async {
    try {
      await FireStoreMethods().deletePost(postId);
    } catch (err) {
      showSnackBar(
        context,
        err.toString(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // final model.User user = Provider.of<UserProvider>(context).getUser;
    final width = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: () {
        Get.to(() => NewsInDetail(), arguments: [
          {
            'title': widget.snap['title'].toString(),
            'postId': widget.snap['postId'].toString(),
            'content': widget.snap['content'].toString(),
            'postUrl': widget.snap['postUrl'].toString(),
          }
        ]);
      },
      child: Padding(
        padding: const EdgeInsets.all(25.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(25.0),
          child: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(widget.snap['postUrl'].toString()))),
            padding: const EdgeInsets.all(12),
            height: 200,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  widget.snap['title'].toString(),
                  style: const TextStyle(fontSize: 20, color: Colors.white),
                ),
                Text(
                  widget.snap['description'].toString(),
                  style: const TextStyle(fontSize: 10, color: Colors.white),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
