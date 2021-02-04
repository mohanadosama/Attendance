import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';

import 'package:ui_design/ui/attLog.dart';
import 'package:ui_design/models/users.dart';
import 'package:ui_design/utils/auth.dart';

import 'login.dart';


class Home extends StatefulWidget {
  Users currentUser;

  Home({this.currentUser,});

  _Home createState() => _Home();
}

class _Home extends State<Home> {
  DateTime now = DateTime.now();
  String formattedDate = DateFormat.jm().format(DateTime.now());

  @override
  initState() {
    getCurrent();
    super.initState();
  }

  void getCurrent() async {
    final User user = await FirebaseAuth.instance.currentUser;
    DocumentSnapshot doc = await usersRef.doc(user.uid).get();
    currentUser = Users.fromDocument(doc);
    widget.currentUser = currentUser;
    print(widget.currentUser.userId);
  }


  void submitAtt() async {
    await attRef.add({
      'ownerID': widget.currentUser.userId,
      'Name': widget.currentUser.Name,
      'userPhotoURL': widget.currentUser.profilePictureURL,
      'timestamp': now,
    });
    print("added");
  }

  @override
  Widget build(BuildContext context) {
    final background = Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: [0.5, 0.5],
              colors: [Colors.brown[50], Colors.white])),
    );

    final subCircle = Stack(
      children: <Widget>[
        Center(
            child: GestureDetector(
              onTap: () => submitAtt(),
              child: Container(
          height: 300.0,
          width: 300.0,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Theme.of(context).primaryColor,
          ),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 20,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 120.0),
                    child: Icon(
                      Icons.camera_alt,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                ),
                SizedBox(height: 140,),
                Text('تسجيل الحضور',
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.bold)),
              ],
          ),
        ),
            )),
        ClipRect(
          child: Align(
            alignment: Alignment.topCenter,
            heightFactor: 0.5,
            child: Container(
              width: 300,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                border:
                    Border.all(color: Theme.of(context).primaryColor, width: 3),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top:200.0),
                    child: Text(
                      'الساعةالآن',
                      style: TextStyle(fontSize: 18, color: Colors.black26),
                    ),
                  ),
                  Text(
                    formattedDate,
                    style: TextStyle(fontSize: 26, color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );

    final logo = Container(
      margin: const EdgeInsets.only(bottom: 20.0),
      child: Image.asset(
        'assets/ma.png',
        width: 277,
        height: 88,
        fit: BoxFit.contain,
      ),
    );

    final attendanceLog = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "مواعيد الحضور السابقة",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ],
    );

    final signOutButton = Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 30.0),
        child: ButtonTheme(
          minWidth: 100.0,
          child: RaisedButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            onPressed: () async {
              await Auth.signOut()
                  .then((value) => Navigator.pushNamed(context, '/'));
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

    final welcome = Center(
      child: Padding(
        padding: const EdgeInsets.only(top: 30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "أهلاً بك",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Text(
              "currentUser.Name",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            )     //Should be replaced by username after database
          ],
        ),
      ),
    );

    //image picker
    //geo-location

    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.brown[50],
          iconTheme: IconThemeData(color: Colors.deepOrange),
        ),
        endDrawer: sideDrawer,
        bottomNavigationBar: logo,
        body: Center(
          child: Stack(
            children: [
              background,
              welcome,
              subCircle,
            ],
          ),
        ));
  }
}
