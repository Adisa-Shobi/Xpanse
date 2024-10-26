import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xpanse_app/controllers/home_controller.dart';
import 'package:xpanse_app/views/home/views/expense_view.dart';
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
                currentIndex: controller.currentIndex.value,
                onTap: controller.changeIndex,
                items: const [
                  BottomNavigationBarItem(
                    icon: Icon(
                      Icons.home,
                    ),
                    label: 'Home',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(
                      Icons.add,
                    ),
                    label: 'Expenses',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(
                      Icons.person,
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
