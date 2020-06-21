import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

class IndMedicineListTile extends StatelessWidget {
  final String imageUrl;
  final String name;
  final String availability;
  final String uses;
  final String precaution;

  IndMedicineListTile({
    @required this.imageUrl,
    @required this.name,
    @required this.availability,
    @required this.uses,
    @required this.precaution,
  });

  Widget makeListTile(BuildContext context) {
    return Container(
      color: Color(0xffCBE7EA),
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 150.0,
                width: 100.0,
                color: Colors.black,
                child: Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Image.asset(imageUrl),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 5,
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Icon(
                        Icons.brightness_medium,
                        color: Color(0xff5cb3bc),
                        size: 20.0,
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Text(
                          name,
                          style: TextStyle(
                            fontFamily: 'OpenSans',
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
                  children: <Widget>[
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Icon(
                            Icons.event_available,
                            color: Color(0xff5cb3bc),
                            size: 15.0,
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Text(
                              availability,
                              style: TextStyle(
                                fontFamily: 'OpenSans',
                                color: Colors.black,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Icon(
                            Icons.label_important,
                            color: Color(0xff5cb3bc),
                            size: 15.0,
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Text(
                              uses,
                              style: TextStyle(
                                fontFamily: 'OpenSans',
                                color: Colors.black,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Icon(
                            FlutterIcons.alarm_mdi,
                            color: Color(0xff5cb3bc),
                            size: 15.0,
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Text(
                              precaution,
                              style: TextStyle(
                                fontFamily: 'OpenSans',
                                color: Colors.black,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5.0,
      margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
      child: Container(
        child: makeListTile(context),
      ),
    );
  }
}
