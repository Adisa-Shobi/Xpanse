import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xpanse_app/routes/route_names.dart';

class OnboardingScreen2 extends StatelessWidget {
  const OnboardingScreen2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                margin: const EdgeInsets.only(top: 100.0),
                child: Image.asset(
                  'assets/images/Onboarding 2.png',
                  width: 400,
                  height: 250,
                ),
              ), //

              const Text(
                'Manage your money\n            wisely',
                style: const TextStyle(
                  fontFamily: 'Montserrat',
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const Text(
                '     Track your money flows, balance, and \n       make everyday transactions on the go.',
                style: const TextStyle(
                  color: const Color(0x80000000),
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
                    Get.toNamed(RouteNames.login);
                  },
                  label: const Text(
                    'Get started',
                    style: const TextStyle(
                        fontFamily: 'Montserrat',
                        fontSize: 16,
                        fontWeight: FontWeight.w500),
                  ),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: const Color(0xFF40196C),
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
                  onPressed: () {
                    Get.offAllNamed(RouteNames.login);
                  },
                  label: const Text(
                    'Sign-in',
                    style: const TextStyle(
                        fontFamily: 'Montserrat',
                        fontSize: 16,
                        fontWeight: FontWeight.w500),
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
          ),
        ), //children,
      ),
    );
  }
}





//class OnboardingPage extends StatelessWidget {
//  const OnboardingPage({super.key});
//
//  @override
//  Widget build(BuildContext context) {
//    // Write your code here
//    return Center(
//      child: TextButton(
//          onPressed: () => {
//                Get.toNamed(RouteNames.login),
//              },
//          child: const Text('Login')),
//    );
//  }
//}
