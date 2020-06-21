import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hackjaipur2020/config.dart';
import 'package:hackjaipur2020/widgets/prevention_card.dart';
import 'package:hackjaipur2020/widgets/service_card.dart';
import 'package:hackjaipur2020/widgets/starts_card.dart';


class CoronaTracker extends StatefulWidget {

  static const String routeName = '/corona-tracker-page';
  @override
  _CoronaTrackerState createState() => _CoronaTrackerState();
}

class _CoronaTrackerState extends State<CoronaTracker> {

  _buildAppTitle(String title) {
    return Text(
      title,
      style: Config.titleStyle,
    );
  }

  _buildMyLocation() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Icon(FontAwesomeIcons.mapMarkerAlt,
            color: Config.primaryColor, size: 14),
        SizedBox(width: 4),
        Text(
          'Nairobi',
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w500,
            fontSize: 16,
            color: Config.primaryColor,
          ),
        ),
        SizedBox(width: 4),
        Icon(FontAwesomeIcons.chevronDown,
            color: Config.primaryColor, size: 14),
      ],
    );
  }

  _buildMainTitle() {
    return RichText(
        text: TextSpan(
            text: 'Aapka',
            style: GoogleFonts.poppins(
              color: Config.primaryColor,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
            children: <TextSpan>[
              TextSpan(
                text: 'vaidya',
                style: GoogleFonts.poppins(
                  color: Config.redColor,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              )
            ]));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 60),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                _buildMainTitle()
              ],
            ),
            SizedBox(height: 36),
            _buildAppTitle('What are you looking for ?'),
            SizedBox(height: 36),

            // Make a horizontal Listview

            Container(
              height: 190,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: <Widget>[
                  ServiceCard(
                      name: 'General\nCheck Up',
                      icon: FontAwesomeIcons.heartbeat,
                      color: Config.blueColor),
                  ServiceCard(
                      name: 'Chat\nWith Doctor',
                      icon: FontAwesomeIcons.commentMedical,
                      color: Config.redColor),
                  ServiceCard(
                      name: 'Health\nNews',
                      icon: FontAwesomeIcons.rss,
                      color: Config.orangeColor),
                  ServiceCard(
                      name: 'Get Doctor\nAdvice',
                      icon: FontAwesomeIcons.userMd,
                      color: Config.greenColor),
                ],
              ),
            ),

            SizedBox(height: 36),

            _buildAppTitle('Disease: Covid-19'),
            SizedBox(height: 24),

            // How Stats card looks like
            //Enclose stats in horizontal list view

            LimitedBox(
              maxHeight: 218,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: <Widget>[
                  StatsCard(
                      country: 'Worldwide', infected: "8.8M", dead: "465K", cured: "4.37M"),
                  StatsCard(
                      country: 'US', infected: "2.3M", dead: "122K", cured: "716K"),
                  StatsCard(
                      country: 'Brazil', infected: "1.07M", dead: "50K", cured: "543K"),
                  StatsCard(country: 'Russia', infected: "585K", dead: "8K", cured: "340K"),
                  StatsCard(country: 'India', infected: "410K", dead: "13K", cured: "228K"),
                  StatsCard(
                      country: 'UK', infected: "303K", dead: "42.5K", cured: "-"),
                ],
              ),
            ),

            SizedBox(height: 24),

            _buildAppTitle('Preventive Measures'),
            SizedBox(height: 16),

            // Preventive measures widgets

            LimitedBox(
              maxHeight: 100,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: <Widget>[
                  PreventionCard(
                    imageUrl: 'assets/images/hands.jpg',
                    title: 'Wash Hands Often',
                  ),
                  PreventionCard(
                    imageUrl: 'assets/images/distance.jpg',
                    title: 'Keep Social Distance',
                  ),
                  PreventionCard(
                    imageUrl: 'assets/images/home.jpg',
                    title: 'Stay at home',
                  ),
                  PreventionCard(
                    imageUrl: 'assets/images/mask.jpg',
                    title: 'Put on Face Masks',
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
