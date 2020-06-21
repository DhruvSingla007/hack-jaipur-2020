import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  String key;
  String name;
  String profession;
  String phone;
  String branch;
  String semester;
  String college;

  User(this.key, this.name, this.profession, this.phone, this.branch, this.semester, this.college);

  User.fromSnapshot(DocumentSnapshot snapshot) :
    key = snapshot.documentID,
    name = snapshot.data["userName"],
    profession = snapshot.data["profession"],
    phone = snapshot.data["phone"],
    branch = snapshot.data["branch"],
    semester = snapshot.data["semester"],
    college = snapshot.data["college"];
    

  toJson() {
    return {
      "userName": name,
    };
  }
}