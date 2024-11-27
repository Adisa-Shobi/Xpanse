import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xpanse_app/components/icom_picker.dart';
import 'package:xpanse_app/controllers/home_controller.dart';
import 'package:xpanse_app/services/categories.dart';
import 'package:xpanse_app/utils/colors.dart';
import 'package:xpanse_app/utils/format.dart';
import 'package:xpanse_app/utils/parseMomo.dart';
import 'package:xpanse_app/utils/snack_bar.dart';
import 'package:xpanse_app/utils/spcaing.dart';
import 'package:xpanse_app/utils/typography.dart';
import 'package:xpanse_app/views/home/views/home_view.dart';
import 'dart:math' as math;
// import 'package:xpanse_app/utils/spacing.dart';

class ExpensesView extends GetView<HomeController> {
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
              _buildSetExpensesSection(context),
            ],
          ),
        ),
      ),
    );
  }

  _showBudgetBottomSheet(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    final TextEditingController _categoryNameController =
        TextEditingController();
    final TextEditingController _categoryIconController =
        TextEditingController();
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(Spacing.m),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Create Category',
                style: AppTypography.h3,
              ),
              Spacing.vertical(Spacing.s),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Category Name',
                        labelStyle: AppTypography.bodyMedium.copyWith(
                          color: Colors.grey,
                        ),
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(8),
                          ),
                          borderSide: BorderSide(
                            color: Colors.black,
                            width: 1.0,
                            style: BorderStyle.solid,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: const BorderRadius.all(
                            Radius.circular(8),
                          ),
                          borderSide: BorderSide(
                            color: Colors.black.withOpacity(0.1),
                            width: 1,
                            style: BorderStyle.solid,
                          ),
                        ),
                      ),
                      style: AppTypography.bodyMedium,
                      controller: _categoryNameController,
                      validator: (val) {
                        if (val == null || val.isEmpty) {
                          return 'Please enter a value';
                        }

                        return null;
                      },
                    ),
                    Spacing.vertical(Spacing.s),
                    IconPickerFormField(
                      onSaved: (icon) {
                        if (icon != null) {
                          _categoryIconController.text = icon.name;
                        }
                      },
                    ),
                  ],
                ),
              ),
              Spacing.vertical(Spacing.m),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      final category = Category(
                        id: '',
                        name: _categoryNameController.text.trim().toLowerCase(),
                        userId: controller.user.value.uid,
                        icon: _categoryIconController.text,
                        createdAt: DateTime.now(),
                      );
                      controller.createCategory(category).then((v) {
                        Navigator.pop(context);
                      });
                    }
                  },
                  child: Text(
                    'Create',
                    style: AppTypography.button.copyWith(
                      color: Colors.white,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(Spacing.m),
          topRight: Radius.circular(Spacing.m),
        ),
      ),
      backgroundColor: Colors.white,
    );
  }

  Widget _buildBudgetCards() {
    return Obx(
      () => Row(
        crossAxisAlignment: CrossAxisAlignment.start,
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
                    'Rwf ${controller.userData.value?.budget != null ? formatWithCommas(controller.userData.value!.budget) : '0'}',
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
                    'Rwf ${formatWithCommas(controller.balance.value)}',
                    style: AppTypography.h3.copyWith(
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExpensesOverview() {
    final double otherPercentage = controller.transactions.fold<int>(
          0,
          (prev, element) {
            DateTime now = DateTime.now();
            if (element.timestamp.isAfter(DateTime(now.year, now.month, 1)) &&
                element.type.toString() == TransactionType.SENT.toString() &&
                !controller.categories
                    .take(3)
                    .map((c) => c.name)
                    .contains(element.category)) {
              return prev + element.amount;
            }
            return prev;
          },
        ) /
        controller.monthlyExenditure.value;
    List<MaterialColor> _sectionColors = <MaterialColor>[
      Colors.red,
      Colors.blue,
      Colors.indigo,
      Colors.orange,
    ];
    return Obx(
      () => Container(
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
                ...controller.categories.take(3).map(
                      (category) => _buildExpenseItem(
                        category.name.capitalizeFirst!,
                        category.getFraction(
                              controller.transactions.where((t) {
                                final now = DateTime.now();
                                return t.timestamp.isAfter(
                                        DateTime(now.year, now.month, 1)) &&
                                    t.type.toString() ==
                                        TransactionType.SENT.toString();
                              }).toList(),
                              controller.monthlyExenditure.value,
                            ) *
                            100,
                        icons[category.icon]?.icon ?? Icons.cancel,
                      ),
                    ),
                _buildExpenseItem(
                  'Others',
                  otherPercentage * 100,
                  Icons.home,
                ),
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

                      ...controller.categories
                          .take(3)
                          .map((category) {
                            final colorIndex = controller.categories
                                .take(3)
                                .toList()
                                .indexOf(category);
                            // Calculate the cumulative fraction from previous categories
                            double cumulativeOffset = controller.categories
                                .takeWhile((c) =>
                                    c !=
                                    category) // Take all categories before current one
                                .fold(
                                  otherPercentage,
                                  (sum, prevCategory) =>
                                      sum +
                                      prevCategory.getFraction(
                                          controller.transactions.where((t) {
                                            final now = DateTime.now();
                                            return t.timestamp.isAfter(DateTime(
                                                    now.year, now.month, 1)) &&
                                                t.type.toString() ==
                                                    TransactionType.SENT
                                                        .toString();
                                          }).toList(),
                                          controller.monthlyExenditure.value),
                                );

                            return SizedBox(
                              width: 100,
                              height: 100,
                              child: CircularProgressIndicator(
                                value: cumulativeOffset +
                                    category.getFraction(
                                        controller.transactions.where((t) {
                                          final now = DateTime.now();
                                          return t.timestamp.isAfter(DateTime(
                                                  now.year, now.month, 1)) &&
                                              t.type.toString() ==
                                                  TransactionType.SENT
                                                      .toString();
                                        }).toList(),
                                        controller.monthlyExenditure.value),
                                strokeWidth: 8,
                                backgroundColor: Colors.transparent,
                                color: _sectionColors[colorIndex % 4],
                              ),
                            );
                          })
                          .toList()
                          .reversed
                          .toList(),

                      SizedBox(
                        width: 100,
                        height: 100,
                        child: CircularProgressIndicator(
                          value: otherPercentage, // Adjust value as needed
                          strokeWidth: 8,
                          backgroundColor: Colors.transparent,
                          color: Colors.green, // Primary color
                        ),
                      ),

                      // Month selector in center
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildExpenseItem(String category, double amount, IconData icon) {
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
            child: Icon(
              icon,
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

  Widget _buildSetExpensesSection(BuildContext context) {
    return Obx(
      () => Column(
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
                onPressed: () {
                  _showBudgetBottomSheet(context);
                },
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
              ...controller.categories.map((category) {
                return _buildCategoryCard(
                  category.name.capitalizeFirst!,
                  'Rwf ${category.totalAmount(controller.transactions.where((t) {
                    final now = DateTime.now();
                    return t.timestamp
                            .isAfter(DateTime(now.year, now.month, 1)) &&
                        t.type.toString() == TransactionType.SENT.toString() &&
                        t.category == category.name;
                  }).toList())}',
                  Color(
                    (math.Random().nextDouble() * 0xFFFFFF).toInt(),
                  ).withOpacity(0.15),
                  icons[category.icon]?.icon ?? Icons.cancel,
                );
              }),
              _buildCategoryCard(
                'Others',
                'Rwf ${controller.transactions.fold<int>(
                  0,
                  (prev, element) {
                    DateTime now = DateTime.now();
                    if (element.timestamp
                            .isAfter(DateTime(now.year, now.month, 1)) &&
                        element.type.toString() ==
                            TransactionType.SENT.toString() &&
                        element.category == null) {
                      return prev + element.amount;
                    }
                    return prev;
                  },
                )}',
                Colors.grey[200]!,
                Icons.home,
              ),
            ],
          ),
          Spacing.vertical(Spacing.l)
        ],
      ),
    );
  }

  Widget _buildCategoryCard(
      String title, String amount, Color backgroundColor, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(Spacing.m),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              icon,
              color: AppColors.primary,
              size: 20,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            title,
            style: AppTypography.bodySmall.copyWith(
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            amount,
            style: AppTypography.bodySmall.copyWith(
              fontSize: 8,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
