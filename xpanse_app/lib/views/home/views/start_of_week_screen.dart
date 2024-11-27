import 'package:get/get.dart';
import 'package:xpanse_app/controllers/home_controller.dart';

import '../../../utils/typography.dart';
import '../../../utils/colors.dart';
import 'package:flutter/material.dart';

class StartOfWeekScreen extends GetWidget<HomeController> {
  StartOfWeekScreen({super.key});
  int get startWeek => controller.userData.value!.startWeek;
  int? selectedDay;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Start of the Week', style: AppTypography.h3),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Customize Your Financial Rhythm. Choose the Day Your Week Begins',
              style: AppTypography.bodyLarge,
            ),
            const SizedBox(height: 20),
            DropdownButtonFormField<int>(
              value: startWeek,
              items: [
                DropdownMenuItem(
                    child: Text('Monday', style: AppTypography.bodyMedium),
                    value: 0),
                DropdownMenuItem(
                    child: Text('Tuesday', style: AppTypography.bodyMedium),
                    value: 1),
                DropdownMenuItem(
                    child: Text('Wednesday', style: AppTypography.bodyMedium),
                    value: 2),
                DropdownMenuItem(
                    child: Text('Thursday', style: AppTypography.bodyMedium),
                    value: 3),
                DropdownMenuItem(
                    child: Text('Friday', style: AppTypography.bodyMedium),
                    value: 4),
                DropdownMenuItem(
                    child: Text('Saturday', style: AppTypography.bodyMedium),
                    value: 5),
                DropdownMenuItem(
                    child: Text('Sunday', style: AppTypography.bodyMedium),
                    value: 6),
              ],
              onChanged: (value) {
                selectedDay = value; // Store selected day
              },
              decoration: InputDecoration(
                labelText: 'Select Start of the Week',
                labelStyle: AppTypography.bodyMedium,
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
              ),
              onPressed: () async {
                if (selectedDay != null) {
                  await controller
                      .updateUserData(controller.userData.value!.copyWith(
                    startWeek: selectedDay,
                  ));
                  Navigator.pop(context);
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
