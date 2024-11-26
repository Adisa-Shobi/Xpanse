import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../../utils/colors.dart';
import '../../../utils/typography.dart';
import 'package:xpanse_app/controllers/profile_controller.dart';

class PersonalInformationScreen extends StatelessWidget {
  PersonalInformationScreen({super.key});

  // Access the ProfileController
  final ProfileController profileController = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    // TextControllers for form fields
    final TextEditingController firstNameController =
        TextEditingController(text: profileController.firstName.value);
    final TextEditingController lastNameController =
        TextEditingController(text: profileController.lastName.value);
    final TextEditingController emailController =
        TextEditingController(text: profileController.email.value);
    final TextEditingController phoneController =
        TextEditingController(text: profileController.phoneNumber.value);

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
              Obx(() => CircleAvatar(
                    radius: 40,
                    backgroundImage:
                        NetworkImage(profileController.profileImageUrl.value),
                  )),
              TextButton(
                onPressed: () {
                  // Handle change picture functionality
                  profileController.changeProfileImage();
                },
                child: Text(
                  'Change Picture',
                  style: AppTypography.bodyMedium.copyWith(
                    color: Colors.grey,
                  ),
                ),
              ),
              TextField(
                controller: firstNameController,
                decoration: InputDecoration(
                  labelText: 'First Name',
                  labelStyle: AppTypography.caption,
                ),
                style: AppTypography.bodyMedium,
              ),
              TextField(
                controller: lastNameController,
                decoration: InputDecoration(
                  labelText: 'Last Name',
                  labelStyle: AppTypography.caption,
                ),
                style: AppTypography.bodyMedium,
              ),
              TextField(
                controller: emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  labelStyle: AppTypography.caption,
                ),
                style: AppTypography.bodyMedium,
              ),
              TextField(
                controller: phoneController,
                decoration: InputDecoration(
                  labelText: 'Phone Number',
                  labelStyle: AppTypography.caption,
                ),
                style: AppTypography.bodyMedium,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  _saveChanges(
                    firstNameController.text,
                    lastNameController.text,
                    emailController.text,
                    phoneController.text,
                  );
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

  void _saveChanges(
      String firstName, String lastName, String email, String phoneNumber) {
    // Trigger profile update
    profileController.updateProfileData(
      firstName: firstName,
      lastName: lastName,
      phoneNumber: phoneNumber,
      email: email,
    );
  }
}
