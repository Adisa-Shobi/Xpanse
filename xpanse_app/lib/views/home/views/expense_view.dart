import 'package:flutter/material.dart';
import 'package:xpanse_app/utils/colors.dart';
import 'package:xpanse_app/utils/spcaing.dart';
import 'package:xpanse_app/utils/typography.dart';
import 'package:xpanse_app/views/home/views/home_view.dart';
// import 'package:xpanse_app/utils/spacing.dart';

class ExpensesView extends StatelessWidget {
  const ExpensesView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: Spacing.m),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Spacing.vertical(Spacing.l),
              getHeading(title: 'Expenses Overview'),
              const SizedBox(height: 24),
              _buildBudgetCards(),
              const SizedBox(height: 24),
              _buildExpensesOverview(),
              const SizedBox(height: 24),
              _buildSetExpensesSection(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBudgetCards() {
    return Row(
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFF6B21A8),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'This Month Budget',
                  style: AppTypography.bodyMedium.copyWith(
                    color: Colors.white,
                  ),
                ),
                Spacing.vertical(Spacing.xs),
                Text(
                  'Rwf 800,000',
                  style: AppTypography.h3.copyWith(
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.green.shade700,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Available Balance',
                  style: AppTypography.bodyMedium.copyWith(
                    color: Colors.white,
                  ),
                ),
                Spacing.vertical(Spacing.xs),
                Text(
                  'Rwf 800,000',
                  style: AppTypography.h3.copyWith(
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildExpensesOverview() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        // Main Row to put expenses and chart side by side
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Left side - Expenses list
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildExpenseItem('Home', 4.6),
              _buildExpenseItem('Home', 4.6),
              _buildExpenseItem('Home', 4.6),
              _buildExpenseItem('Home', 4.6),
            ],
          ),

          // Right side - Circular chart with month selector
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Custom circular progress indicator
              SizedBox(
                width: 120, // Adjust size as needed
                height: 120,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    // Circular progress indicators
                    SizedBox(
                      width: 100,
                      height: 100,
                      child: CircularProgressIndicator(
                        value: 0.7, // Adjust value as needed
                        strokeWidth: 8,
                        backgroundColor: Colors.grey[300],
                        color: Colors.green, // Primary color
                      ),
                    ),
                    const SizedBox(
                      width: 100,
                      height: 100,
                      child: CircularProgressIndicator(
                        value: 0.3, // Adjust value as needed
                        strokeWidth: 8,
                        backgroundColor: Colors.transparent,
                        color: Colors.orange, // Secondary color
                      ),
                    ),
                    // Month selector in center
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey[300]!),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'June',
                            style: AppTypography.bodyLarge,
                          ),
                          Spacing.horizontal(Spacing.xs),
                          const Icon(
                            Icons.keyboard_arrow_down,
                            size: 16,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildExpenseItem(String category, double amount) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(2),
            decoration: BoxDecoration(
              // color: AppColors.primary.withOpacity(0.1),
              border: Border.all(
                color: AppColors.primary,
              ),
              borderRadius: BorderRadius.circular(5),
            ),
            child: const Icon(
              Icons.home,
              color: AppColors.primary,
              size: 12,
            ),
          ),
          Spacing.horizontal(Spacing.xs),
          Text(
            category,
            style: AppTypography.bodyLarge.copyWith(
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(width: 8),
          Text(
            '${amount.toStringAsFixed(1)}%',
            style: AppTypography.bodyLarge,
          ),
        ],
      ),
    );
  }

  Widget _buildSetExpensesSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Set Expenses',
              style: AppTypography.h3,
            ),
            TextButton.icon(
              onPressed: () {},
              icon: const Icon(
                Icons.add_circle_outline,
              ),
              label: Text(
                'New Category',
                style: AppTypography.bodyLarge.copyWith(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w500,
                ),
              ),
              style: TextButton.styleFrom(
                foregroundColor: const Color(0xFF6B21A8),
              ),
            ),
          ],
        ),
        Spacing.vertical(Spacing.s),
        Text(
          'Tap on the icon to set budget amount',
          style: AppTypography.caption.copyWith(
            color: Colors.grey,
          ),
        ),
        const SizedBox(height: 16),
        GridView.count(
          shrinkWrap: true,
          crossAxisCount: 2,
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
          childAspectRatio: 1.5,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            _buildCategoryCard('Home', 'Rwf 300,000', Colors.blue[50]!),
            _buildCategoryCard('Food', 'Rwf 350,000', Colors.green[50]!),
            _buildCategoryCard('Transport', 'Rwf 50,000', Colors.pink[50]!),
            _buildCategoryCard('Groceries', 'Rwf 100,000', Colors.orange[50]!),
          ],
        ),
      ],
    );
  }

  Widget _buildCategoryCard(
      String title, String amount, Color backgroundColor) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(
              Icons.home,
              color: Color(0xFF6B21A8),
              size: 20,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            title,
            style: const TextStyle(
              fontSize: 8,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            amount,
            style: const TextStyle(
              fontSize: 8,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNavBar() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: BottomNavigationBar(
        currentIndex: 1,
        selectedItemColor: const Color(0xFF6B21A8),
        unselectedItemColor: Colors.grey,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart),
            label: 'Expenses',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
