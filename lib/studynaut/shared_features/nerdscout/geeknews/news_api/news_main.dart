import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:uuid/uuid.dart';

import '../../../BLOC/Bindings and Imports/firequickie.dart';
import 'news.dart';
import 'news_card.dart';

/// add the liquid pull to refresh later on
class NewsFeedScreen extends StatefulWidget {
  const NewsFeedScreen({Key? key}) : super(key: key);

  @override
  State<NewsFeedScreen> createState() => _NewsFeedScreenState();
}

class _NewsFeedScreenState extends State<NewsFeedScreen> {
  Future<String> uploadNews(
      String description, String title, String content) async {
    // asking uid here because we dont want to make extra calls to firebase auth when we can just get from our state management
    String res = "Some error occurred";
    try {
      String photoUrl =
          'https://images.unsplash.com/photo-1498677231914-50deb6ba4217?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=870&q=80';

      String postId = const Uuid().v1(); // creates unique id based on time
      NewsPost news = NewsPost(
        description: description,
        title: title,
        content: content,
        postId: postId,
        postUrl: photoUrl,
      );
      firestore.collection('news').doc(postId).set(news.toJson());
      res = "success";
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        // backgroundColor: mobileBackgroundColor,
        centerTitle: true,

        title: const Text('News for you'),
        actions: [
          IconButton(
              onPressed: () async {
                uploadNews(
                    'Asuu call off strike',
                    'Students beefing up th gates',
                    'The federal government has finally heeded to the aid of the Academic union of Staffs on July ');
              },
              icon: const Icon(Icons.send))
        ],
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('news').snapshots(),
        builder: (context,
            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data!.docs.length == 0) {
              return const Center(
                child: Text('Try sub e get why'),
              );
            } else {
              return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (ctx, index) => Container(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 0,
                    vertical: 0,
                  ),
                  child: NewsCard(
                    snap: snapshot.data!.docs[index].data(),
                  ),
                ),
              );
            }
          } else {
            return const Center(
              child: Text('Please wait'),
            );
          }
        },
      ),
    );
  }
}
