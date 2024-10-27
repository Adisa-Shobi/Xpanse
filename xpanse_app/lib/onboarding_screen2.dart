

import 'package:flutter/material.dart';


class onboardingScreen2 extends StatelessWidget {
  const onboardingScreen2({super.key});


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
                'assets/Onboarding 2.png',
                width: 400,
                height: 250,
              ),
            ), //


            Text(
              'Manage your money\n            wisely',
              style: TextStyle(
                fontFamily: 'Montserrat',
                fontSize: 24,
                fontWeight: FontWeight.w700,
              ),
            ),
            Text(
              '     Track your money flows, balance, and \n       make everyday transactions on the go.',
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
                  'Get started',
                  style: TextStyle(fontFamily: 'Montserrat', fontSize: 16, fontWeight: FontWeight.w500),
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
                  'Sign-in',
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: 16,
                    fontWeight: FontWeight.w500
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



