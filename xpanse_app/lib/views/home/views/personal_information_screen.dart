import 'package:flutter/material.dart';
import '../../../utils/typography.dart';
import '../../../utils/colors.dart';

class PersonalInformationScreen extends StatelessWidget {
  const PersonalInformationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Personal Information', style: AppTypography.h1),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const CircleAvatar(
              radius: 40,
              backgroundImage: AssetImage('assets/profile_picture.png'),
            ),
            TextButton(
              onPressed: () {
                // Handle change picture functionality
              },
              child: const Text('Change Picture'),
            ),
            TextField(
                decoration: const InputDecoration(labelText: 'First Name'),
                style: AppTypography.bodyMedium),
            TextField(
                decoration: const InputDecoration(labelText: 'Last Name'),
                style: AppTypography.bodyMedium),
            TextField(
                decoration: const InputDecoration(labelText: 'Email'),
                style: AppTypography.bodyMedium),
            TextField(
              decoration: const InputDecoration(labelText: 'Password'),
              style: AppTypography.bodyMedium,
              obscureText: true,
            ),
            TextField(
              decoration: const InputDecoration(labelText: 'Phone Number'),
              style: AppTypography.bodyMedium,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Save changes
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0x40196c),
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
              child: const Text('Save changes'),
            ),
          ],
        ),
      ),
    );
  }
}
