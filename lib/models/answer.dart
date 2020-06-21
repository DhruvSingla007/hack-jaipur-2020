import 'package:cloud_firestore/cloud_firestore.dart';

class Answer {
  String key;
  String answer;
  String answeredBy;
  String photoUrl;

  Answer(this.key, this.answer, this.answeredBy, this.photoUrl);

  Answer.fromSnapshot(DocumentSnapshot snapshot) :
    key = snapshot.documentID,
    answer = snapshot.data["answer"],
    answeredBy = snapshot.data["answeredBy"],
    photoUrl = snapshot.data["photoUrl"];

  toJson() {
    return {
      "answer": answer,
      "answeredBy": answeredBy,
      "photoUrl": photoUrl,

    };
  }
}