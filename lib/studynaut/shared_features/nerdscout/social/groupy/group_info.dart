import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import '../../../core/wizzy/xDialogs.dart';
import 'widgets.dart';

import 'database_service.dart';
import 'start_page.dart';

class GroupInfo extends StatefulWidget {
  final String groupId;
  final String groupName;
  final List admins;
  final List groupMembers;

  const GroupInfo({
    Key? key,
    required this.admins,
    required this.groupName,
    required this.groupId,
    required this.groupMembers,
  }) : super(key: key);

  @override
  State<GroupInfo> createState() => _GroupInfoState();
}

class _GroupInfoState extends State<GroupInfo> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  // Stream? members;
  @override
  void initState() {
    // getMembers();
    super.initState();
  }

  // getMembers() async {
  //   DatabaseService(uid: FirebaseAuth.instance.currentUser!.uid)
  //       .getGroupMembers(widget.groupId)
  //       .then((val) {
  //     setState(() {
  //       members = val;
  //     });
  //   });
  // }

  // String getName(String r) {
  //   return r.substring(r.indexOf("_") + 1);
  // }

  // String getId(String res) {
  //   return res.substring(0, res.indexOf("_"));
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: SafeArea(
        child: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              title: Text(widget.groupName),
              actions: [
                IconButton(
                    onPressed: () {
                      showDialog(
                          barrierDismissible: false,
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: const Text("Exit"),
                              content: const Text(
                                  "Are you sure you exit the group? "),
                              actions: [
                                IconButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  icon: const Icon(
                                    Icons.cancel,
                                    color: Colors.red,
                                  ),
                                ),
                                IconButton(
                                  onPressed: () async {
                                    //TODO: Some spaghetti functions here
                                  },
                                  icon: const Icon(
                                    Icons.done,
                                    color: Colors.green,
                                  ),
                                ),
                              ],
                            );
                          });
                    },
                    icon: const Icon(Icons.exit_to_app))
              ],
              automaticallyImplyLeading: false,
              expandedHeight: 200, // Set the desired height for the app bar
              flexibleSpace: Image.network(
                'https://media.istockphoto.com/id/1414744533/photo/woman-hand-holding-credit-cards-and-using-smartphone-for-shopping-online-with-payment-on.jpg?b=1&s=170667a&w=0&k=20&c=3EYPAKeQbFEgiK7ED-f2nM_9khgvdYxV0u5Uzq7EahY=', // Replace with your own image path
                fit: BoxFit.cover,
              ),
            ),
            SliverList(
              delegate: SliverChildListDelegate([
                ...widget.groupMembers.map((e) =>
                    FutureBuilder<DocumentSnapshot>(
                      future: FirebaseFirestore.instance
                          .collection('users')
                          .doc(e)
                          .get(),
                      builder: (BuildContext context,
                          AsyncSnapshot<DocumentSnapshot> snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(
                            child: LoadingAnimationWidget.waveDots(
                                size: 28, color: Colors.green),
                          );
                        } else if (snapshot.hasError) {
                          return Center(
                            child: Text('Error: ${snapshot.error}'),
                          );
                        } else {
                          if (snapshot.hasData && snapshot.data!.exists) {
                            // Document exists and data has been fetched successfully
                            DocumentSnapshot documentSnapshot = snapshot.data!;

                            return Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: 8.0, horizontal: 4),
                              decoration: BoxDecoration(
                                // color: Colors.grey,
                                border:
                                    Border.all(color: Colors.grey, width: 1.0),
                                borderRadius: BorderRadius.circular(16.0),
                              ),
                              child: ListTile(
                                onTap: () {
                                  ExDialogs.showSnackbar(
                                      _scaffoldKey.currentContext!,
                                      'Pick me admin!');
                                },
                                title: Text(documentSnapshot
                                    .get('firstName')
                                    .toString()),
                                trailing: FutureBuilder<bool>(
                                  future: DatabaseService.checkIfAdmin(
                                      widget.groupId, e),
                                  builder: (BuildContext context,
                                      AsyncSnapshot<bool> snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return LoadingAnimationWidget.waveDots(
                                        color: Colors.grey,
                                        size: 8,
                                      );
                                    } else if (snapshot.hasError) {
                                      return Text('Error: ${snapshot.error}');
                                    } else {
                                      bool isAdmin = snapshot.data ?? false;
                                      if (isAdmin) {
                                        return Container(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 8.0, horizontal: 2),
                                          decoration: BoxDecoration(
                                            // color: Colors.grey,
                                            border: Border.all(
                                                color: Colors.grey, width: 1.0),
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                          ),
                                          child: const Positioned(
                                            top: -5,
                                            child: Text(
                                              'Admin',
                                              style: TextStyle(
                                                  fontSize: 8,
                                                  color: Colors.green),
                                            ),
                                          ),
                                        );
                                      } else {
                                        return Container(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 8.0, horizontal: 4),
                                          decoration: BoxDecoration(
                                            // color: Colors.grey,
                                            border: Border.all(
                                                color: Colors.grey, width: 1.0),
                                            borderRadius:
                                                BorderRadius.circular(16.0),
                                          ),
                                          child: Text('Not an admin'),
                                        );
                                      }
                                    }
                                  },
                                ),
                              ),
                            );
                            // subtitle:
                            //     Text(data['subtitle']),
                          } else {
                            // Document does not exist or no data available
                            return Center(
                              child: Text(
                                  'Document does not exist or no data available.'),
                            );
                          }
                        }
                      },
                    ))
              ]),
            ),
          ],
        ),
      ),
      // body: Container(
      //   padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      //   child: Column(
      //     children: [
      //       SliverAppBar(
      //         expandedHeight: 200, // Set the desired height for the app bar
      //         flexibleSpace: FlexibleSpaceBar(
      //           background: Image.network(
      //             'https://media.istockphoto.com/id/1414744533/photo/woman-hand-holding-credit-cards-and-using-smartphone-for-shopping-online-with-payment-on.jpg?b=1&s=170667a&w=0&k=20&c=3EYPAKeQbFEgiK7ED-f2nM_9khgvdYxV0u5Uzq7EahY=', // Replace with your own image path
      //             fit: BoxFit.cover,
      //           ),
      //         ),
      //       ),

      //       Expanded(
      //         child: Column(
      //           children: widget.groupMembers
      //               .map((e) => FutureBuilder<DocumentSnapshot>(
      //                         future: FirebaseFirestore.instance
      //                             .collection('users')
      //                             .doc(e)
      //                             .get(),
      //                         builder: (BuildContext context,
      //                             AsyncSnapshot<DocumentSnapshot> snapshot) {
      //                           if (snapshot.connectionState ==
      //                               ConnectionState.waiting) {
      //                             return Center(
      //                               child: CircularProgressIndicator(),
      //                             );
      //                           } else if (snapshot.hasError) {
      //                             return Center(
      //                               child: Text('Error: ${snapshot.error}'),
      //                             );
      //                           } else {
      //                             if (snapshot.hasData &&
      //                                 snapshot.data!.exists) {
      //                               // Document exists and data has been fetched successfully
      //                               DocumentSnapshot documentSnapshot =
      //                                   snapshot.data!;

      //                               return Container(
      //                                 padding: EdgeInsets.symmetric(
      //                                     vertical: 8.0, horizontal: 4),
      //                                 decoration: BoxDecoration(
      //                                   // color: Colors.grey,
      //                                   border: Border.all(
      //                                       color: Colors.grey, width: 1.0),
      //                                   borderRadius:
      //                                       BorderRadius.circular(16.0),
      //                                 ),
      //                                 child: ListTile(
      //                                   title: Text(documentSnapshot
      //                                       .get('firstName')
      //                                       .toString()),
      //                                   trailing: FutureBuilder<bool>(
      //                                     future: DatabaseService.checkIfAdmin(
      //                                         widget.groupId, e),
      //                                     builder: (BuildContext context,
      //                                         AsyncSnapshot<bool> snapshot) {
      //                                       if (snapshot.connectionState ==
      //                                           ConnectionState.waiting) {
      //                                         return CircularProgressIndicator();
      //                                       } else if (snapshot.hasError) {
      //                                         return Text(
      //                                             'Error: ${snapshot.error}');
      //                                       } else {
      //                                         bool isAdmin =
      //                                             snapshot.data ?? false;
      //                                         if (isAdmin) {
      //                                           return Container(
      //                                             padding: EdgeInsets.symmetric(
      //                                                 vertical: 8.0,
      //                                                 horizontal: 4),
      //                                             decoration: BoxDecoration(
      //                                               // color: Colors.grey,
      //                                               border: Border.all(
      //                                                   color: Colors.grey,
      //                                                   width: 1.0),
      //                                               borderRadius:
      //                                                   BorderRadius.circular(
      //                                                       16.0),
      //                                             ),
      //                                             child: Text(' Group Admin'),
      //                                           );
      //                                         } else {
      //                                           return Container(
      //                                             padding: EdgeInsets.symmetric(
      //                                                 vertical: 8.0,
      //                                                 horizontal: 4),
      //                                             decoration: BoxDecoration(
      //                                               // color: Colors.grey,
      //                                               border: Border.all(
      //                                                   color: Colors.grey,
      //                                                   width: 1.0),
      //                                               borderRadius:
      //                                                   BorderRadius.circular(
      //                                                       16.0),
      //                                             ),
      //                                             child: Text(''),
      //                                           );
      //                                         }
      //                                       }
      //                                     },
      //                                   ),
      //                                 ),
      //                               );
      //                               // subtitle:
      //                               //     Text(data['subtitle']),
      //                             } else {
      //                               // Document does not exist or no data available
      //                               return Center(
      //                                 child: Text(
      //                                     'Document does not exist or no data available.'),
      //                               );
      //                             }
      //                           }
      //                         },
      //                       )

      //                   )
      //               .toList(),
      //         ),
      //       )
      //       // memberList(),
      //     ],
      //   ),
      // ),
    );
  }
}
