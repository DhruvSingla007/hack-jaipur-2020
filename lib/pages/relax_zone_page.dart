import 'package:hackjaipur2020/minigamefiar/match_page.dart';
import 'package:hackjaipur2020/minigamequizzler/quiz_game.dart';
import 'package:hackjaipur2020/minigameminesweeper/minesweeper.dart';

import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:music_player/music_player.dart';

class RelaxZonePage extends StatefulWidget {
  static const String routeName = '/relax-page';

  @override
  _RelaxZonePageState createState() => _RelaxZonePageState();
}

class _RelaxZonePageState extends State<RelaxZonePage> {
  MusicPlayer musicPlayer;
  String _duration = "";
  final _durationInputController = new TextEditingController();

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Initializing the Music Player and adding a single [PlaylistItem]
  Future<void> initPlatformState() async {
    musicPlayer = MusicPlayer();
  }

  Future<bool> _onDurationButtonPressed(BuildContext context) {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return new AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(30.0),
            ),
            backgroundColor: Color(0xffCBE7EA),
            title: Center(
              child: Text(
                "Set Duration for song",
                style: TextStyle(color: Colors.black, fontFamily: 'OpenSans'),
              ),
            ),
            content: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 120,
                child: Column(
                  children: <Widget>[
                    TextField(
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.only(top: 14.0),
                          prefixIcon: Icon(
                            Icons.edit_attributes,
                            color: Colors.black,
                          ),
                          hintText: 'Set the duration',
                          hintStyle: TextStyle(
                            color: Colors.black45,
                            fontFamily: 'OpenSans',
                          ),
                        ),
                        onTap: () => setState(() {
                              _duration =
                                  _durationInputController.text.toString();
                            })),
                    SizedBox(
                      height: 20,
                    ),
                    RaisedButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(30.0),
                      ),
                      color: Colors.black,
                      onPressed: () => Navigator.of(context).pop(false),
                      child: Text(
                        'SET',
                        style: TextStyle(
                          fontFamily: 'OpenSans',
                            color: Colors.white,
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 20.0,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 12.0, right: 12.0),
              child: Material(
                color: Color(0xffCBE7EA),
                elevation: 14,
                borderRadius: BorderRadius.circular(30.0),
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Column(
                      children: <Widget>[
                        Text(
                          "Games",
                          style: TextStyle(
                              fontFamily: 'OpenSans',
                              fontSize: 25.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        ListTile(
                          leading: Icon(
                            SimpleLineIcons.game_controller,
                            color: Colors.black,
                          ),
                          title: Text(
                            'Minesweeper Game',
                            style: TextStyle(
                                fontFamily: 'OpenSans', color: Colors.black),
                          ),
                          trailing: CircleAvatar(
                            backgroundColor: Colors.white,
                            child: IconButton(
                              icon: Icon(
                                FlutterIcons.fantasy_flight_games_faw5d,
                                color: Colors.black,
                              ),
                              onPressed: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => MinesweeperGame())),
                            ),
                          ),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.only(left: 16.0, right: 16.0),
                          child: Divider(
                            thickness: 2.0,
                            color: Colors.black,
                          ),
                        ),
                        ListTile(
                          leading: Icon(
                            SimpleLineIcons.game_controller,
                            color: Colors.black,
                          ),
                          title: Text(
                            'Fiar Game',
                            style: TextStyle(
                                color: Colors.black, fontFamily: 'OpenSans'),
                          ),
                          trailing: CircleAvatar(
                            backgroundColor: Colors.white,
                            child: IconButton(
                              icon: Icon(
                                FlutterIcons.games_mdi,
                                color: Colors.black,
                              ),
                              onPressed: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => MatchPage())),
                            ),
                          ),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.only(left: 16.0, right: 16.0),
                          child: Divider(
                            thickness: 2.0,
                            color: Colors.black,
                          ),
                        ),
                        ListTile(
                          leading: Icon(
                            SimpleLineIcons.game_controller,
                            color: Colors.black,
                          ),
                          title: Text(
                            'Quizzler Game',
                            style: TextStyle(
                                color: Colors.black, fontFamily: 'OpenSans'),
                          ),
                          trailing: CircleAvatar(
                            backgroundColor: Colors.white,
                            child: IconButton(
                              icon:
                                  Image.asset('assets/images/google_logo.png'),
                              onPressed: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => QuizPage())),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 12.0, right: 12.0),
              child: Material(
                color: Color(0xffCBE7EA),
                elevation: 14,
                borderRadius: BorderRadius.circular(30.0),
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Column(
                      children: <Widget>[
                        Text(
                          "Music",
                          style: TextStyle(
                              fontFamily: 'OpenSans',
                              fontSize: 25.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        ListTile(
                          leading: CircleAvatar(
                            backgroundColor: Colors.white,
                            child: IconButton(
                              icon: Icon(Icons.edit, color: Colors.black),
                              onPressed: () =>
                                  _onDurationButtonPressed(context),
                            ),
                          ),
                          title: Text(
                            'Music One',
                            style: TextStyle(
                                color: Colors.black, fontFamily: 'OpenSans'),
                          ),
                          trailing: CircleAvatar(
                            backgroundColor: Colors.white,
                            child: IconButton(
                              icon: Icon(
                                FlutterIcons.play_video_fou,
                                color: Colors.black,
                              ),
                              onPressed: () => musicPlayer.play(MusicItem(
                                trackName: 'Sample',
                                albumName: 'Sample Album',
                                artistName: 'Sample Artist',
                                url: 'https://goo.gl/5RQjTQ',
                                coverUrl: 'https://goo.gl/Wd1yPP',
                                duration: Duration(seconds: 30),
                              )),
                            ),
                          ),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.only(left: 16.0, right: 16.0),
                          child: Divider(
                            thickness: 2.0,
                            color: Colors.black,
                          ),
                        ),
                        ListTile(
                          leading: CircleAvatar(
                            backgroundColor: Colors.white,
                            child: IconButton(
                              icon: Icon(Icons.edit, color: Colors.black),
                              onPressed: () =>
                                  _onDurationButtonPressed(context),
                            ),
                          ),
                          title: Text(
                            'Music Two',
                            style: TextStyle(
                                color: Colors.black, fontFamily: 'OpenSans'),
                          ),
                          trailing: CircleAvatar(
                            backgroundColor: Colors.white,
                            child: IconButton(
                              icon: Icon(
                                FlutterIcons.play_video_fou,
                                color: Colors.black,
                              ),
                              onPressed: () => musicPlayer.play(MusicItem(
                                trackName: 'Sample',
                                albumName: 'Sample Album',
                                artistName: 'Sample Artist',
                                url: 'https://goo.gl/5RQjTQ',
                                coverUrl: 'https://goo.gl/Wd1yPP',
                                duration: Duration(seconds: 20),
                              )),
                            ),
                          ),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.only(left: 16.0, right: 16.0),
                          child: Divider(
                            thickness: 2.0,
                            color: Colors.black,
                          ),
                        ),
                        ListTile(
                          leading: CircleAvatar(
                            backgroundColor: Colors.white,
                            child: IconButton(
                              icon: Icon(Icons.edit, color: Colors.black),
                              onPressed: () =>
                                  _onDurationButtonPressed(context),
                            ),
                          ),
                          title: Text(
                            'Music Three',
                            style: TextStyle(
                                color: Colors.black, fontFamily: 'OpenSans'),
                          ),
                          trailing: CircleAvatar(
                            backgroundColor: Colors.white,
                            child: IconButton(
                              icon: Icon(
                                FlutterIcons.play_video_fou,
                                color: Colors.black,
                              ),
                              onPressed: () => musicPlayer.play(MusicItem(
                                trackName: 'Sample',
                                albumName: 'Sample Album',
                                artistName: 'Sample Artist',
                                url: 'https://goo.gl/5RQjTQ',
                                coverUrl: 'https://goo.gl/Wd1yPP',
                                duration: Duration(seconds: 30),
                              )),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
