import '../../../utils/typography.dart';
import '../../../utils/colors.dart';
import 'package:flutter/material.dart';

class StartOfMonthScreen extends StatelessWidget {
  const StartOfMonthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Start of the Month', style: AppTypography.h1),
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
              items: [
                DropdownMenuItem(
                    child: Text('1', style: AppTypography.bodyMedium),
                    value: '1'),
                DropdownMenuItem(
                    child: Text('2', style: AppTypography.bodyMedium),
                    value: '2'),
                DropdownMenuItem(
                    child: Text('3', style: AppTypography.bodyMedium),
                    value: '3'),
                DropdownMenuItem(
                    child: Text('4', style: AppTypography.bodyMedium),
                    value: '4'),
                DropdownMenuItem(
                    child: Text('5', style: AppTypography.bodyMedium),
                    value: '5'),
                DropdownMenuItem(
                    child: Text('6', style: AppTypography.bodyMedium),
                    value: '6'),
                DropdownMenuItem(
                    child: Text('7', style: AppTypography.bodyMedium),
                    value: '7'),
                DropdownMenuItem(
                    child: Text('8', style: AppTypography.bodyMedium),
                    value: '8'),
                DropdownMenuItem(
                    child: Text('9', style: AppTypography.bodyMedium),
                    value: '9'),
                DropdownMenuItem(
                    child: Text('10', style: AppTypography.bodyMedium),
                    value: '10'),
                DropdownMenuItem(
                    child: Text('11', style: AppTypography.bodyMedium),
                    value: '11'),
                DropdownMenuItem(
                    child: Text('12', style: AppTypography.bodyMedium),
                    value: '12'),
                DropdownMenuItem(
                    child: Text('13', style: AppTypography.bodyMedium),
                    value: '13'),
                DropdownMenuItem(
                    child: Text('14', style: AppTypography.bodyMedium),
                    value: '14'),
                DropdownMenuItem(
                    child: Text('15', style: AppTypography.bodyMedium),
                    value: '15'),
                DropdownMenuItem(
                    child: Text('16', style: AppTypography.bodyMedium),
                    value: '16'),
                DropdownMenuItem(
                    child: Text('17', style: AppTypography.bodyMedium),
                    value: '17'),
                DropdownMenuItem(
                    child: Text('18', style: AppTypography.bodyMedium),
                    value: '18'),
                DropdownMenuItem(
                    child: Text('19', style: AppTypography.bodyMedium),
                    value: '19'),
                DropdownMenuItem(
                    child: Text('20', style: AppTypography.bodyMedium),
                    value: '20'),
                DropdownMenuItem(
                    child: Text('21', style: AppTypography.bodyMedium),
                    value: '21'),
                DropdownMenuItem(
                    child: Text('22', style: AppTypography.bodyMedium),
                    value: '22'),
                DropdownMenuItem(
                    child: Text('23', style: AppTypography.bodyMedium),
                    value: '23'),
                DropdownMenuItem(
                    child: Text('24', style: AppTypography.bodyMedium),
                    value: '24'),
                DropdownMenuItem(
                    child: Text('25', style: AppTypography.bodyMedium),
                    value: '25'),
                DropdownMenuItem(
                    child: Text('26', style: AppTypography.bodyMedium),
                    value: '26'),
                DropdownMenuItem(
                    child: Text('27', style: AppTypography.bodyMedium),
                    value: '27'),
                DropdownMenuItem(
                    child: Text('28', style: AppTypography.bodyMedium),
                    value: '28'),
                DropdownMenuItem(
                    child: Text('29', style: AppTypography.bodyMedium),
                    value: '29'),
                DropdownMenuItem(
                    child: Text('30', style: AppTypography.bodyMedium),
                    value: '30'),
                DropdownMenuItem(
                    child: Text('31', style: AppTypography.bodyMedium),
                    value: '31'),
              ],
              onChanged: (value) {},
              decoration: InputDecoration(
                labelText: 'Select Start of the Month',
                labelStyle: AppTypography.bodyMedium,
              ),
            ),
            SizedBox(height: 20),
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
