import 'package:flutter/material.dart';

class StartOfMonthScreen extends StatelessWidget {
  const StartOfMonthScreen({Key? key}) : super(key: key);

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
              items: [
                DropdownMenuItem(child: Text('1'), value: '1'),
                DropdownMenuItem(child: Text('2'), value: '2'),
                DropdownMenuItem(child: Text('3'), value: '3'),
                DropdownMenuItem(child: Text('4'), value: '4'),
                DropdownMenuItem(child: Text('5'), value: '5'),
                DropdownMenuItem(child: Text('6'), value: '6'),
                DropdownMenuItem(child: Text('7'), value: '7'),
                DropdownMenuItem(child: Text('8'), value: '8'),
                DropdownMenuItem(child: Text('9'), value: '9'),
                DropdownMenuItem(child: Text('10'), value: '10'),
                DropdownMenuItem(child: Text('11'), value: '11'),
                DropdownMenuItem(child: Text('12'), value: '12'),
                DropdownMenuItem(child: Text('13'), value: '13'),
                DropdownMenuItem(child: Text('14'), value: '14'),
                DropdownMenuItem(child: Text('15'), value: '15'),
                DropdownMenuItem(child: Text('16'), value: '16'),
                DropdownMenuItem(child: Text('17'), value: '17'),
                DropdownMenuItem(child: Text('18'), value: '18'),
                DropdownMenuItem(child: Text('19'), value: '19'),
                DropdownMenuItem(child: Text('20'), value: '20'),
                DropdownMenuItem(child: Text('21'), value: '21'),
                DropdownMenuItem(child: Text('22'), value: '22'),
                DropdownMenuItem(child: Text('23'), value: '23'),
                DropdownMenuItem(child: Text('24'), value: '24'),
                DropdownMenuItem(child: Text('25'), value: '25'),
                DropdownMenuItem(child: Text('26'), value: '26'),
                DropdownMenuItem(child: Text('27'), value: '27'),
                DropdownMenuItem(child: Text('28'), value: '28'),
                DropdownMenuItem(child: Text('29'), value: '29'),
                DropdownMenuItem(child: Text('30'), value: '30'),
                DropdownMenuItem(child: Text('31'), value: '31'),
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
