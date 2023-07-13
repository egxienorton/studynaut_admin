import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:studymaze/UTILITIES/social_utils.dart';

class MessageField {
  static final String message = 'message';
  static final String createdAt = 'createdAt';
}

enum Type { text, image }

class Message {
  // late final String id;
  // late final String avatarUrl;
  // late final String firstName;
  late final String message;
  // late final String createdAt; // former type DateTime
  late final Message? replyMessage;

  //NEW
  late final String fromId; //see which one make id above redundant
  late final String toId;
  late final String read;
  late final String sent;
  late final Type type;

  Message({
    // this.id,
    // required this.avatarUrl,
    // required this.firstName,
    required this.message,
    required this.fromId,
    required this.toId,
    required this.read,
    required this.sent,
    // required this.createdAt,
    required this.type,
    this.replyMessage,
  });

  Message.fromJson(Map<String, dynamic> json) {
    // id = json['id'];
    // avatarUrl = json['avatarUrl'];
    // firstName = json[
    //     'firstName']; // instead of using a firstName .. how about a nickName that can be changed.. base this on uid!
    message = json['message'];
    // createdAt = Utils.toDateTime(json['createdAt']);
    toId = json['toId'].toString();
    read = json['read'].toString();
    type = json['type'].toString() == Type.image.name ? Type.image : Type.text;
    fromId = json['fromId'].toString();
    sent = json['sent'].toString();
    replyMessage = json['replyMessage'] == null
        ? null
        : Message.fromJson(json['replyMessage']);
  }

  // static Message fromJson(Map<String, dynamic> json) => Message(
  //     id: json['id'],
  //     avatarUrl: json['avatarUrl'],
  //     firstName: json[
  //         'firstName'], // instead of using a firstName .. how about a nickName that can be changed.. base this on uid!
  //     message: json['message'],
  //     type: json['type'],

  //     createdAt: Utils.toDateTime(json['createdAt']),
  //     replyMessage: json['replyMessage'] == null
  //         ? null
  //         : Message.fromJson(json['replyMessage']));

  //! This method may be deprecated
  Message.fromDocumentSnapshot(
      QueryDocumentSnapshot<Map<String, dynamic>> snapshot)
      : type = snapshot['type'].toString() == Type.image.name
            ? Type.image
            : Type.text,
        message = snapshot['message'],
        fromId = snapshot['fromId'],
        toId = snapshot['toId'],
        read = snapshot['read'],
        sent = snapshot['sent'],
        // replyMessage = snapshot['replyMessage'] ;
        // replyMessage = Message.fromJson(snapshot['replyMessage']);
        replyMessage = snapshot['replyMessage'] == null
            ? null
            : Message.fromJson(snapshot['replyMessage']);

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['toId'] = toId;
    data['message'] = message;
    data['read'] = read;
    data['type'] = type.name;
    data['fromId'] = fromId;
    data['sent'] = sent;
    data['replyMessage'] = replyMessage == null ? null : replyMessage!.toJson();
    return data;
  }

  // Map<String, dynamic> toJson() => {
  //       'id': id,
  //       'avatarUrl': avatarUrl,
  //       'firstName': firstName,
  //       'message': message,
  //       'type': type,
  //       'createdAt': Utils.fromDateTimeToJson(createdAt),
  //       'replyMessage': replyMessage == null ? null : replyMessage!.toJson(),
  //     };
}
