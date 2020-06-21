import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hackjaipur2020/models/user_model.dart';
import 'package:hackjaipur2020/models/message_model.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class ChatScreen extends StatefulWidget {
  final UserModel userModel;

  ChatScreen({this.userModel});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {

  final TextEditingController _questionInputController = TextEditingController();

  _buildMessage(Message message, bool isMe) {
    final Container msg = Container(
      margin: isMe
          ? EdgeInsets.only(
        top: 8.0,
        bottom: 8.0,
        left: 80.0,
      )
          : EdgeInsets.only(
        top: 8.0,
        bottom: 8.0,
      ),
      padding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 15.0),
      width: MediaQuery.of(context).size.width * 0.75,
      decoration: BoxDecoration(
        color: isMe ? Color(0xffCBE7EA).withOpacity(0.5) : Color(0xffCBE7EA).withOpacity(0.3),
        borderRadius: isMe
            ? BorderRadius.only(
          topLeft: Radius.circular(15.0),
          bottomLeft: Radius.circular(15.0),
        )
            : BorderRadius.only(
          topRight: Radius.circular(15.0),
          bottomRight: Radius.circular(15.0),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            message.time,
            style: TextStyle(
              fontFamily: 'Montserrat',
              color: Colors.black,
              fontSize: 16.0,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 8.0),
          Text(
            message.text,
            style: TextStyle(
              fontFamily: 'Montserrat',
              color: Colors.black,
              fontSize: 16.0,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
    if (isMe) {
      return msg;
    }
    return Row(
      children: <Widget>[
        msg,
        IconButton(
          icon: message.isLiked
              ? Icon(Icons.favorite)
              : Icon(Icons.favorite_border),
          iconSize: 30.0,
          color: message.isLiked
              ? Color(0xffCBE7EA)
              : Colors.blueGrey,
          onPressed: () {},
        )
      ],
    );
  }

  _buildMessageComposer() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.0),
      height: 70.0,
      color: Colors.white,
      child: Row(
        children: <Widget>[
          IconButton(
            icon: Icon(Icons.photo,color: Color(0xffCBE7EA),),
            iconSize: 25.0,
            color: Theme.of(context).primaryColor,
            onPressed: () {},
          ),
          Expanded(
            child: TextField(
              textCapitalization: TextCapitalization.sentences,
              controller: _questionInputController,
              onChanged: (value) {

              },
              decoration: InputDecoration.collapsed(
                hintText: 'Share your solution......',
              ),
            ),
          ),
          IconButton(
            icon: Icon(Icons.send,color: Color(0xffCBE7EA),),
            iconSize: 25.0,
            color: Theme.of(context).primaryColor,
            onPressed: () {
              Firestore.instance.collection('Asked Questions').document(widget.userModel.name).setData({
                'Question' : _questionInputController.text.toString().trim(),
              });
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffCBE7EA),
      appBar: AppBar(
        backgroundColor: Color(0xffCBE7EA),
        title: Text(
          widget.userModel.name,
          style: TextStyle(
            fontFamily: 'Montserrat',
            fontSize: 28.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        elevation: 0.0,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.more_horiz),
            iconSize: 30.0,
            color: Colors.white,
            onPressed: () => _onAlertBlock(context),
          ),
        ],
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Column(
          children: <Widget>[
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30.0),
                    topRight: Radius.circular(30.0),
                  ),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30.0),
                    topRight: Radius.circular(30.0),
                  ),
                  child: ListView.builder(
                    reverse: true,
                    padding: EdgeInsets.only(top: 15.0),
                    itemCount: messages.length,
                    itemBuilder: (BuildContext context, int index) {
                      final Message message = messages[index];
                      final bool isMe = message.sender.id== currentUser.id;
                      return _buildMessage(message, isMe);
                    },
                  ),
                ),
              ),
            ),
            _buildMessageComposer(),
          ],
        ),
      ),
    );
  }
}
_onAlertBlock(context) {
  Alert(
    style: AlertStyle(
      backgroundColor: Color.fromRGBO(35, 40, 59, 1.0),
      titleStyle: TextStyle(fontFamily: 'Montserrat',color: Colors.white),
      descStyle: TextStyle(fontFamily: 'Montserrat',color: Colors.white),
    ),
    context: context,
    type: AlertType.warning,
    title: "Report User",
    desc: "Do you want to report the User?",
    buttons: [
      DialogButton(
        child: Text(
          "Report",
          style: TextStyle(color: Colors.white, fontSize: 20,fontFamily: 'Montserrat',),
        ),
        onPressed: () => Navigator.pop(context),
        gradient: LinearGradient(colors: [
          Colors.deepPurpleAccent,
          Color(0xFF01BAEF),
        ]),
      ),
    ],
  ).show();
}
