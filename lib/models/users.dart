import 'package:cloud_firestore/cloud_firestore.dart';

class Users {
  String userId;
  String Name;
  String attTime;
  String attDate;
  String profilePictureURL;

  Users({
    this.userId,
    this.Name,
    this.attTime,
    this.attDate,
    this.profilePictureURL,
  });

  factory Users.fromDocument(DocumentSnapshot doc) {

    return Users(

      userId: doc['id'],
      Name: doc['Name'],
      attTime: doc['Time'],
      attDate: doc['Date'],
      profilePictureURL: doc['photoURL'],

    );
  }
}