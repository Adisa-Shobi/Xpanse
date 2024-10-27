import 'package:flutter/material.dart';

class StartOfWeekScreen extends StatelessWidget {
  const StartOfWeekScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Start of the Week'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Customize Your Financial Rhythm. Choose the Day Your Week Begins',
            ),
            const SizedBox(height: 20),
            DropdownButtonFormField<String>(
              items: [
                DropdownMenuItem(child: Text('Monday'), value: 'Monday'),
                DropdownMenuItem(child: Text('Tuesday'), value: 'Tuesday'),
                DropdownMenuItem(child: Text('Wednesday'), value: 'Wednesday'),
                DropdownMenuItem(child: Text('Thursday'), value: 'Thursday'),
                DropdownMenuItem(child: Text('Friday'), value: 'Friday'),
                DropdownMenuItem(child: Text('Saturday'), value: 'Saturday'),
                DropdownMenuItem(child: Text('Sunday'), value: 'Sunday'),
              ],
              onChanged: (value) {},
              decoration:
                  const InputDecoration(labelText: 'Select Start of the Week'),
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
