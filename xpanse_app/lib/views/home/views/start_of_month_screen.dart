import '../../../utils/typography.dart';
import '../../../utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xpanse_app/controllers/profile_controller.dart';

class StartOfMonthScreen extends StatelessWidget {
  const StartOfMonthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ProfileController profileController = Get.find<ProfileController>();
    String? selectedDay;

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
            DropdownButtonFormField<String>(
              items: List.generate(31, (index) {
                int day = index + 1; // Days from 1 to 31
                return DropdownMenuItem(
                  value: day.toString(),
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
              onPressed: () {
                if (selectedDay != null) {
                  profileController.updateStartOfMonth(selectedDay!);
                } else {
                  Get.snackbar('Warning', 'Please select a day.');
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
