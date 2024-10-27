import 'package:flutter/material.dart';

class StartOfMonthScreen extends StatelessWidget {
  const StartOfMonthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Start of the Month'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Customize Your Financial Rhythm. Choose the Day Your Month Begins',
            ),
            const SizedBox(height: 20),
            DropdownButtonFormField<String>(
              items: const [
                DropdownMenuItem(value: '1', child: Text('1')),
                DropdownMenuItem(value: '2', child: Text('2')),
                DropdownMenuItem(value: '3', child: Text('3')),
                DropdownMenuItem(value: '4', child: Text('4')),
                DropdownMenuItem(value: '5', child: Text('5')),
                DropdownMenuItem(value: '6', child: Text('6')),
                DropdownMenuItem(value: '7', child: Text('7')),
                DropdownMenuItem(value: '8', child: Text('8')),
                DropdownMenuItem(value: '9', child: Text('9')),
                DropdownMenuItem(value: '10', child: Text('10')),
                DropdownMenuItem(value: '11', child: Text('11')),
                DropdownMenuItem(value: '12', child: Text('12')),
                DropdownMenuItem(value: '13', child: Text('13')),
                DropdownMenuItem(value: '14', child: Text('14')),
                DropdownMenuItem(value: '15', child: Text('15')),
                DropdownMenuItem(value: '16', child: Text('16')),
                DropdownMenuItem(value: '17', child: Text('17')),
                DropdownMenuItem(value: '18', child: Text('18')),
                DropdownMenuItem(value: '19', child: Text('19')),
                DropdownMenuItem(value: '20', child: Text('20')),
                DropdownMenuItem(value: '21', child: Text('21')),
                DropdownMenuItem(value: '22', child: Text('22')),
                DropdownMenuItem(value: '23', child: Text('23')),
                DropdownMenuItem(value: '24', child: Text('24')),
                DropdownMenuItem(value: '25', child: Text('25')),
                DropdownMenuItem(value: '26', child: Text('26')),
                DropdownMenuItem(value: '27', child: Text('27')),
                DropdownMenuItem(value: '28', child: Text('28')),
                DropdownMenuItem(value: '29', child: Text('29')),
                DropdownMenuItem(value: '30', child: Text('30')),
                DropdownMenuItem(value: '31', child: Text('31')),
              ],
              onChanged: (value) {},
              decoration:
                  const InputDecoration(labelText: 'Select Start of the Month'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Save changes
              },
              child: const Text('Save changes'),
            ),
          ],
        ),
      ),
    );
  }
}
