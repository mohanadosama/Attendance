import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:ui_design/models/users.dart';
import 'package:ui_design/widgets/loading.dart';

class attLog extends StatefulWidget {
  Users currentUser;
  attLog({
    this.currentUser,
  });
  _attLog createState() => _attLog();
}

class _attLog extends State<attLog> {
  String userID;

  @override
  initState() {
    getUser();
  }

  getUser() async {
    final User user = FirebaseAuth.instance.currentUser;
    userID = user.uid;
  }

  @override
  Widget build(BuildContext context) {
    Card MainCard(DocumentSnapshot doc) {
      return Card(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              width: 15,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(bottom: 5, left: 5, top: 5),
                  child: Text(
                    '${doc.data}', //Name
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                Row(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(bottom: 10, left: 5, top: 5),
                      child: Text(
                        '${doc.data}', //Date
                        style: TextStyle(
                            fontSize: 14,
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 10, left: 5, top: 5),
                      child: Text(
                        'At: ${doc.data}', //Time
                        style: TextStyle(
                          fontSize: 14,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            )
          ],
        ),
      );
    }

    return Scaffold(
        body: ListView(padding: EdgeInsets.all(8), children: <Widget>[
      StreamBuilder<QuerySnapshot>(
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                alignment: Alignment.center,
                child: circularLoading());
          }
          return Column(
              children: snapshot.data.docs
                  .map((docCard) => MainCard(docCard))
                  .toList());
        },
      ),
    ]));
  }
}
