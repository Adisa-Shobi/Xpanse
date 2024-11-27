import 'package:xpanse_app/controllers/home_controller.dart';
import 'package:xpanse_app/utils/snack_bar.dart';

import '../../../utils/typography.dart';
import '../../../utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xpanse_app/controllers/profile_controller.dart';

class StartOfMonthScreen extends GetWidget<HomeController> {
  int get startMonth => controller.userData.value!.startMonth;
  int? selectedDay;
  StartOfMonthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ProfileController profileController = Get.find<ProfileController>();

    return Scaffold(
      appBar: AppBar(
        title: Text('Start of the Month', style: AppTypography.h3),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Customize Your Financial Rhythm. Choose the Day Your Month Begins',
              style: AppTypography.bodyLarge,
            ),
            const SizedBox(height: 20),
            DropdownButtonFormField<int>(
              value: startMonth,
              items: List.generate(31, (index) {
                int day = index + 1; // Days from 1 to 31
                return DropdownMenuItem(
                  value: day,
                  child: Text(day.toString(), style: AppTypography.bodyMedium),
                );
              }),
              onChanged: (value) {
                selectedDay = value; // Store selected day
              },
              decoration: InputDecoration(
                labelText: 'Select Start of the Month',
                labelStyle: AppTypography.bodyMedium,
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
              ),
              onPressed: () async {
                if (selectedDay != null) {
                  await controller
                      .updateUserData(controller.userData.value!.copyWith(
                    startMonth: selectedDay!,
                  ));

                  Navigator.pop(context);
                } else {
                  warningMessage(message: 'Please select a day.');
                }
              },
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
    );
  }
}
