// import 'package:carbon_icons/carbon_icons.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:coolicons/coolicons.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import 'package:studynaut_admin/core/models/superUser.dart';
// import 'package:studynautz/Modelz/superUser2.dart';
// import 'package:studynautz/Models/student.dart'
// import 'package:studynautz/Models/student.dart';

// import '../../../Models/student.dart' as StudentUser;
// import '../../../Models/superUser.dart';
import '../helpers/xBase.dart';
import '../widget/chat_body_widget.dart';

import '../widget/socialGX.dart';
import 'find_friends.dart';

class JMChatsPage extends StatefulWidget {
  @override
  State<JMChatsPage> createState() => _JMChatsPageState();
}

class _JMChatsPageState extends State<JMChatsPage> with WidgetsBindingObserver {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  ChattyController controller = Get.put(ChattyController());

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addObserver(this);
    setStatus("Online");
  }

  void setStatus(String status) async {
    await _firestore.collection('users').doc(_auth.currentUser!.uid).update({
      "status": status,
    });
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      // online
      setStatus("Online");
    } else {
      // offline
      setStatus("Offline");
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Colors.white,
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            Get.to(() => FindFriends());
          },
          child: const Icon(
            IconlyBold.work,
            size: 24,
          ),
        ),
        body: SafeArea(
          child: StreamBuilder<List<SuperUser>>(
            // stream: XBase.getUsers(),
            stream: XBase.getFriends(),
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  return const Center(child: CircularProgressIndicator());
                default:
                  if (snapshot.hasError) {
                    print(snapshot.error);

                    // return buildText('Something Went Wrong Try later');
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: buildText(snapshot.error.toString().toUpperCase()),
                    );
                  } else {
                    final users = snapshot.data;

                    if (users!.isEmpty) {
                      print(users);
                      return Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Image.network(
                                'https://img.freepik.com/free-vector/young-friends-waving-hand_23-2148363174.jpg?w=740&t=st=1676886226~exp=1676886826~hmac=bfde866cd56c9f441dd93c7541d06e447058c735a69687f452de87a0036bce78'),
                          ),
                          const Text(
                            'You don\'t seem to have any friends yet. Begin by making some friends',
                            style: TextStyle(fontFamily: 'Product Sans'),
                            textAlign: TextAlign.center,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 100.0, vertical: 10),
                            child: ElevatedButton(
                                onPressed: () {
                                  Get.to(() => FindFriends());
                                },
                                child: Row(
                                  children: [
                                    const Icon(IconlyBold.search),
                                    const Text(
                                      'Find Friends',
                                      style:
                                          TextStyle(fontFamily: 'Product Sans'),
                                    )
                                  ],
                                )),
                          )
                        ],
                      );
                    } else {
                      return DefaultTabController(
                        length: 2,
                        child: Scaffold(
                          appBar: AppBar(
                            automaticallyImplyLeading: false,
                            title: const Text('N-Zone'),
                            actions: [
                              PopupMenuButton(
                                itemBuilder: (BuildContext context) {
                                  return [
                                    const PopupMenuItem<String>(
                                        child: Text('My friends')),
                                    const PopupMenuItem<String>(
                                        child: Text('Settings')),
                                    const PopupMenuItem<String>(
                                        child: Text('Add more')),
                                  ];
                                },
                                onSelected: (value) {
                                  Get.back();
                                  Get.snackbar('You selected', '$value');
                                },
                              )
                            ],
                            bottom: const TabBar(tabs: [
                              Tab(
                                child: Text('Chats'),
                              ),
                              Tab(
                                child: Text('Groups'),
                              ),
                              // Tab(
                              //   child: Text('Chats'),
                              // ),
                            ]),
                          ),
                          body: TabBarView(
                            children: [
                              // ChatHeaderWidget(users: users),
                              ChatBodyWidget(users: users),
                              Center(
                                child: Text('Gro'),
                              )
                            ],
                          ),
                        ),
                      );
                    }
                  }
              }
            },
          ),
        ),
      );

  Widget buildText(String text) => Center(
        child: Text(
          text,
          style: const TextStyle(
              fontSize: 20, color: Colors.black, fontFamily: 'Product Sans'),
        ),
      );
}
