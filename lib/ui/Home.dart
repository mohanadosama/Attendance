import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:ui_design/ui/attLog.dart';
import 'package:ui_design/models/users.dart';


class Home extends StatefulWidget {
  Users currentUser;
  Home({
    this.currentUser,
  });
  _Home createState() => _Home();
}

class _Home extends State<Home>
{
  String userID;

  // @override
  // initState() {
  //   getUser();
  // }
  // getUser() async {
  //   final User user = FirebaseAuth.instance.currentUser;
  //   userID = user.uid;
  // }

  @override
  Widget build(BuildContext context) {

    final logo = Container(
      margin: const EdgeInsets.only(bottom: 30.0),
      child: Image.asset(
        'assets/ma.png',
        width: 277,
        height: 88,
        fit: BoxFit.contain,
      ),
    );

    final attendanceLog = Padding(
      padding: const EdgeInsets.only(bottom: 24.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "مواعيد الحضور السابقة",
            style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );

    final signOutButton = Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 48.0),
        child: ButtonTheme(
          minWidth: 200.0,
          child: RaisedButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
            ),
            onPressed: () {

              Navigator.pushNamed(context, '/login');
            },
            padding: EdgeInsets.all(16),
            color: Theme.of(context).primaryColor,
            child: Text('تسجيل الخروج', style: TextStyle(color: Colors.white)),
          ),
        ),
      ),
    );

    final sideDrawer = Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: logo,
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
            ),
          ),
          ListTile(
            title: attendanceLog,
            onTap: () {
              Navigator.popAndPushNamed(context, '/attLog');
            },
          ),
          Divider(),
          signOutButton,
        ],
      ),
    );

    return Scaffold(
      body:
      Column(
        children: [
          Container()
        ],
      )
    );
  }
}