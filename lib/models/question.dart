import 'package:cloud_firestore/cloud_firestore.dart';

class Question {
  String key;
  String UID;
  String asked_by;
  String detail;
  String photoUrl;
  List<String> tags;

  Question(this.key, this.UID, this.asked_by, this.detail, this.photoUrl, this.tags);

  Question.fromSnapshot(DocumentSnapshot snapshot) :
    key = snapshot.documentID,
    UID = snapshot.data["UID"],
    asked_by = snapshot.data["asked_by"],
    detail = snapshot.data["detail"],
    photoUrl = snapshot.data["photoUrl"],
    tags = snapshot.data["tags"];

  toJson() {
    return {
      "UID": UID,
      "asked_by": asked_by,
      "detail": detail,
      "photoUrl": photoUrl,
      "tags": tags,

    };
  }
}