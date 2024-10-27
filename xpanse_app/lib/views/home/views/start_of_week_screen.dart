import '../../../utils/typography.dart';
import '../../../utils/colors.dart';
import 'package:flutter/material.dart';

class StartOfWeekScreen extends StatelessWidget {
  const StartOfWeekScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Start of the Week', style: AppTypography.h1),
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
            DropdownButtonFormField<String>(
              items: [
                DropdownMenuItem(
                    child: Text('Monday', style: AppTypography.bodyMedium),
                    value: 'Monday'),
                DropdownMenuItem(
                    child: Text('Tuesday', style: AppTypography.bodyMedium),
                    value: 'Tuesday'),
                DropdownMenuItem(
                    child: Text('Wednesday', style: AppTypography.bodyMedium),
                    value: 'Wednesday'),
                DropdownMenuItem(
                    child: Text('Thursday', style: AppTypography.bodyMedium),
                    value: 'Thursday'),
                DropdownMenuItem(
                    child: Text('Friday', style: AppTypography.bodyMedium),
                    value: 'Friday'),
                DropdownMenuItem(
                    child: Text('Saturday', style: AppTypography.bodyMedium),
                    value: 'Saturday'),
                DropdownMenuItem(
                    child: Text('Sunday', style: AppTypography.bodyMedium),
                    value: 'Sunday'),
              ],
              onChanged: (value) {},
              decoration: InputDecoration(
                labelText: 'Select Start of the Week',
                labelStyle: AppTypography.bodyMedium,
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Save changes
              },
              child: Text('Save changes', style: AppTypography.button),
            ),
          ],
        ),
      ),
    );
  }
}
