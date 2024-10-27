import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xpanse_app/components/image_icon.dart';
import 'package:xpanse_app/controllers/home_controller.dart';
import 'package:xpanse_app/views/home/views/expense_view.dart';
import 'package:xpanse_app/utils/colors.dart';
import 'package:xpanse_app/utils/typography.dart';
import 'package:xpanse_app/views/home/views/home_view.dart';
import 'package:xpanse_app/views/home/views/profile_view.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  static List<Widget> homePageViews = [
    HomeView(),
    ExpensesView(),
    ProfileView(),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GetBuilder<HomeController>(
        init: HomeController(),
        builder: (controller) {
          return Scaffold(
            body: Obx(() => homePageViews[controller.currentIndex.value]),
            bottomNavigationBar: Obx(
              () => BottomNavigationBar(
                unselectedLabelStyle: AppTypography.caption,
                selectedLabelStyle: AppTypography.caption.copyWith(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w600,
                ),
                backgroundColor: Colors.white,
                currentIndex: controller.currentIndex.value,
                onTap: controller.changeIndex,
                items: const [
                  BottomNavigationBarItem(
                    icon: CustomIcon(
                      imagePath: 'assets/images/home.png',
                      size: 20,
                    ),
                    label: 'Home',
                  ),
                  BottomNavigationBarItem(
                    icon: CustomIcon(
                      imagePath: 'assets/images/expenses.png',
                      size: 20,
                    ),
                    label: 'Expenses',
                  ),
                  BottomNavigationBarItem(
                    icon: CustomIcon(
                      imagePath: 'assets/images/profile.png',
                      size: 20,
                    ),
                    label: 'Profile',
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
