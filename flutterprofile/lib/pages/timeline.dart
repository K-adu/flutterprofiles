import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutterprofile/widgets/header.dart';
import 'package:flutterprofile/widgets/progress.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final usersRef = FirebaseFirestore.instance.collection('users');

class Timeline extends StatefulWidget {
  @override
  _TimelineState createState() => _TimelineState();
}

class _TimelineState extends State<Timeline> {
  List<dynamic> users = [];
  @override
  void initState() {
    // deleteUser();
    updateUser();
    // createUser();
    // getUsers();
    // getUserById();
    super.initState();
  }

  createUser() {
    usersRef
        .doc("asadadasd")
        .set({"username": "jeff", "postCount": 0, "isAdmin": false});
  }

  updateUser() async {
    final doc = await usersRef.doc("FVbPr7CGXShzZUMuy6bQ").get();
    if (doc.exists) {
      doc.reference
          .update({"username": "Baral", "postCount": 0, "isAdmin": false});
    }
  }

  deleteUser() async {
    final doc = await usersRef.doc("asadadasd").get();
    if (doc.exists) {
      doc.reference.delete();
    }
  }

  getUsers() async {
    final QuerySnapshot snapshot = await usersRef
        // .where("isAdmin", isEqualTo: true)
        // .where("postsCount", isLessThan: 3)

        .get();
    setState(() {
      users = snapshot.docs;
    });

    // usersRef.get().then((QuerySnapshot snapshot) {
    // snapshot.docs.forEach((doc) {
    //   print(doc.data());
    //   print(doc.id);
    //   print(doc.exists);
    //   //   });
    //   // });
    // });
  }
  // getUserById() async {
  //   final String id = "YQwxG9yvQTZvFH9FfMXD";
  //   final DocumentSnapshot doc = await usersRef.doc(id).get();
  //   //.then((DocumentSnapshot doc) {
  //   print(doc.data());
  //   print(doc.id);
  //   print(doc.exists);
  // }

  @override
  Widget build(context) {
    return Scaffold(
        appBar: header(context, isAppTitle: true),
        body: StreamBuilder<QuerySnapshot>(
            stream: usersRef.snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return circularProgress();
              }
              final List<Text> children = snapshot.data.docs
                  .map((doc) => Text(doc['username']))
                  .toList();
              return Container(
                child: ListView(
                  children: children,
                ),
              );
            })
        // body: Container(
        //     child: ListView(
        //   children: users.map((user) => Text(user['username'])).toList(),
        // ),
        // ),
        );
  }
}
