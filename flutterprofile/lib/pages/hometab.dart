import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutterprofile/widgets/header.dart';

class HomeTab extends StatelessWidget {
  final CollectionReference _HotelRef =
      FirebaseFirestore.instance.collection("Hotels");

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          FutureBuilder<QuerySnapshot>(
            future: _HotelRef.get(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Scaffold(
                  body: Center(
                    child: Text("Error: ${snapshot.error}"),
                  ),
                );
              }
              buildHomeBody() {
                return ListView(
                  padding: EdgeInsets.only(
                    top: 30.0,
                  ),
                  children: snapshot.data.docs.map((document) {
                    return Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      height: 350.0,
                      margin: EdgeInsets.symmetric(
                        vertical: 12.0,
                        horizontal: 24.0,
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12.0),
                        child: Image.network(
                          "${document.data()['images'][0]}",
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  }).toList(),
                );
              } // build home body

              return Scaffold(
                // body: Center(
                //   child: CircularProgressIndicator(),
                appBar: header(context, titleText: "Home"),
                body: buildHomeBody(),
              );

              return Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
