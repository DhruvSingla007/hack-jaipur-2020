import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hackjaipur2020/models/User.dart';
import 'package:hackjaipur2020/models/answer.dart';
import 'package:flutter/material.dart';

class QuestionDetail extends StatefulWidget {
  final question, id;

  QuestionDetail({this.question, this.id});

  @override
  _QuestionDetailState createState() => _QuestionDetailState();
}

class _QuestionDetailState extends State<QuestionDetail> {
  final _userRef = Firestore.instance.collection("users");
  User user;
  FirebaseUser authUser;
  String answer;
  final _formKey = GlobalKey<FormState>();
  CollectionReference _answerRef;

  final answerController = TextEditingController();
  bool _validate = true;
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    answerController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    print(widget.question);
    _answerRef = Firestore.instance
        .collection("Questions")
        .document(widget.id)
        .collection("answers");
    getUserDetails();
  }

  void getUserDetails() async {
    FirebaseAuth.instance.currentUser().then((value) {
      authUser = value;
      _userRef.document(authUser.displayName).get().then((value) {
        setState(() {
          user = User.fromSnapshot(value);
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xffCBE7EA),
        title: Text(
          "Question",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontFamily: 'OpenSans',
          ),
        ),
        centerTitle: true,
      ),
      body: (user != null)
          ? Container(
              padding: const EdgeInsets.all(10),
              child: ListView(children: [
                _questionSection(),
                Divider(),
                _answerHeader(),
                _answerSection(),
              ]))
          : Center(
              child: Card(
                  elevation: 10,
                  child: Container(
                      height: 100,
                      width: 150,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text("Loading", style: TextStyle(fontSize: 16,fontFamily: 'OpenSans')),
                            CircularProgressIndicator()
                          ]))),
            ),
      bottomSheet: (user != null)
          ? Container(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 5),
              child: Row(
                children: <Widget>[
                  CircleAvatar(
                    radius: 25,
                    backgroundImage: NetworkImage(authUser.photoUrl),
                  ),
                  Expanded(
                    child: Container(
                        padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                        child: TextFormField(
                          controller: answerController,
                          maxLines: 1,
                          decoration: InputDecoration(
                            border: new OutlineInputBorder(
                                borderSide:
                                    new BorderSide(color: Colors.black)),
                            hintText: "Type your answer!",
                            hintStyle: TextStyle(fontSize: 14),
                            errorText:
                                _validate ? null : 'Answer can\'t be empty',
                          ),
                        )),
                  ),
                  RaisedButton(
                      color: Colors.blue,
                      onPressed: () {
                        _validateAnswer();
                      },
                      child: Text("Answer!",
                          style: TextStyle(color: Colors.white,fontFamily: 'OpenSans')))
                ],
              ),
            )
          : Container(),
    );
  }

  void _validateAnswer() {
    setState(() {
      answerController.text.isEmpty ? _validate = false : _validate = true;
    });

    if (_validate) {
      this.answer = answerController.text;

      Answer answerObj =
          Answer(authUser.uid, this.answer, user.name, authUser.photoUrl);

      _answerRef.document(answerObj.key).get().then((value) {
        //print(value);

        if (value.data == null) {
          print("yea");
          _answerRef.document(answerObj.key).setData(answerObj.toJson());
        } else {
          print("nah");
        }
      });
    }
  }

  Widget _questionSection() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            CircleAvatar(
              radius: 30,
              backgroundImage: NetworkImage(widget.question["photoUrl"]),
            ),
            Container(
                padding: const EdgeInsets.only(left: 15),
                child: Text(
                  widget.question["asked_by"],
                  style: TextStyle(fontSize: 18,fontFamily: 'OpenSans'),
                ))
          ],
        ),
        Container(
          padding: const EdgeInsets.fromLTRB(10, 15, 5, 15),
          child: Text(widget.question["detail"],style: TextStyle(fontFamily: 'OpenSans'),),
        ),
        Container(
          padding: const EdgeInsets.only(top: 10),
          height: 40,
          child: Scrollbar(
              isAlwaysShown: false,
              controller: _scrollController,
              child: ListView(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      children: createTags(widget.question["tags"]))),
        ),
      ],
    );
  }

  Widget _answerSection() {
    return Container(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
      child: StreamBuilder(
          stream: _answerRef.snapshots(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return (snapshot.data.documents.length != 0)
                  ? ListView.builder(
                      shrinkWrap: true,
                      itemCount: snapshot.data.documents.length,
                      itemBuilder: (context, index) {
                        return _answerTile(snapshot.data.documents[index]);
                      })
                  : Container(
                      child: Column(children: [
                      Icon(
                        Icons.error,
                        size: 75,
                      ),
                      Text("No Answers Yet!", style: TextStyle(fontSize: 18,fontFamily: 'OpenSans'))
                    ]));
            }

            return Container();
          }),
    );
  }

  List<Widget> createTags(var tags) {
    int length = tags.length;
    List<Widget> tagList = [Text("Tags: ",style: TextStyle(fontFamily: 'OpenSans'),)];

    for (int i = 0; i < length; i++) {
      tagList.add(Container(
        padding: const EdgeInsets.fromLTRB(5, 0, 15, 0),
        child: Container(
          height: 37.5,
            padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
            decoration: BoxDecoration(
                color: Colors.grey, borderRadius: BorderRadius.circular(10)),
            child: Text(tags[i], style: TextStyle(color: Colors.white,fontFamily: 'OpenSans'))),
      ));
    }

    print("Tags" + tagList.toString());
    return tagList;
  }

  Widget _answerTile(DocumentSnapshot snapshot) {
    Answer ans = Answer.fromSnapshot(snapshot);

    return Container(
        padding: const EdgeInsets.fromLTRB(0, 3, 0, 3),
        child: Row(
          children: <Widget>[
            CircleAvatar(
              backgroundImage: NetworkImage(ans.photoUrl),
              radius: 25,
            ),
            Expanded(
                child: Container(
                    color: Colors.white54,
                    padding: const EdgeInsets.all(5),
                    child: Card(
                        elevation: 3,
                        color: Colors.white54,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0)),
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                ans.answeredBy,
                                style: TextStyle(
                                  fontFamily: 'OpenSans',
                                    fontWeight: FontWeight.bold, fontSize: 14),
                              ),
                              Container(
                                child: Text(ans.answer,
                                    style: TextStyle(fontSize: 13)),
                                padding: const EdgeInsets.only(top: 5),
                              )
                            ],
                          ),
                        ))))
          ],
        ));
  }

  Widget _answerHeader() {
    return Center(
        child: Container(
            padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
            child: Text("Answers",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold))));
  }
}
