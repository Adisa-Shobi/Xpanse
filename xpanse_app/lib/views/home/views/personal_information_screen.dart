import 'package:flutter/material.dart';

class PersonalInformationScreen extends StatelessWidget {
  const PersonalInformationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Personal Information'),
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
              backgroundImage: AssetImage(
                  'assets/profile_picture.png'), // Replace with your image asset
            ),
            TextButton(
              onPressed: () {
                // Handle change picture functionality
              },
              child: const Text('Change Picture'),
            ),
            const TextField(
              decoration: InputDecoration(labelText: 'First Name'),
            ),
            const TextField(
              decoration: InputDecoration(labelText: 'Last Name'),
            ),
            const TextField(
              decoration: InputDecoration(labelText: 'Email'),
            ),
            const TextField(
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            const TextField(
              decoration: InputDecoration(labelText: 'Phone Number'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Save changes
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0x0040196c), // Button color
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
