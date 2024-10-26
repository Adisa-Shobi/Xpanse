import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xpanse_app/routes/route_names.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Write your code here
    return Center(
      child: TextButton(
          onPressed: () => {
                Get.toNamed(RouteNames.login),
              },
          child: const Text('Login')),
    );
  }
}
