import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
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
            _getHeading(),
            Spacing.vertical(Spacing.s),
            _buildBudgetSection(context),
            Spacing.vertical(Spacing.l),
            Expanded(
              child: _buildExpenses(context),
            ),
          ],
        ));
  }

  _getHeading() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Image.network(
        //   'https://via',
        //   width: 50,
        //   height: 50,
        //   fit: BoxFit.cover,
        // ),
        Spacing.horizontal(
          Spacing.s,
        ),
        Text(
          'Good Morning, User', // Replace with user name
          style: AppTypography.h1, // Changed from heading1 to headline1
        )
      ],
    );
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
                // Icon
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Targeted Budget', style: AppTypography.caption),
                    Text('Rwf 800,000', style: AppTypography.h2)
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
                    style: AppTypography.bodyLarge,
                  ),
                  Text(
                    'Rwf 300,000 of Rwf 800,000',
                    style: AppTypography.caption.copyWith(
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
        style: AppTypography.h2,
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
                    Text('Expense Name', style: AppTypography.h2),
                    Text(
                      '3 minutes ago',
                      style: AppTypography.caption.copyWith(
                        fontSize: 10,
                      ),
                    )
                  ],
                )
              ],
            ),
            Text(
              'Rwf 10,000',
              style: AppTypography.h2
                  .copyWith(fontSize: 14, fontWeight: FontWeight.normal),
            )
          ],
        ),
      ),
    );
  }
}
