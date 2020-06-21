import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:hackjaipur2020/about/about_screen.dart';
import 'package:hackjaipur2020/pages/my_profile_page.dart';
import 'package:hackjaipur2020/pages/near_hospital_page.dart';
import 'package:link/link.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';

class GuillotineMenu extends StatefulWidget {
  @override
  _GuillotineMenuState createState() => _GuillotineMenuState();
}

class _GuillotineMenuState extends State<GuillotineMenu>
    with SingleTickerProviderStateMixin {
  final GlobalKey _menuIconkey = GlobalKey();

  final Color _menuBg = Colors.black54;

  Animation<double> _menuAnimation;
  String launchUrl = "";

  Animation<double> _toolbarTitleFadeAnimation;

  AnimationController _guillotineMenuAnimationController;

  @override
  void initState() {
    super.initState();

/*
This is to check the offset of the menu Icon in top left corner.
    // WidgetsBinding.instance.addPostFrameCallback(_getPosition);
*/

    _guillotineMenuAnimationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 750),
    )..addListener(() {
        setState(() {});
      });

    // Menu Animation

    _menuAnimation = Tween(begin: -pi / 2, end: 0.0).animate(CurvedAnimation(
        parent: _guillotineMenuAnimationController,
        curve: Curves.bounceOut,
        reverseCurve: Curves.bounceIn));

    // Toolbar Title Transition

    _toolbarTitleFadeAnimation =
        Tween(begin: 1.0, end: 0.0).animate(_guillotineMenuAnimationController);
  }

  void _showErrorSnackBar() {
    Scaffold.of(context).showSnackBar(
      SnackBar(
        content: Text('Oops... the URL couldn\'t be opened!'),
      ),
    );
  }

  Future<dynamic> _launchUrl(String url) async {
    setState(() {
      launchUrl = url;
    });
    if (await canLaunch(launchUrl)) {
      await launch(launchUrl);
    } else {
      throw 'Could not launch $launchUrl';
    }
  }

  Widget _buildURLLogos({Icon iconUsed, String pageURL}) {
    return GestureDetector(
      onTap: () => _launchUrl(pageURL),
      child: Padding(
        padding: const EdgeInsets.only(
          left: 8.0,
          right: 25.0,
        ),
        child: iconUsed,
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _guillotineMenuAnimationController.dispose();
  }

  void _onMenuIconClick() {
    if (_isMenuVisible()) {
      _guillotineMenuAnimationController.reverse();
    } else {
      _guillotineMenuAnimationController.forward();
    }
  }

  bool _isMenuVisible() {
    final AnimationStatus status = _guillotineMenuAnimationController.status;
    return status == AnimationStatus.completed ||
        status == AnimationStatus.forward;
  }

  Future<bool> _onSettingsButtonsPressed(BuildContext context) {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return new AlertDialog(
            backgroundColor: Colors.black,
            title: Text(
              'Covid Tracker',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontFamily: 'OpenSans',
                  color: Colors.white,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold),
            ),
            content: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 60,
                child: Center(
                  child: Text(
                    'Do you want to know about the current status of Pandemic?',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontFamily: 'OpenSans',
                        color: Colors.grey,
                        fontWeight: FontWeight.normal,
                        fontSize: 16.0),
                  ),
                ),
              ),
            ),
            actions: <Widget>[
              Row(
                children: <Widget>[
                  Link(
                    child: FlatButton(
                      child: Text('YES',
                          style: TextStyle(
                              fontFamily: 'OpenSans',
                              color: Colors.greenAccent,
                              fontSize: 20.0)),
                    ),
                    url: 'https://www.orfonline.org/covid19-tracker/',
                    onError: _showErrorSnackBar,
                  ),
                  SizedBox(
                    width: 116,
                  ),
                  FlatButton(
                    onPressed: () => Navigator.of(context).pop(false),
                    child: Text('NO',
                        style: TextStyle(
                            fontFamily: 'OpenSans',
                            color: Colors.greenAccent,
                            fontSize: 20.0)),
                  )
                ],
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: _menuAnimation.value,
      origin: Offset(32.0, 50.0),
      alignment: Alignment.topLeft,
      child: Material(
        color: _menuBg,
        child: SafeArea(
          child: Container(
            height: double.infinity,
            width: double.infinity,
            child: Row(
              children: <Widget>[
                Expanded(
                  flex: 2,
                  child: _toolbar(),
                ),
                Expanded(
                  flex: 8,
                  child: _menuItems(),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _toolbar() {
    return RotatedBox(
      quarterTurns: 1,
      child: Container(
        // padding: const EdgeInsets.only(left: 16),
        child: Row(
          children: <Widget>[_toolbarIcon(), _toolbarTitle()],
        ),
      ),
    );
  }

  Widget _toolbarIcon() {
    return IconButton(
      key: _menuIconkey,
      icon: Icon(
        Icons.menu,
        color: Colors.white,
      ),
      onPressed: () => _onMenuIconClick(),
    );
  }

  Widget _toolbarTitle() {
    return FadeTransition(
      opacity: _toolbarTitleFadeAnimation,
      child: Container(
        margin: const EdgeInsets.only(left: 16),
        child: Text(
          "Activity",
          style: TextStyle(
              fontFamily: 'OpenSans',
              color: Colors.white,
              fontSize: 24,
              letterSpacing: 2.0,
              fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget _menuItems() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: <Widget>[
          ListTile(
            leading: Icon(Icons.person, color: Colors.white),
            title: Text(
              'My Profile',
              style: TextStyle(
                fontFamily: 'OpenSans',
                color: Colors.white,
              ),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MyProfilePage(),
                ),
              );
              // Update the state of the app.
              // ...
            },
          ),
          ListTile(
              leading: Icon(Icons.track_changes, color: Colors.white),
              title: Text(
                'Covid19 Tracker',
                style: TextStyle(
                  fontFamily: 'OpenSans',
                  color: Colors.white,
                ),
              ),
              onTap: () => _onSettingsButtonsPressed(context)),
          ListTile(
            leading: Icon(Icons.local_hospital, color: Colors.white),
            title: Text(
              'Nearby Hospitals',
              style: TextStyle(
                fontFamily: 'OpenSans',
                color: Colors.white,
              ),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => NearHospital(),
                ),
              );

              // Update the state of the app.
              // ...
            },
          ),
          ListTile(
            leading: Icon(Icons.account_box, color: Colors.white),
            title: Text(
              'About Us',
              style: TextStyle(
                fontFamily: 'OpenSans',
                color: Colors.white,
              ),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => HomeScreen(),
                ),
              );
              // Update the state of the app.
              // ...
            },
          ),
          Divider(
            thickness: 2.0,
            color: Colors.white,
          ),
          ListTile(
            leading: Icon(Icons.share, color: Colors.white),
            title: Text(
              'Share',
              style: TextStyle(
                fontFamily: 'OpenSans',
                color: Colors.white,
              ),
            ),
            onTap: () {
              RenderBox box = context.findRenderObject();
              Share.share('Hello this is a test',
                  sharePositionOrigin:
                      box.localToGlobal(Offset.zero) & box.size);
              // Update the state of the app.
              // ...
            },
          ),
          ListTile(
            leading: Icon(Icons.feedback, color: Colors.white),
            title: Text(
              'Feedback',
              style: TextStyle(
                fontFamily: 'OpenSans',
                color: Colors.white,
              ),
            ),
            onTap: () => _launchgmail(),
          ),
          SizedBox(
            height: 100,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(
                    top: 15.0,
                    bottom: 22.0,
                    left: 10.0,
                  ),
                  child: Text(
                    'Follow On',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontFamily: 'Baloo',fontSize: 20.0, color: Colors.white),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    _buildURLLogos(
                        iconUsed: Icon(
                          Feather.facebook,
                          color: Colors.white,
                        ),
                        pageURL: 'https://www.facebook.com/'),
                    _buildURLLogos(
                        iconUsed: Icon(
                          Feather.instagram,
                          color: Colors.white,
                        ),
                        pageURL: 'https://www.instagram.com/'),
                    _buildURLLogos(
                        iconUsed: Icon(
                          Feather.linkedin,
                          color: Colors.white,
                        ),
                        pageURL: 'https://www.linkedin.com/'),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  _launchgmail() async {
    const url =
        'mailto:harshitsingh15967@gmail.com?subject=Feedback&body=Feedback for Our Support';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
