// ignore_for_file: prefer_const_constructors


import 'package:flutter/material.dart';





class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 100.0),
              child: Image.asset(
                'assets/Illustration.png',
                width: 400,
                height: 250,
              ),
            ), //


            Text(
              'Spend your money \n          smarter',
              style: TextStyle(
                fontFamily: 'Montserrat',
                fontSize: 24,
                fontWeight: FontWeight.w700,
              ),
            ),
            Text(
              'Never overspend your money again \n    with smart budgeting features',
              style: TextStyle(
                color: Color(0x80000000),
                fontFamily: 'Montserrat',
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
            ),


            // button one
            Container(
              width: 327,
              height: 56.0,
              margin: const EdgeInsets.symmetric(vertical: 20.0),
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => onboardingScreen2()),
                );
                },
                label: Text(
                  'Next',
                  style: TextStyle(fontFamily: 'Montserrat', fontSize: 16),
                ),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Color(0xFF40196C),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
            ),


            //button 2
            SizedBox(
              width: 327.0,
              height: 56.0,
              child: ElevatedButton.icon(
                onPressed: () {},
                label: Text(
                  'Skip',
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: 16,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.black,
                  backgroundColor: const Color(0xFFF0F5FF),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
            ),
          ],
        ), //children,
      ),
    );
  }
}



