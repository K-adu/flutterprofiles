import 'package:flutter/material.dart';
import 'package:flutterprofile/widgets/header.dart';

class Map extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: header(context, titleText: "Maps"),
      body: Center(
        child: Text(
          'Map Page',
          style: TextStyle(fontSize: 50.0, color: Colors.black),
        ),
      ),
    );
  }
}
