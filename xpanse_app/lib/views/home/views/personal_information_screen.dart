import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xpanse_app/utils/colors.dart';
import '../../../utils/typography.dart';

class PersonalInformationScreen extends StatelessWidget {
  const PersonalInformationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Personal Information', style: AppTypography.h3),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const CircleAvatar(
                radius: 40,
                backgroundImage:
                    AssetImage('assets/images/profile_picture.png'),
              ),
              TextButton(
                onPressed: () {
                  // Handle change picture functionality
                },
                child: Text(
                  'Change Picture',
                  style: AppTypography.bodyMedium.copyWith(
                    color: Colors.grey,
                  ),
                ),
              ),
              TextField(
                  decoration: InputDecoration(
                    labelText: 'First Name',
                    labelStyle: AppTypography.caption,
                  ),
                  style: AppTypography.bodyMedium),
              TextField(
                  decoration: InputDecoration(
                    labelText: 'Last Name',
                    labelStyle: AppTypography.caption,
                  ),
                  style: AppTypography.bodyMedium),
              TextField(
                  decoration: InputDecoration(
                    labelText: 'Email',
                    labelStyle: AppTypography.caption,
                  ),
                  style: AppTypography.bodyMedium),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Password',
                  labelStyle: AppTypography.caption,
                ),
                style: AppTypography.bodyMedium,
                obscureText: true,
              ),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Phone Number',
                  labelStyle: AppTypography.caption,
                ),
                style: AppTypography.bodyMedium,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Save changes
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  padding: const EdgeInsets.symmetric(
                      vertical: 16.0, horizontal: 32.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  textStyle: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                child: Text(
                  'Save changes',
                  style: AppTypography.button.copyWith(
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
