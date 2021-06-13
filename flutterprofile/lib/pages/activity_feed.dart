import 'package:flutter/material.dart';
import 'package:flutterprofile/widgets/header.dart';

class ActivityFeed extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: header(context, titleText: "Booking"),
      body: Center(
        child: Text(
          'Online Booking',
          style: TextStyle(fontSize: 50.0, color: Colors.black),
        ),
      ),
    );
  }
}
