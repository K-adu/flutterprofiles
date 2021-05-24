import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterprofile/pages/activity_feed.dart';
import 'package:flutterprofile/pages/create_account.dart';
import 'package:flutterprofile/pages/profile.dart';
import 'package:flutterprofile/pages/search.dart';
import 'package:flutterprofile/pages/timeline.dart';
// import 'package:flutterprofile/pages/upload.dart';
import 'package:google_sign_in/google_sign_in.dart';

final GoogleSignIn googleSignIn = GoogleSignIn();
final usersRef = FirebaseFirestore.instance.collection('users');
final DateTime timestamp = DateTime.now();

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool isAuth = false;
  PageController pageController;
  int pageIndex = 0;

  void initState() {
    super.initState();
    pageController = PageController();
    googleSignIn.onCurrentUserChanged.listen((account) {
      handleSignin(account);
    }, onError: (err) {
      print('Error signing in: $err');
    });
    googleSignIn.signInSilently(suppressErrors: false).then((account) {
      handleSignin(account);
    }).catchError((err) {
      print('Error signing in:$err');
    });
  }

  handleSignin(GoogleSignInAccount account) {
    if (account != null) {
      createUserInFirestore();
      print('user signed in!: $account');
      setState(() {
        isAuth = true;
      });
    } else {
      setState(() {
        isAuth = false;
      });
    }
  }

  createUserInFirestore() async {
    //check if user exists in users collection in database(addoridnt to id)
    final GoogleSignInAccount user = googleSignIn.currentUser;
    final DocumentSnapshot doc = await usersRef.doc(user.id).get();

    // if users !=exist then take to create acocunt page

    if (!doc.exists) {
      final username = await Navigator.push(
          context, MaterialPageRoute(builder: (context) => CreateAccount()));
      // get user name from create account use it to make new user document in users collection
      usersRef.doc(user.id).set({
        "id": user.id,
        "username": username,
        "photoUrl": user.photoUrl,
        "email": user.email,
        "displayName": user.displayName,
        "bio": "",
        "timestamp": timestamp,
      });
    }
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  login() {
    googleSignIn.signIn();
  }

  logout() {
    googleSignIn.signOut();
  }

  onPageChanged(int pageIndex) {
    setState(() {
      this.pageIndex = pageIndex;
    });
  }

  onTap(int pageIndex) {
    pageController.animateToPage(pageIndex,
        duration: Duration(milliseconds: 200), curve: Curves.bounceInOut);
  }

  Scaffold buildAuthScreen() {
    return Scaffold(
      body: PageView(
        children: <Widget>[
          // Timeline(),
          RaisedButton(
            child: Text('Logout'),
            onPressed: logout,
          ),
          ActivityFeed(),
          // Upload(),
          Search(),
          Profile(),
        ],
        controller: pageController,
        onPageChanged: onPageChanged,
        physics: NeverScrollableScrollPhysics(),
      ),
      bottomNavigationBar: CupertinoTabBar(
        currentIndex: pageIndex,
        onTap: onTap,
        activeColor: Theme.of(context).primaryColor,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), title: Text("Home")),
          BottomNavigationBarItem(
              icon: Icon(Icons.search), title: Text("Explore")),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite_border), title: Text("Trips")),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_circle), title: Text("Profile")),
        ],
      ),
    );
    // return RaisedButton(
    //   child: Text('Logout'),
    //   onPressed: logout,
    // );
  }

  Scaffold buildUnAuthScreen() {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [Colors.teal, Colors.purple]),
        ),
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              'TravelNepal',
              style: TextStyle(
                fontFamily: "Signatra",
                fontSize: 90.0,
                color: Colors.white,
              ),
            ),
            GestureDetector(
              onTap: login,
              child: Container(
                width: 260.0,
                height: 60.0,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/google_signin_button.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return isAuth ? buildAuthScreen() : buildUnAuthScreen();
  }
}
