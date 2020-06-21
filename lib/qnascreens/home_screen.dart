import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hackjaipur2020/qnascreens/question_list.dart';

class ChatHomeScreen extends StatefulWidget {
  ChatHomeScreen({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _ChatHomeScreenState createState() => _ChatHomeScreenState();
}

class _ChatHomeScreenState extends State<ChatHomeScreen> {

  TextEditingController _addQuesitonInputController =
      new TextEditingController();

  Future<bool> _onAlertQuestionAdd(BuildContext context) {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return new AlertDialog(
            title: Text(
              'Add Questions',
              style: TextStyle(
                  fontSize: 20.0,
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.bold),
            ),
            content: Container(
              height: 250,
              child: Column(children: <Widget>[
                TextField(
                  maxLines: 4,
                  controller: _addQuesitonInputController,
                  decoration: InputDecoration(
                    labelText: "Question",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                RaisedButton(
                  onPressed: () {
                    Firestore.instance
                        .collection('New Questions')
                        .document('name')
                        .setData({
                      'Question':
                          _addQuesitonInputController.text.toString().trim(),
                    });
                    Navigator.of(context).pop(true);
                  },
                  child: Text(
                    'Add',
                    style: TextStyle(fontFamily: 'Montserrat'),
                  ),
                )
              ]),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(children: [
        Container(
          padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
          child: Center(
              child: Text(
            "Tags",
            style: TextStyle(fontSize: 22, color: Colors.black),
          )),
        ),
        FutureBuilder(
            future:
                Firestore.instance.collection('Question_Tags').getDocuments(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (!snapshot.hasData) {
                return Center(child: const Text('Loading Tags...'));
              }
              return GridView.builder(
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3),
                itemBuilder: (BuildContext context, int index) {
                  return _buildGridElement(snapshot.data.documents[index]);
                },
                itemCount: snapshot.data.documents.length,
              );
            }),
      ]),

      /*Column(
        children: <Widget>[
          CategorySelector(),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).accentColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30.0),
                  topRight: Radius.circular(30.0),
                ),
              ),
              child: Column(
                children: <Widget>[
                  RecentChats(),
                ],
              ),
            ),
          ),
        ],
      ),*/
    );
  }

  Widget _buildGridElement(dynamic snapshot) {
    return InkWell(
        onTap: () {
          print("lalal");
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => QuestionsList(
                    snapshot: snapshot,
                  )));
        },
        child: Container(
          padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
          child: Card(
              elevation: 10,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Image.asset("assets/images/logo.png", height: 50),
                    Text(snapshot.documentID.toString()),
                  ])),
        ));
  }
}
