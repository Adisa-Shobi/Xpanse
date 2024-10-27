import 'package:flutter/material.dart';

class StartOfWeekScreen extends StatelessWidget {
  const StartOfWeekScreen({super.key});

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
              items: const [
                DropdownMenuItem(value: 'Monday', child: Text('Monday')),
                DropdownMenuItem(value: 'Tuesday', child: Text('Tuesday')),
                DropdownMenuItem(value: 'Wednesday', child: Text('Wednesday')),
                DropdownMenuItem(value: 'Thursday', child: Text('Thursday')),
                DropdownMenuItem(value: 'Friday', child: Text('Friday')),
                DropdownMenuItem(value: 'Saturday', child: Text('Saturday')),
                DropdownMenuItem(value: 'Sunday', child: Text('Sunday')),
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
