import 'package:cloud_firestore/cloud_firestore.dart';

class NewsPost {
  final String description;
  final String title;
  final String postId;
  final String postUrl;
  final String content;

  const NewsPost(
      {required this.description,
        required this.title,
        required this.postId,
        required this.postUrl,
        required this.content,
      });

  static NewsPost fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return NewsPost(
        description: snapshot["description"],
        postId: snapshot["postId"],
        title: snapshot["title"],
        postUrl: snapshot['postUrl'],
        content: snapshot['profImage']
    );
  }

  Map<String, dynamic> toJson() => {
    "description": description,
    "title": title,
    "postId": postId,
    'postUrl': postUrl,
    'content': content
  };
}
