import 'package:cloud_firestore/cloud_firestore.dart';

class TimelineModel {
  String uid;
  String timelineId;
  String author;
  String title;
  String department;
  String description;
  String coverPhoto;
  final likes;
  final String postUrl;
  final DateTime datePublished;

  // a student user will only be allowed to upload one singleton post item to the timeline.. We'll batch that up soon

  TimelineModel(
      this.uid,
      this.timelineId,
      this.author,
      this.title,
      this.department,
      this.description,
      this.coverPhoto,
      this.likes,
      this.postUrl,
      this.datePublished
      // this.format,
      );

  TimelineModel.fromDocumentSnapshot(
      QueryDocumentSnapshot<Map<String, dynamic>> snapshot)
      : uid = snapshot['uid'],
        timelineId = snapshot['timelineId'],
        author = snapshot['author'],
        title = snapshot['title'],
        department = snapshot['department'],
        description = snapshot['description'],
        coverPhoto = snapshot['coverPhoto'],
        likes = snapshot['likes'],
        postUrl = snapshot['postUrl'],
        datePublished = snapshot['datePublished'];

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "timelineId": timelineId,
        "author": author,
        "title": title,
        "department": department,
        "description": description,
        "coverPhoto": coverPhoto,
        "likes": likes,
        "postUrl": postUrl,
        "datePublished": datePublished,
      };
}
