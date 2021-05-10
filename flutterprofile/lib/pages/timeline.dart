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
  @override
  void initState() {
    getUsers();
    super.initState();
  }

  getUsers() {
    usersRef.get().then((QuerySnapshot snapshot) {
      snapshot.docs.forEach((doc) {
        print(doc.data());
        print(doc.id);
        print(doc.exists);
      });
    });
  }

  @override
  Widget build(context) {
    return Scaffold(
      appBar: header(context, isAppTitle: true),
      body: linearProgress(),
    );
  }
}
