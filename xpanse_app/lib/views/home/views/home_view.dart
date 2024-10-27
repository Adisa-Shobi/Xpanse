import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:xpanse_app/components/image_icon.dart';
import 'package:xpanse_app/utils/colors.dart';
import 'package:xpanse_app/utils/responsive.dart';
import 'package:xpanse_app/utils/spcaing.dart';
import 'package:xpanse_app/utils/typography.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: Spacing.m),
        child: Column(
          children: [
            Spacing.vertical(Spacing.l),
            getHeading(
              title: 'Good morning Ademola',
            ),
            Spacing.vertical(Spacing.m),
            _buildBudgetSection(context),
            Spacing.vertical(Spacing.l),
            Expanded(
              child: _buildExpenses(context),
            ),
          ],
        ));
  }

  _buildBudgetSection(BuildContext context) {
    return Column(
      children: [
        Flex(
          direction: Axis.horizontal,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                const CustomIcon(
                  imagePath: "assets/images/target.png",
                  size: 40,
                ),
                Spacing.horizontal(Spacing.s),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Targeted Budget',
                      style: AppTypography.bodyLarge,
                    ),
                    Spacing.vertical(Spacing.xs),
                    Text(
                      'Rwf 800,000',
                      style: AppTypography.h1.copyWith(
                        height: 1,
                      ),
                    )
                  ],
                )
              ],
            ),
            TextButton(
              onPressed: () {},
              child: const Text('Set'),
            )
          ],
        ),
        Spacing.vertical(Spacing.m),
        Flex(
          direction: Axis.vertical,
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              constraints: BoxConstraints(
                maxWidth: Responsive.widthPercent(context, 100),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text(
                    'This Motnh\'s Budget',
                    style: AppTypography.bodyLarge.copyWith(
                      // color: Colors.black,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    'Rwf 300,000 of Rwf 800,000',
                    style: AppTypography.bodySmall.copyWith(
                      fontSize: 10,
                    ),
                  ),
                ],
              ),
            ),
            Spacing.vertical(Spacing.m),
            LinearPercentIndicator(
              padding: const EdgeInsets.all(0),
              lineHeight: 20.0,
              percent: 0.765,
              progressColor: AppColors.primary,
              barRadius: const Radius.circular(Spacing.s),
              backgroundColor: AppColors.primary.withOpacity(0.2),
              // width: Responsive.widthPercent(context, 100),
            )
          ],
        )
      ],
    );
  }
}

Widget _buildExpenses(BuildContext context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        'Recent Expenses',
        textAlign: TextAlign.start,
        style: AppTypography.h3,
      ),
      Spacing.vertical(Spacing.s),
      Expanded(
        child: ListView.builder(
          itemBuilder: (context, index) {
            return const ExpenseItem();
          },
          itemCount: 10,
        ),
      ),
    ],
  );
}

getHeading({title}) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Container(
        width: 40,
        height: 40,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: const Color(0xFFE8F5E9), // Light green background
        ),
        child: ClipOval(
          child: Image.network(
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSY2r1g-oKe7WxMwyuhsS5reYmvZ8l5fABcsg&s',
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              // Fallback to icon if image fails to load
              return Center(
                child: Icon(
                  Icons.person,
                  color: Colors.grey[600],
                  size: 24,
                ),
              );
            },
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) return child;
              // Show loading indicator while image loads
              return Center(
                child: CircularProgressIndicator(
                  value: loadingProgress.expectedTotalBytes != null
                      ? loadingProgress.cumulativeBytesLoaded /
                          loadingProgress.expectedTotalBytes!
                      : null,
                ),
              );
            },
          ),
        ),
      ),
      Spacing.horizontal(Spacing.l),
      Text(
        title,
        style: AppTypography.h3,
      ),
    ],
  );
}

class ExpenseItem extends StatelessWidget {
  const ExpenseItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Flex(
              direction: Axis.horizontal,
              children: [
                //Icon here
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Expense Name', style: AppTypography.bodyLarge),
                    Text(
                      '3 minutes ago',
                      style: AppTypography.bodyLarge.copyWith(
                        fontSize: 10,
                      ),
                    )
                  ],
                )
              ],
            ),
            Text(
              'Rwf 10,000',
              style: AppTypography.bodyMedium
                  .copyWith(fontSize: 14, fontWeight: FontWeight.normal),
            )
          ],
        ),
      ),
    );
  }
}
