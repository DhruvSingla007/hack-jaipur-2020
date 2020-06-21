import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'login_page.dart';

class MyProfilePage extends StatefulWidget {
  static const String routeName = "/myproflie-page";

  @override
  _MyProfilePageState createState() => _MyProfilePageState();
}

class _MyProfilePageState extends State<MyProfilePage> {
  TextEditingController controllerNickname;
  TextEditingController controllerAboutMe;

  final GoogleSignIn googleSignIn = GoogleSignIn();
  SharedPreferences preferences;

  String id = '';
  String email = "";
  String userName = '';
  String aboutMe = '';
  String photoUrl = '';

  bool isLoading = false;

  final FocusNode focusNodeNickname = new FocusNode();
  final FocusNode focusNodeAboutMe = new FocusNode();

  void readLocal() async {
    preferences = await SharedPreferences.getInstance();
    id = preferences.getString('id') ?? '';
    userName = preferences.getString('userName') ?? '';
    aboutMe = preferences.getString('aboutMe') ?? '';
    email = preferences.getString('email') ?? '';
    photoUrl = preferences.getString('photoUrl') ?? '';

    controllerNickname = new TextEditingController(text: userName);
    controllerAboutMe = new TextEditingController(text: aboutMe);

    // Force refresh input
    setState(() {});
  }

  Future<Null> handleSignOut() async {
    this.setState(() {
      isLoading = true;
    });

    await FirebaseAuth.instance.signOut();
    await googleSignIn.disconnect();
    await googleSignIn.signOut();

    this.setState(() {
      isLoading = false;
    });
  }

  _onAlertButtonsPressed(context) {
    Alert(
      style: AlertStyle(
        backgroundColor: Color(0xffCBE7EA),
        titleStyle: TextStyle(fontFamily: 'OpenSans', color: Colors.black),
        descStyle: TextStyle(fontFamily: 'OpenSans', color: Colors.black),
      ),
      context: context,
      type: AlertType.warning,
      title: "LOG OUT",
      desc: "Do you want to log out your ID ?",
      buttons: [
        DialogButton(
          child: Text(
            "Cancel",
            style: TextStyle(
                fontFamily: 'OpenSans', color: Colors.white, fontSize: 20),
          ),
          onPressed: () => Navigator.pop(context),
          gradient: LinearGradient(colors: [
            Color(0xFF20BF55),
            Color(0xFF01BAEF),
          ]),
        ),
        DialogButton(
          child: Text(
            "Log Out",
            style: TextStyle(
                fontFamily: 'Montserrat', color: Colors.white, fontSize: 20),
          ),
          onPressed: () {
            handleSignOut().then((val) {
              preferences.clear().then((val) {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => LoginPage()),
                    (e) => false);
                //Navigator.pushNamed(context, LoginPage.routeName);
              });
            });
          },
          gradient: LinearGradient(colors: [
            Color.fromRGBO(116, 116, 191, 1.0),
            Color.fromRGBO(52, 138, 199, 1.0)
          ]),
        )
      ],
    ).show();
  }

  Widget _buildProfileCard(String text) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        color: Color(0xffCBE7EA),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        child: ListTile(
          title: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 18.0,
                  fontWeight: FontWeight.w500,
                  color: Colors.black),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMyProfileLogo(String imagePath) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Container(
        child: CircleAvatar(
          backgroundColor: Color(0xffCBE7EA),
          radius: 50.0,
          child: Image.asset(
            imagePath,
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }

  Future<void> _getInfo() async {
    preferences = await SharedPreferences.getInstance();
    setState(() {
      userName = preferences.getString("userName");
      email = preferences.getString("email");
      print(userName);
      print(email);
    });
  }

  @override
  void initState() {
    super.initState();
    readLocal();
    _getInfo();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        //backgroundColor: Colors.black,
        title: Text(
          "Profile Page",
          style: TextStyle(
              fontFamily: 'OpenSans',
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
              color: Colors.black),
        ),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () => _onAlertButtonsPressed(context),
            tooltip: "Log Out",
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Container(
          alignment: Alignment.center,
          child: ListView(
//            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: 30,
              ),
              _buildMyProfileLogo('assets/images/google_logo.png'),
              SizedBox(
                height: 50.0,
              ),
              _buildProfileCard(userName),
              _buildProfileCard(email),
              SizedBox(
                height: 25.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
