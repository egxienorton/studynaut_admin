// import 'package:carbon_icons/carbon_icons.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:studynaut_admin/core/models/superUser.dart';
// import 'package:studynautz/BLOC/Bindings%20and%20Imports/firequickie.dart';
// import 'package:studynautz/Models/superUser.dart';
// import 'package:studynautz/Models/userGen.dart';
// import 'package:studynautz/Modelz/superUser2.dart';

import '../../social/feeds/utils/txtTransformer.dart';

class FindFriends extends StatefulWidget {
  FindFriends({Key? key}) : super(key: key);

  @override
  State<FindFriends> createState() => _FindFriendsState();
}

class _FindFriendsState extends State<FindFriends> {
  Map<String, dynamic>? userMap;
  // List<NoobieModel> retVal = [];
  List<SuperUser> retVal = [];
  List<UserGen> responseList = [];
  bool isLoading = false;
  bool isSearching = false;
  final TextEditingController _search = TextEditingController();

  void onSearch() async {
    if (_search.text == '') {
      return;
    } else {
      setState(() {
        isSearching = true;
      });
      responseList.clear();
      await FirebaseFirestore.instance
          .collection('users')
          .where("firstName", isEqualTo: _search.text.toLowerCase())
          // .where('lastName', isEqualTo: _search.text.toLowerCase())
          .get()
          .then((value) {
        print(value);
        if (value != null) {
          var responder = value.docs.map((e) => UserGen.fromSearch(e));

          if (responder != null) {
            responseList.addAll(responder);
            setState(() {
              isSearching = false;
            });
          }

          // print(value.docs[0].data());
          print(responder);
          print(responseList);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: Column(
        children: [
          Container(
            margin: const EdgeInsets.all(12),
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                color: Colors.grey.shade200),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _search,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(
                          width: 0,
                          style: BorderStyle.none,
                        ),
                      ),
                      hintText: "Look for your friends here",
                      hintStyle: const TextStyle(
                        fontFamily: 'Product Sans',
                        color: Colors.black,
                      ),
                      enabledBorder: const OutlineInputBorder(
                        borderSide:
                            BorderSide(width: 3, color: Colors.transparent),
                      ),
                      // focusedBorder: OutlineInputBorder(
                      //   borderSide: BorderSide(
                      //       width: 1, color: Color.fromARGB(255, 10, 3, 5)),
                      // ),
                      errorBorder: const OutlineInputBorder(
                        borderSide: BorderSide(
                            width: 3, color: Color.fromARGB(255, 66, 125, 145)),
                      ),
                    ),
                  ),
                ),
                IconButton(
                  color: Colors.black,
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  onPressed: onSearch,
                  icon: const Icon(IconlyBold.search),
                ),
              ],
            ),
          ),
          responseList.isNotEmpty
              ? Expanded(
                  // height: 400,
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: responseList.length,
                      itemBuilder: ((context, index) {
                        final person = responseList[index];
                        return ListTile(
                          leading:
                              const CircleAvatar(child: Icon(Icons.person_add)),
                          onTap: () async {
                            Get.to(() => ViewPerson(uid: person.uid));
                          },
                          trailing: Column(
                            children: [
                              const Text('View Profile'),
                              const Icon(IconlyBold.activity)
                            ],
                          ),
                          title: Text(
                            capitalizeAllSentence(
                                '${person.firstName} ${person.lastName}'),
                            style: const TextStyle(fontFamily: 'Product Sans'),
                          ),
                          subtitle: const Text('Faculty of Arts'),
                        );
                      })),
                )
              : isSearching
                  ? Expanded(
                      child: Center(
                          child: LoadingAnimationWidget.inkDrop(
                        color: const Color.fromARGB(255, 43, 190, 23),
                        // rightDotColor: Color.fromARGB(255, 197, 149, 175),
                        size: 40,
                      )),
                    )
                  : _search.text == ''
                      ? const Expanded(
                          child: Center(
                            child: Text(
                              'Search the name of someone you know',
                              style: TextStyle(fontFamily: 'Product Sans'),
                            ),
                          ),
                        )
                      : responseList.isEmpty
                          ? Column(
                              children: [
                                Container(
                                  // padding: EdgeInsets.all(10),
                                  child: Image.network(
                                    'https://img.freepik.com/free-vector/oversight-concept-illustration_114360-11565.jpg?w=740&t=st=1676891867~exp=1676892467~hmac=5f5913a91debfe29f9785fae2ba817ecdf943935e7566c923f98e9afbefb110d',
                                    height:
                                        MediaQuery.of(context).size.height / 2,
                                    width:
                                        MediaQuery.of(context).size.width / 2,
                                  ),
                                ),
                                const Text(
                                  'No friends found',
                                  style: TextStyle(
                                      fontFamily: 'Product Sans', fontSize: 18),
                                )
                              ],
                            )
                          : _search.text == ''
                              ? const Expanded(
                                  child: Center(
                                    child: Text('Search!!'),
                                  ),
                                )
                              : Center(
                                  child: Image.network(
                                    'https://img.freepik.com/free-vector/oversight-concept-illustration_114360-11565.jpg?w=740&t=st=1676891867~exp=1676892467~hmac=5f5913a91debfe29f9785fae2ba817ecdf943935e7566c923f98e9afbefb110d',
                                  ),
                                )
        ],
      )),
    );
  }
}

class ViewPerson extends StatefulWidget {
  final String uid;
  const ViewPerson({Key? key, required this.uid}) : super(key: key);

  @override
  State<ViewPerson> createState() => _ViewPersonState();
}

class _ViewPersonState extends State<ViewPerson> {
  Map<String, dynamic> profileMap = {};
  Map<String, dynamic> userProfileMap = {};

  @override
  void initState() {
    // TODO: implement initState
    fishOut();
    getMyCredentials();
  }

  void addFriend(String uid) async {
    await firestore.collection('users').doc(uid)
      ..update({
        'requests': FieldValue.arrayUnion([auth.currentUser!.uid])
        // 'friendRequests': FieldValue.arrayUnion([uid])
      });

    Get.snackbar('Yay!', 'Friend request sent');
  }

  void reverseInjectionRequest(String target, String client) async {
    await firestore.collection('users').doc(target)
      ..update({
        'requests': FieldValue.arrayUnion([client])
        // 'friendRequests': FieldValue.arrayUnion([uid])
      });
  }

  void reverseInjectionAcceptRequest(String target, String client) async {
    await firestore.collection('users').doc(target)
      ..update({
        'requests': FieldValue.arrayRemove([client])
        // 'friendRequests': FieldValue.arrayUnion([uid])
      });
  }

  void acceptRequestByReverseShell(String sender, String receiver) async {
    try {
      // Step 1:  for the person accepting the request
      await firestore
          .collection('users')
          .doc(receiver)
          .collection('friends')
          .doc()
          .set({
        // "": "",
        // bro forget about other dynamic fields and do static only..
        "id": sender,

        // "firstName"
      });

      // for the requester
      await firestore
          .collection('users')
          .doc(sender)
          .collection('friends')
          .doc()
          .set({
        // "": "",
        // bro forget about other dynamic fields and do static only..
        "id": receiver,
      });

      await firestore.collection('users').doc(receiver)
        ..update({
          'requests': FieldValue.arrayRemove([sender])
        });

      // add to friend list
      await firestore.collection('users').doc(receiver)
        ..update({
          // 'friendRequests': FieldValue.arrayUnion([uid])
          'friends': FieldValue.arrayUnion([sender])
        });

      await firestore.collection('users').doc(sender)
        ..update({
          'requests': FieldValue.arrayRemove([receiver])
        });

      // add to friend list
      await firestore.collection('users').doc(sender)
        ..update({
          // 'friendRequests': FieldValue.arrayUnion([uid])
          'friends': FieldValue.arrayUnion([receiver])
        });
    } catch (e) {}
  }

  void acceptFriendRequest(String uid) async {
    // you have to create a collection in the user and the friend in question when the handshake happen

    // for the person accepting the request
    try {
      await firestore
          .collection('users')
          .doc(auth.currentUser!.uid)
          .collection('friends')
          .doc()
          .set({
        // "": "",
        // bro forget about other dynamic fields and do static only..
        "id": uid,
        // "firstName"
      });
      // for the requester
      await firestore
          .collection('users')
          .doc(uid)
          .collection('friends')
          .doc()
          .set({
        // "": "",
        // bro forget about other dynamic fields and do static only..
        "id": auth.currentUser!.uid,
        // "firstName"
      });

      //remove from friend requests

      // TODO:  when a person block one, this invokes the master collection and also the document fields and wipes the data away..

      // remove from requests
      await firestore.collection('users').doc(uid)
        ..update({
          'requests': FieldValue.arrayRemove([uid])
        });

      // add to friend list
      await firestore.collection('users').doc(uid)
        ..update({
          // 'friendRequests': FieldValue.arrayUnion([uid])
          'friends': FieldValue.arrayUnion([uid])
        });
    } catch (e) {
      // TODO: Use a better dialog for this
      Get.snackbar('Check your network', 'And try again');
    }
  }

  void getMyCredentials() async {
    await firestore
        .collection('users')
        .doc(auth.currentUser!.uid)
        .get()
        .then((value) {
      // var data = value.docs[0].data();
      var fetchedData = value.data();
      // dynamic level = fetchedData['level'];
      print('Wait while we fetch the user data');
      print(fetchedData);
      // print(level);

      userProfileMap.addAll(fetchedData!);

      setState(() {});
    });
  }

  void fishOut() async {
    late dynamic studentModel;
    await firestore
        .collection('users')
        .where("id", isEqualTo: widget.uid)
        .get()
        .then((value) {
      // var data = value.docs[0].data();
      var fetchedData = value.docs[0].data();
      dynamic level = fetchedData['level'];
      print(fetchedData);
      print(level);

      profileMap.addAll(fetchedData);
      // var level = UserLevel.fromDocumentMap(data);
      // print(level.toJson()['value']);
      // var userLevel = level.toJson()['value'];

      // if (userLevel == "prime") {
      //   studentModel = PrimeModel.fromDocumentMap(data);
      // } else if (userLevel == "erudite") {
      //   // studentModel = EruditeModel.fromDocumentMap(data);
      // } else if (userLevel == "noobie") {
      //   // studentModel = NoobieModel.fromDocumentMap(data);
      // }

      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.uid),
          actions: [
            IconButton(
                onPressed: () {
                  reverseInjectionRequest('RoLHGn2x65a9Eg5WzcRU3cn3GHG3',
                      'YjJ3X27ojqSRtWIiH8DHVYkX1Ci2');
                },
                icon: const Icon(Icons.pause)),
            IconButton(
                onPressed: () {
                  reverseInjectionAcceptRequest('RoLHGn2x65a9Eg5WzcRU3cn3GHG3',
                      'YjJ3X27ojqSRtWIiH8DHVYkX1Ci2');
                },
                icon: const Icon(IconlyBold.play)),
            IconButton(
                onPressed: () {
                  acceptRequestByReverseShell('RoLHGn2x65a9Eg5WzcRU3cn3GHG3',
                      'YjJ3X27ojqSRtWIiH8DHVYkX1Ci2');
                },
                icon: const Icon(IconlyBold.graph))
          ],
        ),
        body: profileMap.isEmpty
            ? Center(
                child: LoadingAnimationWidget.twistingDots(
                  leftDotColor: const Color.fromARGB(255, 43, 190, 23),
                  rightDotColor: const Color.fromARGB(255, 197, 149, 175),
                  size: 160,
                ),
              )
            : Column(
                children: [
                  Stack(
                    clipBehavior: Clip.none,
                    // -
                    //- this line is just incompatible with the new dart version
                    alignment: Alignment.bottomCenter,
                    children: [
                      Container(
                        decoration: const BoxDecoration(
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(
                                    "https://images.pexels.com/photos/96381/pexels-photo-96381.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1"))),
                        height: 220,
                        // child: Con,
                      ),
                      Positioned(
                        top: 150,
                        child: Container(
                            height: 150,
                            width: 150,
                            decoration: BoxDecoration(
                                image: const DecorationImage(
                                    image: NetworkImage(
                                        "https://media.istockphoto.com/vectors/african-american-woman-feels-anxiety-and-emotional-stress-depressed-vector-id1326112129?k=20&m=1326112129&s=612x612&w=0&h=aQ3gYnQhFaJhpPRZKe8YGLkgJClVNsTXnXw0vcyQjcE="),
                                    fit: BoxFit.cover),
                                color: Colors.green,
                                borderRadius: BorderRadius.circular(100),
                                border:
                                    Border.all(color: Colors.white, width: 5))),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 75,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        capitalizeAllSentence(
                            '${profileMap['firstName']} ${profileMap['lastName']}'),
                        style: const TextStyle(
                            fontFamily: 'Product Sans', fontSize: 23),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Faculty of ${profileMap['faculty']}',
                        style: const TextStyle(
                            fontFamily: 'Product Sans', fontSize: 12),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Department of ${profileMap['department']}',
                        style: const TextStyle(
                            fontFamily: 'Product Sans', fontSize: 12),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 39,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap: () async {
                          // var userSnap = await FirebaseFirestore.instance
                          //     .collection('users')
                          //     .doc(auth.currentUser!.uid)
                          //     .get();
                          // bool isFriend = userSnap
                          //     .data()!['friends']
                          //     .contains(profileMap['id']);
                          bool isFriend = profileMap['friends']
                              .contains(userProfileMap['id']);
                          if (isFriend) {
                            print('this person is your friend');
                          } else {
                            addFriend(profileMap['id']);
                          }
                        },
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Container(
                            padding: const EdgeInsets.all(16),
                            color: userProfileMap['friends'] != null &&
                                    userProfileMap['friends']
                                        .contains(profileMap['id'])
                                ? Colors.redAccent
                                : Colors.white,
                            child: const Icon(
                              IconlyBold.star,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Container(
                          color: Colors.amber,
                          padding: const EdgeInsets.all(16),
                          child: const Icon(
                            IconlyBold.discovery,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Container(
                          color: Colors.greenAccent,
                          padding: const EdgeInsets.all(16),
                          child: const Icon(
                            IconlyBold.category,
                            color: Colors.black,
                          ),
                        ),
                      )
                    ],
                  )
                ],
              )

        // FutureBuilder(
        //     future: firestore
        //         .collection('users')
        //         .where("id", isEqualTo: widget.uid)
        //         .get(),
        //     builder: (context, snapshot) {
        //       if (snapshot.hasError) {
        //         return Center(child: Text('Error E-16'));
        //       }
        //       if (snapshot.connectionState == ConnectionState.done) {
        //         print(snapshot..toString());
        //         return Center(child: Text('Spinning up the server '));
        //       }
        //       return Container(
        //           child: Center(
        //         child: Text('Hello Planet'),
        //       ));
        //     }),
        );
  }
}
