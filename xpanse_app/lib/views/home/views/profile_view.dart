import 'package:get/get.dart';
import 'package:xpanse_app/controllers/auth_controller.dart';
import 'package:xpanse_app/controllers/home_controller.dart';
import 'package:xpanse_app/routes/route_names.dart';
import 'package:flutter/material.dart';
import 'package:xpanse_app/utils/typography.dart';
import 'personal_information_screen.dart';
import 'start_of_week_screen.dart';
import 'start_of_month_screen.dart';

class ProfileView extends GetWidget<HomeController> {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'My Profile',
          style: AppTypography.h3,
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
        child: Obx(
          () => Column(
            children: [
              // Profile picture and user information
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundImage: AssetImage(
                      'assets/profile_picture.png',
                    ), // Replace with your image asset
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                controller.userMetaData.value?.displayName ?? '',
                style: AppTypography.bodyLarge,
              ),
              Text(controller.userMetaData.value?.email ?? '',
                  style: AppTypography.bodyMedium.copyWith(
                    color: Colors.grey,
                  )),
              const SizedBox(height: 32),

              // Options list
              Expanded(
                child: ListView(
                  children: [
                    _buildProfileOption(
                      context,
                      icon: Icons.person,
                      title: 'Personal Information',
                      screen: PersonalInformationScreen(),
                    ),
                    _buildProfileOption(
                      context,
                      icon: Icons.calendar_today,
                      title: 'Start of Week',
                      screen: const StartOfWeekScreen(),
                    ),
                    _buildProfileOption(
                      context,
                      icon: Icons.calendar_month,
                      title: 'Start of Month',
                      screen: const StartOfMonthScreen(),
                    ),
                    const SizedBox(height: 16),
                    _buildProfileOption(
                      context,
                      icon: Icons.help_outline,
                      title: 'FAQ',
                      screen: Container(), // Replace with the actual screen
                    ),
                    _buildProfileOption(
                      context,
                      icon: Icons.contact_mail,
                      title: 'Contact Us',
                      screen: Container(), // Replace with the actual screen
                    ),
                    const SizedBox(height: 16),

                    // Log Out button
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: OutlinedButton.icon(
                        onPressed: () {
                          AuthService().signOut().then((value) {
                            Get.offAllNamed(RouteNames.login);
                          });
                        },
                        icon: const Icon(Icons.logout, color: Colors.redAccent),
                        label: Text(
                          'Log Out',
                          style: AppTypography.bodyMedium.copyWith(
                            color: Colors.redAccent,
                          ),
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
      ),
    );
  }

  // Widget for profile options
  Widget _buildProfileOption(BuildContext context,
      {required IconData icon, required String title, required Widget screen}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        leading: Icon(icon, color: Colors.blue),
        title: Text(title, style: AppTypography.bodyLarge),
        trailing: const Icon(Icons.arrow_forward_ios, color: Colors.grey),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => screen),
          );
        },
        tileColor: Colors.grey[100],
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }
}
