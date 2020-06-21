import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  String key;
  String name;

  User(this.key, this.name);

  User.fromSnapshot(DocumentSnapshot snapshot) :
    key = snapshot.documentID,
    name = snapshot.data["name"];
}