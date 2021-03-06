import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hackjaipur2020/pages/home_page.dart';
import 'package:hackjaipur2020/widgets/colors.dart';
import 'package:hackjaipur2020/widgets/custom_button.dart';
import 'package:hackjaipur2020/widgets/svg_label.dart';

class BenefitsSubscreen extends StatelessWidget {
  const BenefitsSubscreen({
    Key key,
    this.controller,
  }) : super(key: key);

  final ScrollController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height: 200.0,
          ),
          Text(
            'All medical benefits'.toUpperCase(),
            style: GoogleFonts.nunito(
              color: CustomColors.textGreen,
              fontSize: 15,
              fontWeight: FontWeight.w900,
            ),
          ),
          SizedBox(
            height: 22,
          ),
          Text(
            'Benefits',
            style: GoogleFonts.openSans(
              color: CustomColors.headerText,
              fontSize: 50,
              fontWeight: FontWeight.w800,
              height: .9,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          SizedBox(
            width: 70,
            height: 5,
            child: Container(
              color: CustomColors.orange,
            ),
          ),
          SizedBox(
            height: 25,
          ),
          Text(
            'Get the most out of your virtual doctor, \nJust like an in-person visit',
            textAlign: TextAlign.center,
            style: GoogleFonts.nunito(
              color: CustomColors.text,
              fontSize: 20,
              fontWeight: FontWeight.w500,
              height: 1.2,
            ),
          ),
          SizedBox(
            height: 50,
          ),
          Text(
            'Your doctor will take your history and symptoms, perform an exam, and may recommend treatment - including prescriptions and lab work. They can also provide a doctor’s note, if needed.',
            textAlign: TextAlign.center,
            style: GoogleFonts.nunito(
              color: CustomColors.text,
              fontSize: 15,
              fontWeight: FontWeight.w500,
              height: 1.2,
            ),
          ),
          SizedBox(height: 45),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SvgLabel(
                assetName: 'assets/svg/mountains.svg',
                label: 'Prime \nview',
              ),
              SizedBox(width: 45),
              SvgLabel(
                assetName: 'assets/svg/stars.svg',
                label: 'Excellent \nquality',
              ),
              SizedBox(width: 45),
              SvgLabel(
                assetName: 'assets/svg/money.svg',
                label: 'Good \nprices',
              ),
            ],
          ),
          SizedBox(height: 90),
          Align(
            alignment: Alignment(.8, 0.0),
            child: CustomButton(
                text: 'Get in touch',
                minWidth: 180,
                onPressed: () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => HomePage()))
//                controller.animateTo(0,
//                    duration: Duration(milliseconds: 2300), curve: Curves.ease);

                ),
          ),
          SizedBox(
            height: 200,
          ),
        ],
      ),
    );
  }
}
