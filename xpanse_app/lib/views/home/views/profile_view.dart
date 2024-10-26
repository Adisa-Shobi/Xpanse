import 'package:flutter/material.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Profile'),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
        child: Column(
          children: [
            // Profile picture and user information
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundImage: AssetImage(
                      'assets/profile_picture.png'), // Replace with your image asset
                ),
              ],
            ),
            const SizedBox(height: 8),
            const Text(
              'Ademola Oshinogbesan',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Text(
              '(+250) 792 402 821',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 32),

            // Options list
            Expanded(
              child: ListView(
                children: [
                  _buildProfileOption(
                    context,
                    icon: Icons.person,
                    title: 'Personal Information',
                  ),
                  _buildProfileOption(
                    context,
                    icon: Icons.calendar_today,
                    title: 'Start of Week',
                  ),
                  _buildProfileOption(
                    context,
                    icon: Icons.calendar_month,
                    title: 'Start of Month',
                  ),
                  const SizedBox(height: 16),
                  _buildProfileOption(
                    context,
                    icon: Icons.help_outline,
                    title: 'FAQ',
                  ),
                  _buildProfileOption(
                    context,
                    icon: Icons.contact_mail,
                    title: 'Contact Us',
                  ),
                  const SizedBox(height: 16),

                  // Log Out button
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: OutlinedButton.icon(
                      onPressed: () {
                        // Handle logout functionality
                      },
                      icon: const Icon(Icons.logout, color: Colors.redAccent),
                      label: const Text(
                        'Log Out',
                        style: TextStyle(color: Colors.redAccent),
                      ),
                      style: OutlinedButton.styleFrom(
                        backgroundColor: Colors.red[50],
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        side: BorderSide(
                            color: Colors.redAccent.withOpacity(0.2)),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget for profile options
  Widget _buildProfileOption(BuildContext context,
      {required IconData icon, required String title}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        leading: Icon(icon, color: Colors.blue),
        title: Text(
          title,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        trailing: const Icon(Icons.arrow_forward_ios, color: Colors.grey),
        onTap: () {
          // Handle option tap
        },
        tileColor: Colors.grey[100],
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }
}
