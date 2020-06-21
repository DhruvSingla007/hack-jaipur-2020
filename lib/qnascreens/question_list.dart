import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hackjaipur2020/models/question.dart';
import 'package:hackjaipur2020/models/User.dart';
import 'package:hackjaipur2020/qnascreens/question_detail.dart';
import 'package:shimmer/shimmer.dart';

class QuestionsList extends StatefulWidget {
  final snapshot;

  const QuestionsList({Key key, this.snapshot}) : super(key: key);
  @override
  _QuestionsListState createState() => _QuestionsListState();
}

class _QuestionsListState extends State<QuestionsList> {
  final _questionsRef = Firestore.instance.collection("Questions");
  final questionController = TextEditingController();
  Map<String, bool> tagList = {};

  bool _validateQues = true, _validateTags = true;

  String question;

  @override
  void dispose() {
    questionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xffCBE7EA),
        title: Text(
          widget.snapshot.data["name"],
          style: TextStyle(
            fontFamily: 'OpenSans',
            fontWeight: FontWeight.bold
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.only(top:15.0, left: 8.0,right: 8.0),
        child: StreamBuilder(
            stream: Firestore.instance
                .collection("Question_Tags")
                .document(widget.snapshot.documentID)
                .get()
                .asStream(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) return Container();

              return (snapshot.data["question_list"].length == 0)
                  ? Center(
                      child: Container(
                          padding: const EdgeInsets.only(top: 10),
                          child: Column(children: [
                            Icon(
                              Icons.error,
                              size: 75,
                            ),
                            Text("No Questions Yet!",
                                style: TextStyle(fontSize: 18,fontFamily: 'OpenSans'))
                          ])))
                  : ListView.separated(
                      itemCount: snapshot.data["question_list"].length,
                      separatorBuilder: (context, int) {
                        return Divider(
                          thickness: 2,
                        );
                      },
                      itemBuilder: (BuildContext context, int index) {
                        print(snapshot.data["question_list"].length);
                        return questionTile(snapshot, index);
                      },
                    );
            }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _addQuestionDialog(context);
        },
        child: Icon(
          Icons.add,
          color: Colors.black,
        ),
        backgroundColor: Color(0xff5cb3bc),
      ),
    );
  }

  void _addQuestionDialog(BuildContext context) async {
    await showDialog(
        context: context,
        builder: (BuildContext dialogcontext) {
          return StatefulBuilder(builder: (dialogcontext, setState) {
            return Dialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25.0),
                ),
                child: Container(
                    width: 350,
                    height: 420,
                    child: ListView(children: <Widget>[
                      Container(
                          padding: const EdgeInsets.all(10),
                          width: double.infinity,
                          color: Color(0xffCBE7EA),
                          child: Center(
                            child: Text("Ask New Question",
                                style: TextStyle(
                                    fontFamily: 'OpenSans',
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                    color: Colors.black)),
                          )),
                      Container(
                          padding: const EdgeInsets.fromLTRB(5, 10, 5, 10),
                          child: TextFormField(
                            controller: questionController,
                            maxLines: 5,
                            decoration: InputDecoration(
                              border: new OutlineInputBorder(
                                  borderSide:
                                      new BorderSide(color: Colors.grey)),
                              hintText: "Type your question!",
                              hintStyle: TextStyle(fontSize: 14),
                              errorText: _validateQues
                                  ? null
                                  : 'Question can\'t be empty',
                            ),
                          )),
                      Container(
                          padding: const EdgeInsets.fromLTRB(10, 10, 5, 10),
                          child: Text("Select Tags",
                              style: TextStyle(
                                  fontFamily: 'OpenSans',
                                  fontSize: 18,
                                  color: Colors.black87))),
                      FutureBuilder(
                          future: Firestore.instance
                              .collection('Question_Tags')
                              .getDocuments(),
                          builder:
                              (BuildContext context, AsyncSnapshot snapshot) {
                            if (!snapshot.hasData) {
                              return Center(
                                  child: const Text('Loading Tags...',style: TextStyle(fontFamily: 'OpenSans'),));
                            } else {
                              createTagList(snapshot);

                              return ListView.builder(
                                  shrinkWrap: true,
                                  physics: ClampingScrollPhysics(),
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return _tagCheckBox(
                                        snapshot
                                            .data.documents[index].documentID,
                                        setState);
                                  },
                                  itemCount: snapshot.data.documents.length);
                            }
                          }),
                      (!_validateTags)
                          ? Container(
                              padding: const EdgeInsets.fromLTRB(20, 5, 0, 5),
                              child: Text("Select at least one tag",
                                  style: TextStyle(color: Colors.red,fontFamily: 'OpenSans')))
                          : Container(),
                      Container(
                          padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              RaisedButton(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: new BorderRadius.circular(30.0),
                                  ),
                                  color: Color.fromRGBO(10, 10, 12, 2),
                                  onPressed: () {
                                    Navigator.of(dialogcontext).pop();
                                  },
                                  child: Text("CANCEL",
                                      style: TextStyle(
                                          fontFamily: 'OpenSans',
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white))),
                              RaisedButton(
                                shape: RoundedRectangleBorder(
                                  borderRadius: new BorderRadius.circular(30.0),
                                ),
                                color: Color(0xff5cb3bc),
                                onPressed: () {
                                  _saveQuestion(setState, dialogcontext);
                                  //Navigator.of(dialogcontext).pop();
                                },
                                child: Text("CONFIRM",
                                    style: TextStyle(
                                        fontFamily: 'OpenSans',
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white)),
                              ),
                            ],
                          ))
                    ])));
          });
        }).then((value) {
      setState(() {
        _validateQues = true;
        _validateTags = true;
      });
    });
  }

  void _saveQuestion(var setState, BuildContext dialogcontext) {
    setState(() {
      questionController.text.isEmpty
          ? _validateQues = false
          : _validateQues = true;
    });

    print(_validateQues);

    if (_validateQues) {
      bool isSelected = false;
      List<String> selectedTags = [];

      tagList.forEach((key, value) {
        if (value == true) selectedTags.add(key);
      });

      if (selectedTags.length == 0) {
        setState(() {
          _validateTags = false;
        });

        return;
      }

      this.question = questionController.text;
      String questionID = DateTime.now().millisecondsSinceEpoch.toString();

      FirebaseUser currentUser;
      FirebaseAuth.instance.currentUser().then((authUser) {
        Firestore.instance
            .collection("users")
            .document(authUser.displayName)
            .get()
            .then((user) {
          User userObj = User.fromSnapshot(user);

          for (String value in selectedTags) {
            Firestore.instance
                .collection("Question_Tags")
                .document(value)
                .get()
                .then((tag) {
              List<dynamic> array = tag.data["question_list"];
              String name = tag.data["name"];

              array.add(questionID);

              Firestore.instance
                  .collection("Question_Tags")
                  .document(value)
                  .updateData({"name": name, "question_list": array});
            });
          }

          Question q = new Question(questionID, authUser.uid, userObj.name,
              this.question, authUser.photoUrl, selectedTags);
          print(q);
          Firestore.instance
              .collection("Questions")
              .document(questionID)
              .setData(q.toJson())
              .whenComplete(() => Navigator.of(dialogcontext).pop());
        });
      });
    }
  }

  void createTagList(var snapshot) {
    for (var i = 0; i < snapshot.data.documents.length; i++) {
      //print(snapshot.data.documents[i].documentID);
      tagList.putIfAbsent(snapshot.data.documents[i].documentID, () => false);
    }

    //print(tagList);
  }

  Widget _tagCheckBox(String tagName, var setState) {
    return Container(
        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Checkbox(
              value: tagList[tagName],
              onChanged: (bool value) {
                setState(() {
                  tagList[tagName] = value;
                  //print(tagList);
                });
              },
            ),
            Text(tagName,style: TextStyle(fontFamily: 'OpenSans'),),
          ],
        ));
  }

  Widget questionTile(var snap, int index) {
    return FutureBuilder(
      future: _questionsRef
          .document(snap.data["question_list"][index])
          .get(),
      builder: (context, snapshot) {
        //if (snapshot.hasData) print(snapshot.data.data);

        return (snapshot.hasData)
            ? ListTile(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => QuestionDetail(
                          question: snapshot.data.data,
                          id: snap.data["question_list"][index])));
                },
                leading: Icon(Icons.list),
                title: Text(
                  snapshot.data.data["detail"],
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontFamily: 'OpenSans'),
                ),
                subtitle: Container(
                    padding: const EdgeInsets.only(top: 10),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: createTags(snapshot.data.data["tags"]))))
            : Shimmer.fromColors(
                enabled: true,
                child: Container(color: Colors.black, height: 100),
                baseColor: Colors.grey[300],
                highlightColor: Colors.grey[100],
              );
      },
    );
  }

  List<Widget> createTags(var tags) {
    int length = (tags.length > 2) ? 2 : tags.length;
    List<Widget> tagList = [Text("Tags: ")];

    for (int i = 0; i < length; i++) {
      tagList.add(Container(
        padding: const EdgeInsets.fromLTRB(5, 0, 15, 0),
        child: Container(
            padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
            decoration: BoxDecoration(
                color: Colors.grey, borderRadius: BorderRadius.circular(10)),
            child: Text(tags[i], style: TextStyle(color: Colors.white))),
      ));
    }

    //print(tagList);
    return tagList;
  }
}
